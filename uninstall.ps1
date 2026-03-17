$paths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenInClaudeCode"
    "HKCU:\Software\Classes\Directory\Background\shell\OpenInClaudeCode"
)
foreach ($p in $paths) {
    if (Test-Path $p) {
        Remove-Item -Path $p -Recurse -Force
    }
}
Write-Host "Open in Claude Code removed from the context menu." -ForegroundColor Green
