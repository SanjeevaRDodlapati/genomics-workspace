#!/bin/bash
# Sync all repositories and push changes

echo "🔄 Syncing all repositories..."

# Update submodules
./scripts/update_all_submodules.sh

# Commit submodule updates
if [[ -n $(git diff --name-only) ]]; then
    echo "📝 Committing submodule updates..."
    git add .
    git commit -m "chore: update all submodules to latest commits"
fi

# Push meta-repository
echo "⬆️  Pushing meta-repository..."
git push origin main

# Push individual repositories
for repo in UAVarPrior GenomicLightning FuGEP TransMet; do
    if [[ -d "$repo" ]]; then
        echo "⬆️  Pushing $repo..."
        cd "$repo"
        git push origin main
        cd ..
    fi
done

echo "✅ All repositories synced!"
