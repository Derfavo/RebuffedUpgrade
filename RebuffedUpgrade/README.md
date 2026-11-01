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

Stable versions are published as GitHub Releases with tags such as `v1.2.3`. The first number changes for incompatible changes, the second for new features, and the third for fixes. See [Releases](https://github.com/Derfavo/RebuffedUpgrade/releases) for downloads and release notes.

The addon displays a chat notice at login when the external checker has found a newer stable release. `/rebuffedupdates` lists installed versions and the time of the last successful check. WoW cannot query GitHub itself. Install the optional checker in [tools](../tools/README.md) for automatic background checks on Windows. It never downloads or installs addon updates.

Checks run every five minutes, with successful GitHub results cached for fifteen minutes. Login notices use the result available when the client loads the addons. A result received while WoW is already running appears after a full game restart. Network failures keep the previous result and its original timestamp; an unavailable check does not mean the addon is up to date.

To update manually, download the latest release's source ZIP, close WoW, extract it and copy the `RebuffedUpgrade` folder into `Interface/AddOns/`, replacing the previous folder. Do not copy the outer repository folder. Your settings in WTF remain untouched. Keep the checker outside the addon folder so updates do not replace the running checker.
