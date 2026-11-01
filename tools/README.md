# Automatic update checks on Windows

This optional checker queries the four public Rebuffed addon repositories. It writes version numbers and check times to `VersionStatus.lua` in installed addons. It never installs updates, sends chat messages or reads character settings. There is no continuous process and no in-game polling.

Python 3.9 or newer is required. Copy this tools folder somewhere outside `Interface/AddOns`, then run this once to check your installation:

```powershell
python check_updates.py --game-path "C:\Games\World of Warcraft"
```

To set up automatic checks, run `./Install-UpdateChecks.ps1 -GamePath "C:\Games\World of Warcraft"` once from PowerShell in this tools folder. The installer copies the checker to `%LOCALAPPDATA%/RebuffedAddons/` and registers the `RebuffedAddonUpdateCheck` task at sign-in and every five minutes. You can also configure Windows Task Scheduler manually to run the command above every five minutes while signed in. Use `pythonw.exe` instead of `python.exe` to hide the console window. Set the task to avoid overlapping runs and stop after two minutes. Run it with your normal Windows account; administrator rights are not needed if the game folder is writable.

Successful results are cached for fifteen minutes. The cache and a short error log are stored in `%LOCALAPPDATA%/RebuffedAddons/`. The checker only contacts GitHub's public releases API. On failure it keeps the last successful result. A game already running needs a full restart to read new results.

To stop automatic checks, disable or remove the scheduled task. The in-game addons continue to work without the checker. `/rebuffedupdates` shows the stored results and their dates.
