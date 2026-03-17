$cli = (Get-Command claude -ErrorAction SilentlyContinue).Source
if (-not $cli) {
    $cli = "$env:LOCALAPPDATA\Claude\claude.exe"
    if (-not (Test-Path $cli)) { $cli = $null }
}
if (-not $cli) { Write-Host "Claude Code not found." -ForegroundColor Red; exit 1 }
$paths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenInClaudeCode"
    "HKCU:\Software\Classes\Directory\Background\shell\OpenInClaudeCode"
)
foreach ($p in $paths) {
    $commandPath = "$p\command"
    $desiredCommand = "`"$cli`""
    $existingCommand = (Get-ItemProperty -Path $commandPath -Name "(Default)" -ErrorAction SilentlyContinue)."(Default)"
    if ($existingCommand -eq $desiredCommand) { continue }
    New-Item -Path $commandPath -Force | Out-Null
    Set-ItemProperty -Path $p -Name "(Default)" -Value "Open in Claude Code"
    Set-ItemProperty -Path $p -Name "Icon" -Value "$cli,0"
    Set-ItemProperty -Path $commandPath -Name "(Default)" -Value $desiredCommand
}
Write-Host "Open in Claude Code added to the context menu." -ForegroundColor Green
