import Foundation

struct Lesson: Identifiable { let id, title, body: String; let bad, good: String?; let drill: String }
struct Course: Identifiable { let id, title, subtitle, icon: String; let lessons: [Lesson] }
struct Option { let text: String; let best: Bool; let why: String }
struct Scenario: Identifiable { let id, title, setup: String; let options: [Option] }
struct Deck: Identifiable { let id, title, subtitle, icon: String; let items: [String] }
struct Video: Identifiable { let id, title, channel: String }  // id = YouTube video id

private func L(_ id: String, _ title: String, _ body: String, bad: String? = nil, good: String? = nil, drill: String) -> Lesson {
    Lesson(id: id, title: title, body: body, bad: bad, good: good, drill: drill)
}
private func O(_ text: String, _ why: String, best: Bool = false) -> Option { Option(text: text, best: best, why: why) }

enum Content {
    static let allLessons: [Lesson] = courses.flatMap { $0.lessons }
    static func course(of lesson: Lesson) -> Course { courses.first { $0.lessons.contains { $0.id == lesson.id } }! }

    // MARK: - Courses

    static let courses: [Course] = [
        Course(id: "presence", title: "Magnetic Presence", subtitle: "The foundation everything else is built on", icon: "sparkles", lessons: [
            L("p1", "The Charisma Formula", """
            Charisma isn't a personality type. It's a set of behaviors, and people read them within seconds. Researchers break it into three signals: **presence**, **warmth**, and **power**.

            **Presence** means you're actually here: not scanning the room, not rehearsing your next line. **Warmth** means they feel you like them. **Power** means you seem at ease, like you could handle whatever comes up.

            Most people fail at presence. While the other person talks, they're drafting a reply. People feel that, even if they can't name it. The fix is simple and hard: pay attention to them, not to yourself.
            """, drill: "In your next three conversations, notice each time your mind drifts to what *you'll* say next. Gently bring your focus back to their face and their words."),

            L("p2", "Slow Down to Stand Out", """
            Speed reads as nervousness. Confident people talk a little slower, pause before answering, and don't rush to fill space.

            Three quick upgrades:
            • **Pause** a beat before you answer. It makes you look thoughtful, not stuck.
            • **End sentences with a downward tone.** Rising at the end sounds like a question and asks for approval.
            • **Drop the filler.** Every "like," "kinda," and "I guess" shrinks what you're saying.
            """, bad: "So yeah, I'm, like, kind of a designer? I guess?", good: "I'm a designer. (pause) Mostly apps, and lately, a lot of coffee.", drill: "Record a 60-second voice memo about your day at about 80% of your normal speed. Play it back. Notice how much more certain you sound."),

            L("p3", "Body Language That Invites", """
            Before you say a word, your body has already made the introduction.

            • **Eye contact:** hold it about 60 to 70 percent of the time while listening, a bit less while talking. Hold it through the end of a sentence, then look away slowly, not suddenly.
            • **Orientation:** point your torso and feet at the person you're talking to. Half-turned says "I'm about to leave."
            • **Open posture:** shoulders relaxed and down, hands visible, arms uncrossed. Take up your space.
            • **Stillness:** fidgeting leaks anxiety. Calm hands read as calm mind.
            """, drill: "Next conversation: hold eye contact until they finish their sentence, then let your gaze drift away slowly. Notice how much more connected it feels."),

            L("p4", "Warmth First, Always", """
            People answer two questions about you almost instantly: *Do they mean well?* and *Can they act on it?* Warmth is judged first, and it colors everything after.

            Lead with warmth: a real smile that reaches your eyes, using their name once or twice, and a clear signal that you're glad to be talking to them. Competence without warmth comes off as cold. Warmth plus quiet confidence is magnetic.

            A trick that works: before you walk in, think of three things you genuinely appreciate about people. Your face changes, and people feel it.
            """, drill: "Before your next social situation, spend 30 seconds imagining you're about to see an old friend you love. Walk in carrying that feeling."),
        ]),

        Course(id: "open", title: "Opening Any Conversation", subtitle: "Start talking to anyone, anywhere", icon: "hand.wave.fill", lessons: [
            L("o1", "The 3-Second Rule", """
            The longer you wait, the bigger the moment gets in your head. After about three seconds, your brain starts building reasons not to.

            Here's the secret: **your opening line matters far less than you think.** People respond to your energy, your smile, and your ease, not to a clever script. "Hey, I had to come say hi" works fine when it's said with warmth.

            Move before the doubt shows up. You'll figure out the rest once you're talking.
            """, drill: "Today, when you feel the urge to talk to someone, count 3-2-1 and open your mouth. Say anything. The goal is the reflex, not the result."),

            L("o2", "Observation + Question", """
            The most reliable opener you'll ever use: **notice something you both share, comment on it, then ask about it.**

            You share the environment, so anything around you is fair game: the line, the music, the weather, the food, the event. It feels natural because it *is* natural. You're just two people in the same place.

            Add a little personality to the observation and it gets even better.
            """, bad: "Hey, how's it going?", good: "This line is moving like a DMV. Is the food here actually worth it, or are we all just victims of hype?", drill: "Use three observation + question openers today: a barista, a coworker, someone in a line. Keep it light."),

            L("o3", "Statements Beat Questions", """
            Question after question turns a conversation into an interview. Statements, especially playful guesses about the other person, invite them to react, correct you, and play along.

            This is called **cold reading**: make a light, flattering guess about them. If you're right, they feel seen. If you're wrong, they get to correct you and tell a story. You win either way.
            """, bad: "So where are you from? What do you do?", good: "You have strong 'knows every good restaurant in the city' energy. Am I wrong?", drill: "Make one playful guess about someone today: \"You seem like the planner of your friend group.\" Watch how much more they open up."),

            L("o4", "Give Them Something to Grab", """
            When you introduce yourself, don't stop at your name. Attach a **hook**: a small detail they can ask about or joke with.

            Hooks turn dead ends into threads. The same goes for any question you answer. Give the answer, then add one extra detail, feeling, or opinion that opens a door.
            """, bad: "I'm Sam.", good: "I'm Sam. I'm the friend who got dragged here and is now secretly having the best time.", drill: "Write your go-to intro with a hook and use it the next time you meet someone."),

            L("o5", "The Graceful Exit", """
            How a conversation ends is how it's remembered. Leave **on a high**, while the energy is good, instead of waiting for it to fizzle.

            A good exit has three parts: a reason, an appreciation, and a door left open. Leaving early and warmly makes people want more of you. Letting it drag makes them relieved when you go.
            """, bad: "(Waiting until the silence gets unbearable) So... yeah. Cool.", good: "I have to go find my friend, but I really enjoyed this. You still owe me the rest of that Lisbon story.", drill: "End your next conversation at a high point, even if you'd like to keep going. Notice how people react when they see you later."),
        ]),

        Course(id: "flow", title: "Conversation Flow", subtitle: "Never run out of things to say", icon: "arrow.triangle.branch", lessons: [
            L("f1", "Threading", """
            Every answer someone gives you contains **multiple threads**: topics you can pull on. Running out of things to say really means not noticing the threads.

            "I just got back from Lisbon for work" has at least four: *Lisbon*, *travel*, *their work*, and *just got back* (tired? happy to be home?). Pick the thread with the most **emotion or story** in it, not the most facts.
            """, bad: "Oh cool. So what do you do?", good: "What surprised you most about Lisbon? I've heard the food alone is worth the flight.", drill: "In your next conversation, after each answer, silently list two threads before you respond. Pick the more interesting one."),

            L("f2", "Ask Why, Not What", """
            *What* questions get facts. *Why* and *how* questions get stories, and stories are where connection happens.

            "What do you do?" gets a job title. "What got you into that?" gets a life story. "How did that feel?" gets an emotion. Emotions make people remember you.
            """, bad: "What do you do? Where do you work? How long have you been there?", good: "What pulled you into that line of work? Was it a plan or a happy accident?", drill: "Replace every 'what' question you'd normally ask today with a 'why' or 'how' version."),

            L("f3", "Share, Then Ask", """
            Good conversation is ping-pong, not an interrogation. After they share, **share something of your own that relates**, then pass it back.

            Match their level of openness, then go *one step* deeper. That's how you get from small talk to real talk without it feeling forced. If you only ask questions, you're a mystery in the bad way. If you only talk, you're a monologue.
            """, bad: "(Five questions in a row, no personal info)", good: "Same, I moved here on a whim too. Best and scariest decision I've made. What made you finally pull the trigger?", drill: "Use the share → ask rhythm at least three times in one conversation today."),

            L("f4", "Killing Awkward Silences", """
            Silence isn't failure. It only becomes awkward when someone *acts* awkward about it. A comfortable pause with a relaxed smile actually builds intimacy.

            When you want to restart, you have three easy moves:
            • **Callback:** "Wait, go back. You said you almost moved to Japan?"
            • **Environment:** comment on something around you.
            • **Thought share:** "Random thought, but..." and share what's on your mind.

            Never apologize for a silence. It tells both of you it was a problem.
            """, drill: "Next time a silence hits, count to three while smiling before you speak. Then use a callback."),

            L("f5", "Remember and Call Back", """
            Few things make someone feel more valued than hearing you remember a detail they mentioned in passing: the name of their dog, the exam they were stressed about, the trip they were planning.

            In the same conversation, callbacks show you were really listening. Days later, they're powerful: "How did the interview go?" People remember who remembered them.
            """, drill: "After a conversation today, write down two details about the person. Bring one up the next time you talk."),
        ]),

        Course(id: "interesting", title: "Being Interesting", subtitle: "Become someone people remember", icon: "star.fill", lessons: [
            L("i1", "Specificity Is Charisma", """
            Vague is forgettable. Specific is magnetic. "I like music" gives the other person nothing. "I've been obsessed with 70s Japanese city pop lately" gives them five things to ask about.

            The details are the interesting part: names, places, odd little facts, exactly how something felt. Specifics make you sound like a real person with a real life, because you are.
            """, bad: "I'm into movies, and I travel sometimes.", good: "I just watched a four-hour Russian film on purpose, and I'm still deciding if I'm proud or concerned.", drill: "Take your three most common answers (what you do, what you did this weekend, your hobbies) and rewrite each with one specific detail."),

            L("i2", "Tell Stories, Not Reports", """
            A report lists what happened. A story makes people *feel* it. Use this structure and keep it under a minute:

            1. **Hook:** "The worst date of my life started with a goat."
            2. **Setup:** who, where, just enough context.
            3. **Tension:** what went wrong or what was at stake.
            4. **Payoff:** the twist, the punchline, or how you felt.

            Cut every detail that doesn't serve the payoff. Then stop talking and let them react.
            """, drill: "Build three go-to stories with this structure: one funny, one embarrassing, one meaningful. Tell one this week."),

            L("i3", "Have a Take", """
            Neutral is safe, and safe is boring. People remember those who have **opinions**, especially light, playful ones they can argue with.

            "Breakfast for dinner is objectively the best meal." "Airports are underrated. They're the only place where drinking at 9am is normal." Playful disagreement creates energy fast.

            Keep early takes light (food, movies, habits) and save heavy topics for when there's trust.
            """, bad: "I don't know, I'm fine with anything.", good: "Controversial, but I think the sequel was better, and I will defend that until I die.", drill: "Come up with five low-stakes hot takes. Drop one into a conversation this week and enjoy the debate."),

            L("i4", "Curious Beats Impressive", """
            Trying to impress puts the spotlight on you. Being curious puts it on them, and people love whoever makes them feel interesting.

            The old line holds up: people forget what you said, but they remember how you made them feel. Follow-up questions, real reactions, and genuine interest make people walk away thinking *that was one of the best conversations I've had in a while*.
            """, drill: "In one conversation today, make your only goal to find the most interesting thing about the other person."),

            L("i5", "Answer Boring Questions Interestingly", """
            You'll get "What do you do?" and "How was your weekend?" a thousand times. Don't give the boring answer. Give **the answer plus a hook**: a joke, a feeling, or an unexpected detail.

            You're not dodging the question. You're giving them more to work with.
            """, bad: "I'm an accountant.", good: "I'm an accountant, so I'm the person everyone suddenly remembers exists in April.", drill: "Write an 'answer + hook' version of your job, your weekend, and where you're from. Use them this week."),
        ]),

        Course(id: "humor", title: "Humor & Playfulness", subtitle: "Make conversations feel like play", icon: "face.smiling.fill", lessons: [
            L("h1", "Don't Be Funny, Be Playful", """
            You don't need jokes. Scripted jokes are risky and put pressure on you. **Playfulness** is different: it's a mindset of not taking the moment too seriously.

            Playful people exaggerate, tease the situation, laugh at themselves, and treat small moments as fun. The humor comes from being at ease, not from punchlines.
            """, drill: "Today, look for one small thing you can treat as a bit of a game: a slow elevator, a weird menu item, an overly serious sign."),

            L("h2", "Playful Misinterpretation", """
            Deliberately take what they said the "wrong" way, or draw a ridiculous conclusion from it. It's one of the easiest humor tools there is.

            The key is a light tone and a smile. It's clearly a game, so they get to play along.
            """, bad: "I love hiking. → Oh nice, cool.", good: "I love hiking. → So you're one of those people who wakes up at 5am *on purpose*. Concerning.", drill: "Use one playful misinterpretation in a conversation today."),

            L("h3", "Exaggeration", """
            Take something ordinary and blow it up to an absurd scale. It works because it's obviously not literal. It shows you have imagination and don't take things too seriously.

            "My commute was bad" is a fact. "I've aged about four years on the freeway this morning" is a moment.
            """, bad: "Yeah, the meeting was long.", good: "The meeting was so long I think I missed a birthday. Possibly my own.", drill: "Exaggerate one complaint or story today. Go further than feels comfortable."),

            L("h4", "Tease With Warmth", """
            Light teasing creates chemistry. It signals confidence and treats the other person as an equal who can take a joke. But there are rules:

            • **Tease choices, never insecurities.** Their coffee order, yes. Their weight, never.
            • **Smile while you do it.** Your tone makes it clear it's affection.
            • **Follow up with sincerity.** Teasing plus genuine warmth is the combo.

            If it would sting, skip it.
            """, bad: "Wow, you're really short.", good: "Oat milk, extra shot, half sweet? You're high-maintenance. I respect it.", drill: "Tease one friend about a harmless choice today, then give them a sincere compliment later in the conversation."),

            L("h5", "Callbacks & Inside Jokes", """
            A callback is bringing back something funny from earlier in the conversation. It gets a bigger laugh than the original, because now it's *yours*: a shared reference.

            Inside jokes create a sense of history, fast. Two strangers with an inside joke after 15 minutes feel like old friends.
            """, drill: "When something funny happens early in a conversation, bring it back at least once later."),
        ]),

        Course(id: "intrigue", title: "Intrigue & Attraction", subtitle: "Create desire, curiosity, and spark", icon: "heart.fill", lessons: [
            L("a1", "Don't Tell Everything", """
            Mystery pulls people in. When you share everything right away, your whole story is spent in ten minutes. Leave some threads open.

            Answer partly, then hint that there's more. You're not being fake, you're giving them a reason to want the next conversation.
            """, bad: "(A detailed ten-minute account of your entire trip)", good: "Long story involving a canoe and a very angry swan. I'll tell you sometime, if you earn it.", drill: "Once today, hint at a story instead of telling it. See if they ask for it later."),

            L("a2", "Push-Pull, Playfully", """
            Attraction thrives on a little tension. **Push-pull** means mixing genuine interest with a playful challenge, so things never feel one-note.

            "You're kind of great. Terrible taste in pizza, but great." The "pull" shows interest. The "push" keeps it playful and shows you're not just trying to please.

            Important: this is about fun tension, never putting someone down. If they'd walk away feeling worse about themselves, you did it wrong.
            """, bad: "You're so amazing, I agree with everything you said!", good: "Okay, you're officially interesting. That pineapple pizza opinion, though... we might have a problem.", drill: "Use one playful push-pull line with someone you're comfortable with."),

            L("a3", "Compliment Choices, Not Features", """
            People hear compliments about their looks all the time. They're pleasant but forgettable, and they can feel generic.

            Compliment what they **chose**: their style, their taste, their opinions, the way they tell a story, their energy. It shows you're noticing *them*, not just a face. Specific beats general every time.
            """, bad: "You're really pretty.", good: "You have this calm way of telling stories that makes everyone lean in. That's rare.", drill: "Give one specific, choice-based compliment today, then move on without waiting for a reaction."),

            L("a4", "Make Them Feel Seen", """
            The deepest attraction comes from feeling *understood*. Listen for what someone cares about beneath the surface, then reflect it back.

            "It sounds like freedom really matters to you." "You light up when you talk about your brother." When you name something true that they didn't say directly, it creates a powerful moment of connection.
            """, drill: "In a deeper conversation, listen for the value or feeling behind the story. Name it gently and see how they respond."),

            L("a5", "Leave Them Wanting More", """
            End on a peak, not a slow fade. The last few minutes of a conversation are what people remember most.

            And if you want to see them again, don't be vague. "We should hang out sometime" rarely happens. Tie the invite to something from your conversation, and make it specific.
            """, bad: "We should hang out sometime, maybe.", good: "We clearly need to settle this taco debate properly. Thursday, 7pm, the place on 5th?", drill: "Next time you're enjoying a conversation, end it at the high point with a specific next step."),

            L("a6", "Texting With Spark", """
            Texting is a bridge between meetings, not a substitute for them.

            • **Reference a shared moment:** callbacks work great over text.
            • **Keep it short and light.** Long paragraphs early on feel heavy.
            • **Don't interview.** Share thoughts, reactions, and little observations.
            • **Move toward meeting.** The goal is the next time you see them.
            """, bad: "Hey", good: "Still thinking about your wildly wrong opinion on pineapple pizza. This needs to be settled in person.", drill: "Send one text today that references something specific from your last conversation with someone."),
        ]),

        Course(id: "listen", title: "Deep Listening", subtitle: "The most underrated charm skill", icon: "ear.fill", lessons: [
            L("l1", "Listen to Understand", """
            Most people listen to reply. They're waiting for their turn, scanning for a chance to talk about themselves. Being the rare person who actually listens is almost a superpower.

            Listening shows: in your eyes, your nods, your small reactions ("no way," "wait, really?"), and above all in the questions you ask next.
            """, drill: "In one conversation today, don't share anything about yourself until the other person has spoken for at least two minutes."),

            L("l2", "Mirroring", """
            Repeat the last one to three key words someone said, with a curious tone. It sounds too simple to work, but it does. People almost always elaborate.

            It shows you're listening and gets them to go deeper without you having to come up with a question.
            """, bad: "I moved to Denver on a whim. → Oh, cool.", good: "I moved to Denver on a whim. → On a whim?", drill: "Use mirroring three times in one conversation. Count how often they tell you more."),

            L("l3", "Label the Emotion", """
            When someone shares something, name the feeling you hear: "It sounds like that was really frustrating." "Seems like you're proud of that, and you should be."

            Labeling makes people feel deeply understood. Even if you guess wrong, they'll correct you and explain, which builds connection anyway.
            """, drill: "Label one emotion today: \"Sounds like...\" or \"Seems like...\""),

            L("l4", "The Follow-Up Question", """
            Research from Harvard found that people who ask more **follow-up questions** are rated as more likeable. Not just more questions, but *follow-ups*, which prove you heard the last answer.

            Before changing topics, ask two or three follow-ups. Go deeper instead of wider.
            """, bad: "Nice. So, have you seen any good movies lately?", good: "Wait, you quit your job to do that? What was the moment you knew?", drill: "In your next conversation, ask at least two follow-ups before switching topics."),
        ]),

        Course(id: "confidence", title: "Unshakeable Confidence", subtitle: "Talk to anyone without the fear", icon: "bolt.fill", lessons: [
            L("c1", "Outcome Independence", """
            Nervousness comes from needing something from the interaction: approval, a number, a laugh. When you need something, you get tense and people feel it.

            Shift your goal: **you're not trying to get anything. You're offering a good moment.** If they're not in the mood, that's information, not rejection. You're the one deciding whether *you* enjoy the conversation, too.
            """, drill: "Before your next conversation, set the intention: \"I'm just here to have a good time and give one.\""),

            L("c2", "The Exposure Ladder", """
            Confidence is built, not found. It comes from evidence: doing the scary thing and surviving. Climb one step at a time:

            1. Make eye contact and smile at strangers.
            2. Say hi or thank people with genuine warmth.
            3. Give a stranger a compliment.
            4. Ask someone a quick question.
            5. Have a two-minute conversation with a stranger.
            6. Invite someone new to do something.

            Stay on a step until it feels easy, then climb.
            """, drill: "Find your current step on the ladder. Do it five times this week."),

            L("c3", "Recovering From Awkward Moments", """
            You will stumble, blank out, or say something weird. Everyone does. What matters is how you react.

            Awkwardness only sticks when you're embarrassed about it. Name it with a smile and it becomes charming. People trust someone who can laugh at themselves.
            """, bad: "(Freezing up, apologizing, then going quiet)", good: "Wow, that sounded much better in my head. Let me try that again.", drill: "Next time you stumble, name it out loud with a laugh instead of hiding it."),

            L("c4", "Your Pre-Game Routine", """
            Show up ready instead of hoping confidence arrives on its own:

            • **Physiological sigh:** two quick inhales through the nose, one long exhale through the mouth. Repeat three times. It calms your nervous system fast.
            • **Open posture:** stand tall, shoulders back, for a minute.
            • **Warm up:** chat with a low-stakes person (cashier, host) first to get the words flowing.
            • **Set an intention:** "I'm curious about people tonight."
            """, drill: "Try the full routine before your next social event."),

            L("c5", "Self-Talk That Works", """
            "Don't be awkward" is a terrible instruction. It points your mind straight at the thing you fear.

            Swap self-judgment for curiosity. Instead of "What will they think of me?", ask "What's interesting about them?" Instead of "I'm bad at this," try "I'm getting better at this." Your inner voice sets your outer energy.
            """, drill: "Write down your most common negative thought before socializing. Write a curious replacement. Read it before you go out."),
        ]),
    ]

    // MARK: - Videos per course (ids verified against YouTube oEmbed, 2026-09-22)

    static let videos: [String: [Video]] = [
        "presence": [
            Video(id: "cef35Fk7YD8", title: "You Are Contagious", channel: "Vanessa Van Edwards · TEDx"),
            Video(id: "fA28iMu0lAc", title: "6 Habits That Make First Impressions Amazing", channel: "Charisma on Command"),
            Video(id: "eIho2S0ZahI", title: "How to Speak So That People Want to Listen", channel: "Julian Treasure · TED"),
        ],
        "open": [
            Video(id: "NzVrmGjsGWo", title: "How To Spark Interest In Every Conversation", channel: "Charisma on Command"),
        ],
        "flow": [
            Video(id: "R1vskiVDwl4", title: "10 Ways to Have a Better Conversation", channel: "Celeste Headlee · TED"),
            Video(id: "ITIjlB5Gj3A", title: "Do These 8 Things and People Will Want You Around", channel: "Charisma on Command"),
        ],
        "interesting": [
            Video(id: "x7p329Z8MD0", title: "Homework for Life", channel: "Matthew Dicks · TEDx"),
        ],
        "humor": [
            Video(id: "q0--oItSgUY", title: "How To Turn Anything Into A Witty Joke", channel: "Charisma on Command"),
            Video(id: "6G7pNhZA0LU", title: "How To Easily Be Funnier In Conversations", channel: "Chris Williamson"),
        ],
        "intrigue": [
            Video(id: "05vQ08uH-s0", title: "6 Flirting Habits Women Actually Love", channel: "Charisma on Command"),
            Video(id: "3aYWvujaT6M", title: "Falling in Love Is the Easy Part", channel: "Mandy Len Catron · TED"),
            Video(id: "d6wG_sAdP0U", title: "How I Hacked Online Dating", channel: "Amy Webb · TED"),
            Video(id: "SBmzQixzi0g", title: "Hinge's Relationship Scientist Gives Dating Advice", channel: "Logan Ury · Chris Williamson"),
            Video(id: "EFJsMK77dm0", title: "How To Make Dating Apps Human Again", channel: "Matthew Hussey"),
            Video(id: "MntNpCJAq5k", title: "How to Take Photos for Tinder, Bumble & Hinge", channel: "Dater Help"),
            Video(id: "Vp3D50dLdIA", title: "The Perfect Hinge Prompt Formula", channel: "WingMan Plus"),
            Video(id: "mIU1Wi1Q1hM", title: "3 Playful Texts That Lead To A Date", channel: "Matthew Hussey"),
            Video(id: "PNSzPazO9JQ", title: "These Texting Mistakes Keep You Single", channel: "Matthew Hussey"),
        ],
        "listen": [
            Video(id: "XuMsG-PoIPE", title: "Master Labels, Mirrors & Questions", channel: "Chris Voss · Black Swan Group"),
        ],
        "confidence": [
            Video(id: "-vZXgApsPCQ", title: "What I Learned from 100 Days of Rejection", channel: "Jia Jiang · TED"),
        ],
    ]

    // MARK: - Practice scenarios

    static let scenarios: [Scenario] = [
        Scenario(id: "s1", title: "Party, know no one", setup: "You're at a friend's party and don't know anyone. Someone is standing alone near the snacks.", options: [
            O("Stand nearby and wait for them to say something.", "Waiting hands all the control to chance. They're probably waiting too."),
            O("\"Hey... so, do you know anyone here?\"", "Not bad, it's friendly. But it's low energy and centers the awkwardness."),
            O("\"I've been guarding these chips for ten minutes and they might be the best part of this party. Have you tried the guac?\"", "Observation + playful exaggeration + an easy question. Low pressure, instant personality.", best: true),
        ]),
        Scenario(id: "s2", title: "\"I work in marketing\"", setup: "You ask someone what they do. They say: \"I work in marketing.\"", options: [
            O("\"Oh, cool.\"", "A dead end. You've given them nothing to respond to."),
            O("\"Which company? What's your title? How long have you been there?\"", "Rapid-fire facts feel like a job interview."),
            O("\"So you're the reason I bought a $40 water bottle last month. What got you into it?\"", "Playful tease plus a 'why' question. It invites a story instead of a fact.", best: true),
        ]),
        Scenario(id: "s3", title: "The awkward silence", setup: "Five minutes into a good conversation, you both go quiet. It's starting to feel long.", options: [
            O("\"Sorry, I'm bad at this.\"", "Apologizing confirms the silence was a problem and lowers the energy."),
            O("\"Wait, go back. You said you almost moved to Japan. What stopped you?\"", "A callback shows you were listening and reopens a juicy thread.", best: true),
            O("\"So... yeah.\"", "Fills the silence without giving it anywhere to go."),
        ]),
        Scenario(id: "s4", title: "Their big win", setup: "Someone excitedly tells you they just ran their first marathon.", options: [
            O("\"Nice! I ran two last year.\"", "One-upping steals their moment. Even if it's true, save it."),
            O("\"What was going through your head at mile 20?\"", "Goes straight for the emotional part of the story and lets them relive the win.", best: true),
            O("\"Wow, I could never do that.\"", "Kind, but it turns the focus to you and closes the topic."),
        ]),
        Scenario(id: "s5", title: "Compliment on a date", setup: "You're on a first date and it's going well. You want to give a compliment.", options: [
            O("\"You're really hot.\"", "Flattering but generic. They've heard it before, and it can feel shallow this early."),
            O("\"You're not like other people.\"", "A cliché that quietly insults everyone else and sounds scripted."),
            O("\"I love the way your face lights up when you talk about your sister. You'd clearly go to war for her.\"", "Specific, about who they are, and shows you're paying attention.", best: true),
        ]),
        Scenario(id: "s6", title: "The joke that flopped", setup: "You make a joke and it lands with total silence.", options: [
            O("Explain why the joke was supposed to be funny.", "Explaining makes it worse and shows you're rattled."),
            O("Smile: \"That was much funnier in my head. Much funnier.\"", "Owning it with humor turns a flop into a genuine laugh.", best: true),
            O("Go quiet and quickly change the subject.", "Signals embarrassment. The awkwardness sticks around."),
        ]),
        Scenario(id: "s7", title: "Texting after meeting", setup: "You met someone great yesterday and got their number. Time to text.", options: [
            O("\"Hey\"", "Gives them all the work and nothing to respond to."),
            O("A long paragraph about how much you enjoyed meeting them.", "Too much, too soon. It creates pressure instead of intrigue."),
            O("\"Still thinking about your wildly wrong pineapple pizza opinion. This needs to be settled in person. Tacos Thursday?\"", "A callback to a shared moment, playful, and it moves toward meeting.", best: true),
        ]),
        Scenario(id: "s8", title: "\"So what do you do?\"", setup: "At a networking event, someone asks what you do. You're a software engineer.", options: [
            O("\"I'm a software engineer.\"", "Accurate but flat. Nothing for them to grab onto."),
            O("\"I'm a software engineer, so I spend my days arguing with computers and occasionally winning. What about you?\"", "Answer + hook + hand-off. Easy to respond to and memorable.", best: true),
            O("Explain your tech stack and current project in detail.", "Too much detail too early. Match their interest level first."),
        ]),
        Scenario(id: "s9", title: "Elevator with a coworker", setup: "You're alone in the elevator with a coworker you barely know.", options: [
            O("Look at your phone.", "Safe, but you miss an easy chance to build a connection."),
            O("\"Is it just me, or does this elevator get slower every week?\"", "Light observation about a shared experience. Zero pressure, instant rapport.", best: true),
            O("\"Hi.\"", "Polite, but it doesn't open anything."),
        ]),
        Scenario(id: "s10", title: "They open up", setup: "Someone says: \"My dad was sick this year. It's been a lot.\"", options: [
            O("\"Oh, that sucks. Anyway...\"", "Brushes past a vulnerable moment. They'll close up."),
            O("\"That sounds really heavy. How are you holding up with all of it?\"", "Labels the emotion and makes space for them. This is how trust is built.", best: true),
            O("\"My grandma was sick too.\" (then telling your story)", "Relating can help later, but right now it shifts the spotlight to you."),
        ]),
        Scenario(id: "s11", title: "Time to leave", setup: "You've been talking to someone for a while. It's been good, but you need to go.", options: [
            O("Keep talking until it naturally dies out.", "Ending on a fizzle means that's what they'll remember."),
            O("\"I've got to catch my friend before they leave, but this was great. Let's get that coffee you mentioned.\"", "Reason + appreciation + an open door, while the energy is still high.", best: true),
            O("Just slip away when they look at their phone.", "Feels cold and leaves things unfinished."),
        ]),
        Scenario(id: "s12", title: "They tease you", setup: "Someone says, smiling: \"You definitely take 45 minutes to order at restaurants.\"", options: [
            O("\"No I don't! That's not true.\"", "Getting defensive kills the playful energy."),
            O("\"45? Rude. It's at least an hour. I interview the waiter.\"", "Agree and amplify. You played along, showed confidence, and kept the game going.", best: true),
            O("Laugh awkwardly and say nothing.", "Misses the invitation to play."),
        ]),
        Scenario(id: "s13", title: "Joining a group", setup: "A group of three is laughing together at an event. You'd like to join.", options: [
            O("Walk up and start a new topic.", "Interrupting their flow creates friction."),
            O("Hover at the edge silently all night.", "Waiting for a perfect invite that won't come."),
            O("Step in at the edge, listen, laugh along, then add to the current topic.", "Joining their energy first earns you a natural way in.", best: true),
        ]),
        Scenario(id: "s14", title: "One-word answers", setup: "Everything you ask gets a one-word answer: \"Good.\" \"Yeah.\" \"Work.\"", options: [
            O("Keep firing questions until something sticks.", "More questions means more pressure. It becomes an interrogation."),
            O("Share something about yourself with a hook, then see if they engage. If not, exit warmly.", "Gives them easy material. If they still don't bite, it's not about you.", best: true),
            O("Assume they hate you and walk off.", "They might just be shy, tired, or having a bad day."),
        ]),
        Scenario(id: "s15", title: "Coffee shop crush", setup: "Someone attractive at the coffee shop has been smiling at their book for ten minutes.", options: [
            O("Stare until they notice you.", "Uncomfortable for them, and you still haven't said anything."),
            O("\"I need to know what that book is. You've been grinning at it for ten minutes.\"", "Observation + curiosity + a subtle signal that you noticed them.", best: true),
            O("\"Hey, can I get your number?\"", "Skips connection entirely. There's no reason for them to say yes yet."),
        ]),
    ]

    // MARK: - Toolkit decks

    static let decks: [Deck] = [
        Deck(id: "social", title: "Party & Social Openers", subtitle: "Parties, bars, events", icon: "party.popper.fill", items: [
            "How do you know the host? I need to know who to blame for this playlist.",
            "Okay, settle this: is it acceptable to leave a party without saying goodbye?",
            "You look like you're having the most fun here. What's your secret?",
            "I've decided you're the most interesting person here, so I'm starting with you.",
            "What's the best thing that's happened to you this week?",
            "Be honest: are you here for the people or the food?",
            "I'm doing a survey. What's the most overrated thing everyone pretends to love?",
            "You have the energy of someone with a great story from last weekend. Am I right?",
        ]),
        Deck(id: "daily", title: "Everyday Openers", subtitle: "Coffee shops, gyms, lines, stores", icon: "cup.and.saucer.fill", items: [
            "Is that drink actually good, or are you just being brave?",
            "Quick question: what's the one thing on this menu I shouldn't miss?",
            "This line is my cardio for today.",
            "You look like you know what you're doing. Is that machine as evil as it looks?",
            "I need a second opinion. Which of these would you pick?",
            "What are you reading? You've been fully absorbed for ten minutes.",
            "Is it just me, or does this place always play the exact same five songs?",
            "I'm stealing your order next time. What is that?",
        ]),
        Deck(id: "work", title: "Work & Networking", subtitle: "Conferences, offices, meetups", icon: "briefcase.fill", items: [
            "What's the most interesting thing you've worked on this year?",
            "What brought you to this event: work, or the free coffee?",
            "What's something about your job that would surprise people?",
            "If you weren't doing this, what would you be doing?",
            "What's the best talk or idea you've heard today?",
            "What's keeping you busy these days outside of work?",
            "How did you end up in this field? Plan or happy accident?",
            "What's a trend in your industry you think is overhyped?",
        ]),
        Deck(id: "deep", title: "Deeper Questions", subtitle: "Go past small talk", icon: "water.waves", items: [
            "What's something you're weirdly proud of?",
            "What's a belief you had five years ago that you've completely changed?",
            "What does a perfect day look like for you?",
            "What's something you want to do before you're too old to enjoy it?",
            "Who has had the biggest influence on who you are?",
            "What's a small thing that makes your day noticeably better?",
            "What are you most looking forward to right now?",
            "What do people usually get wrong about you?",
            "What would you do if you knew nobody would judge you?",
            "What's the best advice you've ever ignored?",
        ]),
        Deck(id: "playful", title: "Playful Questions", subtitle: "Spark fun and banter", icon: "dice.fill", items: [
            "Would you rather have a rewind button or a pause button for your life?",
            "What's your most irrational fear?",
            "What's a hill you'd happily die on?",
            "If you had a warning label, what would it say?",
            "What's your go-to karaoke song, and how well does it go?",
            "What fictional world would you actually want to live in?",
            "What's the most useless talent you have?",
            "If your life had a theme song, what would it be right now?",
            "What's the most 'you' thing you've ever done?",
            "Pineapple on pizza: yes or no? Choose carefully.",
        ]),
        Deck(id: "silence", title: "Silence Savers", subtitle: "Restart a stalled conversation", icon: "lifepreserver.fill", items: [
            "Wait, go back to what you said about... I need the full story.",
            "Random thought, but I just realized...",
            "Okay, completely different question: what's your guilty pleasure show?",
            "I'm curious, what's been on your mind lately?",
            "That reminds me of the time I...",
            "Can I ask you something slightly strange?",
            "What's the best thing you've eaten recently? I'm always looking for recommendations.",
            "Have you been anywhere recently that surprised you?",
        ]),
        Deck(id: "text", title: "Texting Openers", subtitle: "Reconnect with spark", icon: "message.fill", items: [
            "Still thinking about [thing they said]. I need a follow-up.",
            "Saw something today that made me think of you. [photo]",
            "Update: I tried [thing they recommended]. You were right. I hate that you were right.",
            "Okay, settle a debate: [playful either/or question]",
            "Important question: what are you having for dinner?",
            "How did [thing they mentioned] go? I've been wondering.",
            "I owe you a story from this weekend. It involves [intriguing detail].",
            "Name one thing that made you smile today. Go.",
        ]),
        Deck(id: "exit", title: "Graceful Exits", subtitle: "Leave on a high note", icon: "door.right.hand.open", items: [
            "I have to go find my friend, but this was genuinely great.",
            "I'm going to grab a drink. It was really nice meeting you.",
            "I'll let you get back to your night. I'm glad we talked.",
            "I need to run, but you owe me the end of that story next time.",
            "I want to say hi to a few people, but let's continue this later.",
            "This was the best conversation I've had all night. Let's do it again.",
        ]),
    ]

    // MARK: - Daily

    static let challenges: [String] = [
        "Start a conversation with a stranger using an observation + question.",
        "Hold eye contact until the end of someone's sentence, all day.",
        "Give someone a specific compliment about something they chose.",
        "Ask three follow-up questions before changing topics.",
        "Tell one short story using the hook → setup → tension → payoff structure.",
        "Use mirroring (repeat their last few words) three times.",
        "Share a playful hot take and defend it with a smile.",
        "Leave a conversation at its high point, with a warm exit.",
        "Make one playful guess about someone: \"You seem like the type who...\"",
        "Speak 20 percent slower than usual in every conversation today.",
        "Text someone a callback to something from your last conversation.",
        "Label someone's emotion: \"Sounds like that was...\"",
        "Answer 'How are you?' with something specific, not 'good'.",
        "Introduce yourself to someone new with a hook attached to your name.",
        "Let a silence sit for three seconds while smiling before you fill it.",
        "Tease a friend about a harmless choice, then follow up with something sincere.",
        "Ask someone 'what got you into that?' and let them tell the whole story.",
        "Remember one detail from a conversation and bring it up next time.",
        "Use exaggeration to describe something ordinary about your day.",
        "Say hi to three people you'd normally walk past.",
        "Ask someone for a recommendation, then really dig into why they love it.",
    ]

    static let tips: [String] = [
        "People remember **how you made them feel** far longer than anything you said.",
        "Your opening line matters less than your energy. Smile first, words second.",
        "Every answer has several threads. Pull the one with the most emotion.",
        "Silence isn't awkward until someone acts awkward about it.",
        "Compliment what people **choose**, not what they were born with.",
        "Ask 'why' and 'how' for stories, not 'what' for facts.",
        "End conversations at the peak. They'll want more of you.",
        "Specific is magnetic. Vague is forgettable.",
        "Being interested is more attractive than being interesting.",
        "Tease choices, never insecurities.",
        "A callback to something they said earlier shows you were really listening.",
        "Nervous? Slow down. Speed reads as anxiety; pauses read as confidence.",
        "When you stumble, name it with a laugh. Awkwardness only sticks if you're embarrassed.",
        "Don't tell the whole story at once. Leave a thread for next time.",
        "Point your feet and torso toward the person you're talking to.",
        "Before a big conversation, try a physiological sigh: two inhales, one long exhale.",
        "Match their openness, then go one step deeper.",
        "Rejection is information, not a verdict on you.",
        "Make specific plans. 'We should hang out sometime' almost never happens.",
        "Presence is the rarest gift. Put the phone away and be fully there.",
        "Confidence is evidence: every conversation you start adds to the pile.",
    ]
}
