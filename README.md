# RebuffedUpgrade

Adds an equipment recommendation for your current specialization to item tooltips. Ratings use the existing Wowhead scales in **Pawn 1.3.8 for WoW 3.3.5a**. Pawn must be installed and enabled separately.

Your specialization is detected from allocated talent points and updated when you switch dual specs. To distinguish Feral tank from damage and Death Knight tank from damage, the addon also uses assigned roles, form or presence. If the role is unclear, it avoids a definite recommendation.

## Recommendations

- **Upgrade:** The rating is higher than your equipped item.
- **Small upgrade:** The improvement is less than one percent.
- **Not an upgrade:** The rating is lower for the selected specialization.
- **Check manually:** Requirements, set bonuses, unknown effects or a weapon set change need a closer comparison.
- **Cannot equip:** Your character has not reached the required level.

Rings and trinkets are compared against the weaker equipped slot. A two-handed weapon is compared against the combined main hand and off hand. Titan's Grip and identical unique-equipped items are accounted for.

The percentage is a change in Pawn score, not a prediction of damage or healing gained. Both items are compared without enchants and with Pawn's socket valuation. Hit and defense caps, set bonuses, trinket effects and group loot rules may give you a reason to choose differently.

## Commands

The command words below are literal and remain the same on English clients.

| Command | What it does |
| --- | --- |
| `/upgrade` | Show the active rating scale |
| `/upgrade auto` | Enable automatic specialization detection |
| `/upgrade skalen` | List available Pawn scales |
| `/upgrade skala NAME` | Use a specific Pawn scale, with its exact name from the list |

The selection is saved per character. Edit custom weights in Pawn.

Only items you view are calculated. Results are cached and invalidated when your equipment, talents or Pawn settings change. Missing item data is retried for up to two seconds. Other players are not inspected.

The tooltip addition accounts for rebuilds by Pawn and Auctionator. Auctionator itself is not modified. The addon does not automatically roll for, loot or buy items.

## Versions and update notices

Stable versions are published as GitHub Releases using `major.minor.patch` tags. The first number changes for incompatible changes, the second for new features, and the third for fixes. See [Releases](https://github.com/Derfavo/RebuffedUpgrade/releases) for downloads and release notes.

Update detection runs entirely inside WoW, using the same approach as DBM: addon messages exchange installed versions with other users in your party, raid and guild. Checks start automatically at login and when group or guild membership changes. Messages are hidden addon traffic, not ordinary chat. Replies are delayed and throttled to avoid repeated traffic during raid invites.

A newer version must be reported by two different players before the addon warns you. Future release dates are rejected. Confirmed versions are saved, so the notice can also appear at later logins. Each addon warns at most once per newer version per session. `/rebuffedupdates` shows your installed versions and any confirmed updates.

This does not contact GitHub or check a central server. If nobody you meet has a newer copy, the addon cannot know that a new release exists. No Windows task, external checker or automatic installation is used. DBM itself is not required.

To update, download the latest release's source ZIP, close WoW, extract it and copy the `RebuffedUpgrade` folder into `Interface/AddOns/`, replacing the previous folder. Do not copy the outer repository folder. Your settings in WTF remain untouched.
