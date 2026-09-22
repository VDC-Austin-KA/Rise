import SwiftUI
import UIKit

@main
struct SparkApp: App {
    @StateObject private var store = Store()

    var body: some Scene {
        WindowGroup {
            TabView {
                TodayView().tabItem { Label("Today", systemImage: "sun.max.fill") }
                LearnView().tabItem { Label("Learn", systemImage: "book.fill") }
                PracticeView().tabItem { Label("Practice", systemImage: "bubble.left.and.bubble.right.fill") }
                ToolkitView().tabItem { Label("Toolkit", systemImage: "sparkles") }
            }
            .environmentObject(store)
            .tint(.orange)
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Progress (UserDefaults; ids are lesson ids, scenario ids, and "c:<day>" for challenges)

final class Store: ObservableObject {
    @Published var done: Set<String> { didSet { UserDefaults.standard.set(Array(done), forKey: "done") } }
    @Published var streak: Int { didSet { UserDefaults.standard.set(streak, forKey: "streak") } }
    @Published var lastDay: Int { didSet { UserDefaults.standard.set(lastDay, forKey: "lastDay") } }

    init() {
        done = Set(UserDefaults.standard.stringArray(forKey: "done") ?? [])
        streak = UserDefaults.standard.integer(forKey: "streak")
        lastDay = UserDefaults.standard.integer(forKey: "lastDay")
    }

    static var today: Int { Calendar.current.ordinality(of: .day, in: .era, for: Date()) ?? 0 }
    var currentStreak: Int { lastDay >= Store.today - 1 ? streak : 0 }

    func complete(_ id: String) {
        done.insert(id)
        let today = Store.today
        guard lastDay != today else { return }
        streak = lastDay == today - 1 ? streak + 1 : 1
        lastDay = today
    }
}

// MARK: - Styling

let brand = LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
let brandSoft = LinearGradient(colors: [.orange.opacity(0.35), .pink.opacity(0.35)], startPoint: .topLeading, endPoint: .bottomTrailing)

extension View {
    func card(_ color: Color = Color(.secondarySystemBackground)) -> some View {
        padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

func rich(_ s: String) -> AttributedString {
    (try? AttributedString(markdown: s, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))) ?? AttributedString(s)
}

// MARK: - Today

struct TodayView: View {
    @EnvironmentObject var store: Store
    private var challengeId: String { "c:\(Store.today)" }
    private var challenge: String { Content.challenges[Store.today % Content.challenges.count] }
    private var tip: String { Content.tips[Store.today % Content.tips.count] }
    private var nextLesson: Lesson? { Content.allLessons.first { !store.done.contains($0.id) } }
    private var lessonsDone: Int { Content.allLessons.filter { store.done.contains($0.id) }.count }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        StatTile(icon: "flame.fill", value: "\(store.currentStreak)", label: "day streak")
                        StatTile(icon: "book.fill", value: "\(lessonsDone)/\(Content.allLessons.count)", label: "lessons")
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Label("Today's challenge", systemImage: "target").font(.headline).foregroundStyle(brand)
                        Text(challenge).font(.title3.weight(.semibold))
                        let isDone = store.done.contains(challengeId)
                        Button {
                            store.complete(challengeId)
                        } label: {
                            Label(isDone ? "Done. Nice work." : "I did it", systemImage: isDone ? "checkmark.circle.fill" : "circle")
                                .bold().frame(maxWidth: .infinity).padding(.vertical, 4)
                        }
                        .buttonStyle(.borderedProminent)
                        .allowsHitTesting(!isDone)
                    }
                    .card()

                    if let lesson = nextLesson {
                        NavigationLink { LessonView(lesson: lesson) } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("CONTINUE LEARNING").font(.caption.bold()).foregroundStyle(.secondary)
                                    Text(lesson.title).font(.title3.bold())
                                    Text(Content.course(of: lesson).title).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.secondary)
                            }
                            .card()
                        }
                        .buttonStyle(.plain)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Label("Tip of the day", systemImage: "lightbulb.fill").font(.headline).foregroundStyle(.yellow)
                        Text(rich(tip))
                    }
                    .card()
                }
                .padding()
            }
            .navigationTitle("Today")
        }
    }
}

struct StatTile: View {
    let icon: String, value: String, label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: icon).font(.title3).foregroundStyle(brand)
            Text(value).font(.title.bold())
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
        .card()
    }
}

// MARK: - Learn

struct LearnView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationStack {
            List(Content.courses) { course in
                NavigationLink { CourseView(course: course) } label: {
                    HStack(spacing: 14) {
                        Image(systemName: course.icon).font(.title2).foregroundStyle(brand).frame(width: 36)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(course.title).font(.headline)
                            Text(course.subtitle).font(.subheadline).foregroundStyle(.secondary)
                            ProgressView(value: Double(course.lessons.filter { store.done.contains($0.id) }.count),
                                         total: Double(course.lessons.count))
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Learn")
        }
    }
}

struct CourseView: View {
    @EnvironmentObject var store: Store
    let course: Course

    var body: some View {
        List {
            Section { Text(course.subtitle).foregroundStyle(.secondary) }
            ForEach(Array(course.lessons.enumerated()), id: \.element.id) { i, lesson in
                NavigationLink { LessonView(lesson: lesson) } label: {
                    let isDone = store.done.contains(lesson.id)
                    Label {
                        Text(lesson.title)
                    } icon: {
                        Image(systemName: isDone ? "checkmark.circle.fill" : "\(i + 1).circle")
                            .foregroundStyle(isDone ? Color.green : Color.secondary)
                    }
                }
            }
        }
        .navigationTitle(course.title)
    }
}

struct LessonView: View {
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) private var dismiss
    let lesson: Lesson

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text(lesson.title).font(.largeTitle.bold())
                Text(rich(lesson.body)).lineSpacing(4)

                if let bad = lesson.bad, let good = lesson.good {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Instead of", systemImage: "xmark.circle.fill").font(.caption.bold()).foregroundStyle(.red)
                        Text(bad).italic()
                        Divider()
                        Label("Try", systemImage: "checkmark.circle.fill").font(.caption.bold()).foregroundStyle(.green)
                        Text(good).italic()
                    }
                    .card()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Label("Drill", systemImage: "flag.fill").font(.headline).foregroundStyle(.orange)
                    Text(rich(lesson.drill))
                }
                .card(Color.orange.opacity(0.15))

                Button {
                    store.complete(lesson.id)
                    dismiss()
                } label: {
                    Text(store.done.contains(lesson.id) ? "Completed ✓" : "Mark complete")
                        .bold().frame(maxWidth: .infinity).padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Practice

struct PracticeView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Real situations. Pick what you'd say, then see why it lands or doesn't.")
                        .foregroundStyle(.secondary)
                }
                ForEach(Content.scenarios) { s in
                    NavigationLink { ScenarioView(scenario: s) } label: {
                        let isDone = store.done.contains(s.id)
                        Label {
                            Text(s.title)
                        } icon: {
                            Image(systemName: isDone ? "checkmark.seal.fill" : "questionmark.bubble.fill")
                                .foregroundStyle(isDone ? Color.green : Color.orange)
                        }
                    }
                }
            }
            .navigationTitle("Practice")
        }
    }
}

struct ScenarioView: View {
    @EnvironmentObject var store: Store
    let scenario: Scenario
    @State private var options: [Option]
    @State private var picked: Int?

    init(scenario: Scenario) {
        self.scenario = scenario
        _options = State(initialValue: scenario.options.shuffled())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text(scenario.setup).font(.title3.weight(.semibold)).card(Color.orange.opacity(0.15))
                Text(picked == nil ? "What do you say?" : "The breakdown")
                    .font(.headline).foregroundStyle(.secondary)

                ForEach(options.indices, id: \.self) { i in
                    let o = options[i]
                    Button {
                        guard picked == nil else { return }
                        withAnimation { picked = i }
                        if o.best { store.complete(scenario.id) }
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Text(o.text).multilineTextAlignment(.leading)
                                Spacer()
                                if picked != nil {
                                    Image(systemName: o.best ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundStyle(o.best ? Color.green : Color.red)
                                }
                            }
                            if picked != nil {
                                Text(o.why).font(.subheadline).foregroundStyle(.secondary)
                            }
                        }
                        .card(cardColor(i))
                    }
                    .buttonStyle(.plain)
                }

                if let p = picked {
                    Text(options[p].best ? "Nailed it. 🔥" : "Not quite. Read the green one out loud a few times.")
                        .font(.headline)
                    Button("Try again") {
                        withAnimation { options.shuffle(); picked = nil }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .navigationTitle(scenario.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func cardColor(_ i: Int) -> Color {
        guard let p = picked else { return Color(.secondarySystemBackground) }
        if options[i].best { return Color.green.opacity(0.18) }
        return i == p ? Color.red.opacity(0.18) : Color(.secondarySystemBackground)
    }
}

// MARK: - Toolkit

struct ToolkitView: View {
    var body: some View {
        NavigationStack {
            List(Content.decks) { deck in
                NavigationLink { DeckView(deck: deck) } label: {
                    Label {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(deck.title).font(.headline)
                            Text(deck.subtitle).font(.caption).foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: deck.icon).foregroundStyle(brand)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Toolkit")
        }
    }
}

struct DeckView: View {
    let deck: Deck
    @State private var order: [String]
    @State private var index = 0

    init(deck: Deck) {
        self.deck = deck
        _order = State(initialValue: deck.items.shuffled())
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(order[index])
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .padding(24)
                    .frame(maxWidth: .infinity, minHeight: 220)
                    .background(brandSoft, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .id(index)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)).combined(with: .opacity))

                HStack {
                    Button { UIPasteboard.general.string = order[index] } label: {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    .buttonStyle(.bordered)
                    Button { withAnimation(.spring()) { index = (index + 1) % order.count } } label: {
                        Label("Next", systemImage: "arrow.right").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("ALL \(deck.items.count)").font(.caption.bold()).foregroundStyle(.secondary)
                    ForEach(deck.items, id: \.self) { item in
                        Text(item).font(.subheadline)
                        Divider()
                    }
                }
                .card()
            }
            .padding()
        }
        .navigationTitle(deck.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
