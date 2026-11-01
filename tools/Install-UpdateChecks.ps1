param(
    [Parameter(Mandatory=$true)][string]$GamePath,
    [string]$PythonPath
)
$ErrorActionPreference = 'Stop'
$GamePath = [IO.Path]::GetFullPath($GamePath)
if (-not (Test-Path -LiteralPath (Join-Path $GamePath 'Interface\AddOns'))) { throw 'Choose the WoW folder containing Interface/AddOns.' }
if (-not $PythonPath) {
    $pythonCommand = Get-Command python.exe -ErrorAction Stop
    $PythonPath = Join-Path (Split-Path -Parent $pythonCommand.Source) 'pythonw.exe'
}
if (-not (Test-Path -LiteralPath $PythonPath)) { throw 'Python 3 with pythonw.exe is required.' }
$support = Join-Path $env:LOCALAPPDATA 'RebuffedAddons'
New-Item -ItemType Directory -Path $support -Force | Out-Null
$checker = Join-Path $support 'check_updates.py'
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'check_updates.py') -Destination $checker -Force
$taskName = 'RebuffedAddonUpdateCheck'
$existing = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existing -and ($existing.Actions.Execute -ne $PythonPath -or $existing.Actions.Arguments -notlike '*RebuffedAddons*check_updates.py*')) {
    throw 'A different task already uses this name. It was not replaced.'
}
$arguments = '"' + $checker + '" --game-path "' + $GamePath + '"'
$action = New-ScheduledTaskAction -Execute $PythonPath -Argument $arguments
$account = [Security.Principal.WindowsIdentity]::GetCurrent().Name
$principal = New-ScheduledTaskPrincipal -UserId $account -LogonType Interactive -RunLevel Limited
$triggers = @(
    (New-ScheduledTaskTrigger -AtLogOn -User $account),
    (New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 5))
)
$settings = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 2) -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$task = New-ScheduledTask -Action $action -Trigger $triggers -Principal $principal -Settings $settings -Description 'Check public Rebuffed addon releases and write login notices. Never install updates.'
Register-ScheduledTask -TaskName $taskName -InputObject $task -Force | Out-Null
Start-ScheduledTask -TaskName $taskName
Write-Output 'Automatic checks enabled at Windows sign-in and every five minutes. Addon downloads remain manual.'
