# Verified Requirements from Robert’s NHL App Discussion

## Recording scope

The relevant discussion starts at approximately **21:27** in the original recording. The focused transcript begins seven seconds earlier at 21:20 for context. Robert’s app discussion runs primarily through approximately **29:10**, with one short clarification near **32:20–32:44**.

## Product concept

Robert runs a private, weekly NFL pick’em pool for roughly **200 people**. Each entry card costs **$10**, and an individual can submit multiple cards. The app should replace the current paper flyer, manual payment checking, Excel transcription, weekly spreadsheet distribution, and manual scoring process.

## Confirmed participant workflow

1. A person receives a link by text and enters the private portal.
2. The person signs in or verifies their identity.
3. The person selects how many entry cards they want for the week.
4. For each card, the person pays or submits payment evidence; Robert mentioned Zelle/Cash App/Venmo and indicated an authenticatable record is required before a card is accepted.
5. The person makes a winner pick for each NFL game that week and enters a predicted combined score for Monday Night Football.
6. The person submits the card before the weekly deadline.
7. The user can later sign in to see their cards and, after submission, the group’s picks and leaderboard.

## Confirmed contest rules

| Rule | Detail |
|---|---|
| Entry price | $10 per card |
| Frequency | Weekly NFL slate |
| Cards | Multiple cards per person are allowed |
| Picks | Winner of each game only; no spread or over/under |
| Tiebreaker | Closest predicted combined score for Monday Night Football |
| Deadline | Intended to close around Saturday 12:00 a.m. / before the earliest weekly game; must accommodate unusual early international games |
| Winner | Highest correct-pick total; tiebreaker resolves ties |
| Access | Participants need a profile and the ability to see their submissions; group results/picks are visible after submission |

## Existing experience to retain

Robert has already prototyped screens including **Enter the Contest**, **Make Your Picks**, **My Cards**, an NFL schedule, payment status, and a leaderboard. The new build should preserve this simple flow while adding secure authentication, a reliable data store, payment verification, automated scoring, and outbound reminders.

## Administration needs

- One owner/admin controls each weekly contest, schedule, deadlines, payment status, results, and winner.
- Payments may need manual verification if using person-to-person payment apps.
- The system needs an exception log for late picks, voided cards, corrections, and payment disputes.
- Automated reminders should be available before the deadline.
- Robert’s stated organizer economics (a percentage off the top and free entries) should be modeled as internal administration only and reviewed for legal compliance before implementation.

## Key nonfunctional needs

- Mobile-first design because the portal is distributed through text messages.
- Easy sharing through a stable short link.
- Capacity for at least 200 users and many cards per week.
- Audit trail: submission timestamp, payment status, immutable submitted picks, and scoring changes.
- Privacy controls appropriate for a friends-only group.

## Safety / compliance note

A paid NFL pick’em pool can be regulated as gambling, lottery, sweepstakes, or a skill contest depending on jurisdiction and how the pool operates. Before accepting entry fees or taking an organizer percentage, obtain advice from a qualified local gaming/contest attorney and align the product rules, eligibility, payments, tax reporting, and geography controls to that advice.
