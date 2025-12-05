param(
    [string]$branch = "main",                # default branch
    [string]$message = "update"              # default commit message
)

Write-Host "📂 Adding all changes..."
git add --all

Write-Host "📝 Committing changes with message: $message"
git commit -m "$message"

if ($LASTEXITCODE -eq 0) {
    Write-Host "🔄 Pulling latest changes from origin/$branch..."
    git pull origin $branch

    if ($LASTEXITCODE -eq 0) {
        Write-Host "🚀 Pushing to GitHub (origin)..."
        git push origin $branch

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ GitHub push successful. Now pushing to GitLab..."
            git push gitlab $branch
            if ($LASTEXITCODE -eq 0) {
                Write-Host "🎉 Push completed to BOTH GitHub and GitLab."
            } else {
                Write-Host "❌ Failed to push to GitLab."
            }
        } else {
            Write-Host "❌ Failed to push to GitHub. Skipping GitLab push."
        }
    } else {
        Write-Host "❌ Git pull failed. Aborting push."
    }
} else {
    Write-Host "⚠️ No changes to commit or commit failed. Aborting."
}
