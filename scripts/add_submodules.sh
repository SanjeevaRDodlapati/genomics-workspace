#!/bin/bash
# Add existing repositories as submodules

echo "🔗 Adding existing repositories as submodules..."

# Note: You'll need to update these URLs to match your GitHub accounts
# For now, we'll use placeholder URLs

echo "📁 Adding UAVarPrior submodule..."
git submodule add https://github.com/SanjeevaRDodlapati/UAVarPrior.git UAVarPrior

echo "📁 Adding GenomicLightning submodule..."  
git submodule add https://github.com/SanjeevaRDodlapati/GenomicLightning.git GenomicLightning

echo "📁 Adding FuGEP submodule..."
git submodule add https://github.com/SanjeevaRDodlapati/FuGEP.git FuGEP

echo "📁 Adding TransMet submodule..."
git submodule add https://github.com/SanjeevaRDodlapati/TransMet.git TransMet

echo "✅ All submodules added!"
echo ""
echo "🔧 To initialize submodules:"
echo "   git submodule update --init --recursive"
