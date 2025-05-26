#!/bin/bash
# Update all submodules to latest commits

echo "🔄 Updating all submodules..."

git submodule update --remote --merge

echo "✅ All submodules updated!"
echo ""
echo "📋 Current submodule status:"
git submodule status
