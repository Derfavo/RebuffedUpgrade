# Changelog

## 1.0.4

- Prevent guild version messages when the character has no confirmed guild membership.
- Handle numeric zero membership flags and wait for a nonempty guild name.
- Recheck membership before sending a delayed message.

## 1.0.3

- Replace the external checker with automatic version exchanges inside the game, following DBM's approach.
- Require reports from two different players before warning about a newer release.
- Remember confirmed newer versions for later logins.
- Remove the Windows checker and its setup tools. Downloads remain manual.


## 1.0.2

- Publish the addon in its own repository with stable version tags and release notes.
- Add login notices for newer releases found by the optional background checker.
- Add `/rebuffedupdates` to show installed versions and cached check results.
- Keep downloads and installation manual.
