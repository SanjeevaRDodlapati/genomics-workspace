#!/bin/bash
# Monitoring dashboard for genomics workspace

echo "📊 GENOMICS WORKSPACE MONITORING DASHBOARD"
echo "=========================================="
echo "📅 $(date)"
echo ""

projects=("UAVarPrior" "GenomicLightning" "FuGEP" "TransMet")

for project in "${projects[@]}"; do
    if [ -d "/home/sdodl001/$project" ]; then
        cd "/home/sdodl001/$project"
        
        echo "📈 $project Status:"
        echo "   📊 Commits: $(git rev-list --count HEAD 2>/dev/null || echo '0')"
        echo "   🧹 Working tree: $([ $(git status --porcelain | wc -l) -eq 0 ] && echo 'Clean' || echo 'Has changes')"
        echo "   📦 Monitoring files: $(find . -name "*_report_*.json" -o -name "*_$(date +%Y%m%d)*.json" | wc -l)"
        echo "   🔒 Security: $([ -f .gitmessage ] && echo 'Standards applied' || echo 'Check needed')"
        echo ""
    fi
done

echo "🚀 QUICK ACTIONS:"
echo "1. Run health check: python3 /home/sdodl001/github_automation/core_scripts/repo_health_monitor.py [project_path]"
echo "2. Run dependency check: python3 /home/sdodl001/github_automation/core_scripts/check_dependencies.py [project_path]"
echo "3. Check release readiness: python3 /home/sdodl001/github_automation/core_scripts/auto_release.py [project_path]"
