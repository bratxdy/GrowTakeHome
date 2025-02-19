Welcome! We’re glad you’re interested in joining the team at Grow Therapy!
This is an iOS Swift assessment, and your submission should showcase your capabilities. The
product requirements consist of a pseudo-realistic product scenario. Your goal is to build a
working app to match the design spec. A successful project will present a working app
end-to-end, demonstrate knowledge of iOS best practices, and utilize readable Swift code.
As a growing startup, we often encounter decisions that require us to make trade offs between
simplicity vs. complexity, architecting for today vs. laying foundation for the future. Imagine you
are building this as a first version of many versions, for an app that’s intended to grow and
change over time. How can you design this in a way that’s easily extendable for future
requirements while keeping the level of complexity right-sized for the design today?
This assessment calls for building a small app, sample code from another project, and an
associated writeup.
We politely ask you not to share your solutions online. We also ask you to spend no more than a
few hours on this exercise. Good luck!
Product Spec
Background
On their mental health journey, Grow Therapy clients may receive from their provider a schedule
of tasks that support their progress. This could include breathing exercises and a mood
check-in, to track change over time. While today this is only offered informally at the provider’s
discretion, one opportunity presented by a mobile app is to systematize the assignment and
completion of this “homework.”
Imagine that a user opens their app to find a list of “My Tasks.” When a task is eligible, the user
can tap into it to be guided through the task.
If a requirement or constraint is ambiguous, make your own decision and provide the rationale
in your writeup.
Design in Figma
See mocks here
Product requirements:
- Task list
○ The user sees their list of tasks to complete over time, with assigned dates.
○ A user can complete a task as soon as the date is today. Tasks that are in the
future are always locked.

○ Only one task can be eligible at a time.
○ If a task has been completed, it shows the date it was completed.
- Breathing exercise
○ For each task, the user is assigned to take a certain number of slow, deep
breaths.
○ The screen shows the countdown, and an animation of a circle growing and
shrinking to guide the inhale and exhale.

- “Telehealth” session
○ As part of every task, the user must join a (mock) telehealth session with a
provider, represented by a simple screen with text.
○ Typically users complete the breathing exercise before they are connected to a
provider. If the provider comes online mid-exercise, the user has the option
whether to finish or join the session right away.
○ If a user taps into a task and someone is available, then to maximize time
together, the breathing exercise is skipped and they will be connected right away.
○ See the flow diagram below for the order of screens.
○ When the session is exited, the task is considered complete.

Key technical requirements:
- SwiftUI is required.
- The data is contained in the file `tasks.json`. The data is formatted in an array with this
order: [breath count, mood choices, due date]
- For simplicity, get the task list data by including the file `tasks.json` in the bundle. (In real
life, this data would be downloaded from an API.)
- The app will need to know whether a provider is in the session. For this project, feel free
to mock that behavior as you see fit or how you would during the normal course of
developing a feature. The goal of mocking here is to be able to develop this spec

correctly, so the mocking does not need to be robust as long as the UI works as
intended.
- Build for iOS 17.0+.
- Feel free to use any tools that you would normally in the course of your work.

Bonus feature:
If you complete the above requirements and would like to progress further, add another feature
for a mood log.
- Mood log
○ Once the therapy session has ended, the user is prompted to log their mood on
that day.
○ The user sees a list of options for mood words, which are task dependent.
○ Optionally show the mood that was logged for completed tasks on the task list.
○ Optionally allow users, who have finished breathwork and are waiting for their
provider, to log their mood. However, make sure that before a task can be
completed, the mood must be logged at some point.

Writeup
- Suggest 3 ways this project can be extended to improve the app.
- Provide a brief overview of the top 3 significant architectural decisions you made.
- Mention any product requirements that you needed to make your own decision on, and
why you made that choice.
- If you use any code assistance tools, please briefly describe what you used and how you
used them.

Code Sample
- We know a take-home can’t convey the full capabilities of an engineer, so we additionally
invite you to submit a code sample from another project. This can demonstrate your skill
set, a challenging technical problem you’ve solved, and/or something you’re particularly
proud of.
- In your writeup, please give a brief overview of this sample.
Submission
- For the source code, please send either as a zipped project or submit as a link to a
GitHub repo.
- For the responses, email a PDF of your writeup.
