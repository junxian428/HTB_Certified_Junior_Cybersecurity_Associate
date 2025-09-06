# push-both.ps1
Write-Host "🚀 Pushing to GitHub (origin)..."
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ GitHub push successful. Now pushing to GitLab..."
    git push gitlab main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "🎉 Push completed to BOTH GitHub and GitLab."
    } else {
        Write-Host "❌ Failed to push to GitLab."
    }
} else {
    Write-Host "❌ Failed to push to GitHub. Skipping GitLab push."
}
