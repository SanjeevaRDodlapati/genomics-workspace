#!/bin/bash
# Enhanced cleanup plan for /home/sdodl001
# This script further organizes the home directory

echo "🌟 ENHANCED HOME DIRECTORY CLEANUP"
echo "=================================="
echo ""

# Define base directories
HOME_DIR="/home/sdodl001"
ORG_DIR="${HOME_DIR}/genomics-git-organization"
SYS_DIR="${HOME_DIR}/system-utils"
WORKSPACE_DIR="${HOME_DIR}/genomics-workspace"
NOTEBOOKS_DIR="${ORG_DIR}/notebooks"
CONFIG_DIR="${ORG_DIR}/configuration"

# 1. Create additional organization directories
echo "📁 Creating additional organization directories..."
mkdir -p ${SYS_DIR}/{logs,temp,backups}
mkdir -p ${NOTEBOOKS_DIR}/{analysis,tutorials,exploratory}
mkdir -p ${CONFIG_DIR}/{vscode,workspaces,shell}
mkdir -p ${ORG_DIR}/temp

# 2. Organize additional scripts
echo ""
echo "🔄 Moving script files to appropriate directories..."

# Move GitHub setup scripts to github_automation
if [ -f "${HOME_DIR}/complete_github_setup.csh" ]; then
  mkdir -p "${HOME_DIR}/github_automation/setup_scripts"
  mv "${HOME_DIR}/complete_github_setup.csh" "${HOME_DIR}/github_automation/setup_scripts/"
  ln -sf "${HOME_DIR}/github_automation/setup_scripts/complete_github_setup.csh" "${HOME_DIR}/complete_github_setup.csh"
  echo "✓ Moved complete_github_setup.csh to github_automation/setup_scripts/"
fi

if [ -f "${HOME_DIR}/DEPLOYMENT_SCRIPT_DIRECTORY.csh" ]; then
  mkdir -p "${HOME_DIR}/github_automation/deployment"
  mv "${HOME_DIR}/DEPLOYMENT_SCRIPT_DIRECTORY.csh" "${HOME_DIR}/github_automation/deployment/"
  ln -sf "${HOME_DIR}/github_automation/deployment/DEPLOYMENT_SCRIPT_DIRECTORY.csh" "${HOME_DIR}/DEPLOYMENT_SCRIPT_DIRECTORY.csh"
  echo "✓ Moved DEPLOYMENT_SCRIPT_DIRECTORY.csh to github_automation/deployment/"
fi

if [ -f "${HOME_DIR}/comprehensive_infrastructure_test.py" ]; then
  mkdir -p "${HOME_DIR}/github_automation/testing"
  mv "${HOME_DIR}/comprehensive_infrastructure_test.py" "${HOME_DIR}/github_automation/testing/"
  ln -sf "${HOME_DIR}/github_automation/testing/comprehensive_infrastructure_test.py" "${HOME_DIR}/comprehensive_infrastructure_test.py"
  echo "✓ Moved comprehensive_infrastructure_test.py to github_automation/testing/"
fi

# 3. Organize notebook files
echo ""
echo "📔 Organizing notebook files..."
mkdir -p "${NOTEBOOKS_DIR}/unsorted"

# Move notebook files
if [ -f "${HOME_DIR}/Untitled.ipynb" ]; then
  mv "${HOME_DIR}/Untitled.ipynb" "${NOTEBOOKS_DIR}/unsorted/"
  echo "✓ Moved Untitled.ipynb to notebooks/unsorted/"
fi

if [ -f "${HOME_DIR}/Untitled1.ipynb" ]; then
  mv "${HOME_DIR}/Untitled1.ipynb" "${NOTEBOOKS_DIR}/unsorted/"
  echo "✓ Moved Untitled1.ipynb to notebooks/unsorted/"
fi

# 4. Organize VS Code workspaces
echo ""
echo "🖥️ Organizing VS Code workspaces..."

if [ -f "${HOME_DIR}/genomic_projects.code-workspace" ]; then
  mv "${HOME_DIR}/genomic_projects.code-workspace" "${CONFIG_DIR}/workspaces/"
  ln -sf "${CONFIG_DIR}/workspaces/genomic_projects.code-workspace" "${HOME_DIR}/genomic_projects.code-workspace"
  echo "✓ Moved genomic_projects.code-workspace to configuration/workspaces/"
fi

if [ -f "${HOME_DIR}/.code-workspace.code-workspace" ]; then
  mv "${HOME_DIR}/.code-workspace.code-workspace" "${CONFIG_DIR}/workspaces/"
  ln -sf "${CONFIG_DIR}/workspaces/.code-workspace.code-workspace" "${HOME_DIR}/.code-workspace.code-workspace"
  echo "✓ Moved .code-workspace.code-workspace to configuration/workspaces/"
fi

# 5. Clean up log files not caught by additional_cleanup.sh
echo ""
echo "📋 Organizing log files..."

# Move java error logs
if [ -f "${HOME_DIR}/java_error_in_pycharm_241216.log" ]; then
  mkdir -p "${SYS_DIR}/logs/java"
  mv "${HOME_DIR}/java_error_in_pycharm_241216.log" "${SYS_DIR}/logs/java/"
  echo "✓ Moved java_error_in_pycharm_241216.log to system-utils/logs/java/"
fi

# 6. Organize temporary and backup files
echo ""
echo "🧹 Cleaning up temporary files..."

mkdir -p "${SYS_DIR}/temp/history_backups"
if [ -f "${HOME_DIR}/.wahab_bash_history-57914.tmp" ]; then
  mv "${HOME_DIR}/.wahab_bash_history-57914.tmp" "${SYS_DIR}/temp/history_backups/"
  echo "✓ Moved .wahab_bash_history-57914.tmp to system-utils/temp/history_backups/"
fi

if [ -f "${HOME_DIR}/.wahab_bash_history-51818.tmp" ]; then
  mv "${HOME_DIR}/.wahab_bash_history-51818.tmp" "${SYS_DIR}/temp/history_backups/"
  echo "✓ Moved .wahab_bash_history-51818.tmp to system-utils/temp/history_backups/"
fi

# 7. Create a test output directory
echo ""
echo "📊 Creating test output directory..."

mkdir -p "${SYS_DIR}/test_output"
if [ -f "${HOME_DIR}/test_output.txt" ]; then
  mv "${HOME_DIR}/test_output.txt" "${SYS_DIR}/test_output/"
  echo "✓ Moved test_output.txt to system-utils/test_output/"
fi

if [ -f "${HOME_DIR}/test.py" ]; then
  mkdir -p "${SYS_DIR}/test_scripts"
  mv "${HOME_DIR}/test.py" "${SYS_DIR}/test_scripts/"
  echo "✓ Moved test.py to system-utils/test_scripts/"
fi

# 8. Handle VSCode extension file
if [ -f "${HOME_DIR}/copilot.vsix" ]; then
  mkdir -p "${SYS_DIR}/vscode_extensions"
  mv "${HOME_DIR}/copilot.vsix" "${SYS_DIR}/vscode_extensions/"
  echo "✓ Moved copilot.vsix to system-utils/vscode_extensions/"
fi

# 9. Create an analysis script to identify remaining clutter
echo ""
echo "🔍 Creating analysis script for remaining files..."

cat > "${ORG_DIR}/utils/analyze_home_clutter.sh" << 'EOF'
#!/bin/bash
# Script to analyze remaining clutter in home directory

HOME_DIR="/home/sdodl001"
REPORT_FILE="${HOME_DIR}/HOME_CLEANUP_REPORT.md"

echo "# Home Directory Cleanup Report" > $REPORT_FILE
echo "Generated on $(date)" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "## Files directly in home directory" >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
find $HOME_DIR -maxdepth 1 -type f | sort | grep -v "HOME_CLEANUP_REPORT.md" >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "## Hidden files in home directory" >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
find $HOME_DIR -maxdepth 1 -type f -name ".*" | grep -v ".bash_history" | grep -v ".lesshst" | sort >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "## Top-level directories (excluding hidden)" >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
find $HOME_DIR -maxdepth 1 -type d -not -path "$HOME_DIR" -not -name ".*" | sort >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "## Hidden directories" >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
find $HOME_DIR -maxdepth 1 -type d -name ".*" | sort >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "## Large files (over 100MB)" >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE
find $HOME_DIR -type f -size +100M | xargs ls -lh 2>/dev/null | sort -k5hr >> $REPORT_FILE
echo "\`\`\`" >> $REPORT_FILE

echo "Home directory analysis complete! Report generated at $REPORT_FILE"
EOF

chmod +x "${ORG_DIR}/utils/analyze_home_clutter.sh"
ln -sf "${ORG_DIR}/utils/analyze_home_clutter.sh" "${HOME_DIR}/analyze_home.sh"

# 10. Update the gtools command to include analysis
echo ""
echo "🔄 Updating gtools with analysis capability..."

if [ -f "${ORG_DIR}/launcher/genomics-tools.sh" ]; then
  # Create a backup of existing file
  cp "${ORG_DIR}/launcher/genomics-tools.sh" "${ORG_DIR}/launcher/genomics-tools.sh.bak"
  
  # Replace the file with updated version that includes analyze option
  cat > "${ORG_DIR}/launcher/genomics-tools.sh" << 'EOF'
#!/bin/bash
# Unified launcher for genomics repository tools
function show_usage {
    echo "🧰 GENOMICS REPOSITORY TOOLS"
    echo "=========================="
    echo ""
    echo "Usage: $(basename "$0") <tool> [arguments]"
    echo ""
    echo "Available tools:"
    echo "  organization - Navigate the project organization (gitorg)"
    echo "  repository   - Manage repositories (repoutil)"
    echo "  verify       - Verify organization structure"
    echo "  analyze      - Analyze home directory clutter"
    echo "  status       - Show project status"
    echo "  intro        - Display project introduction"
    echo "  help         - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") organization scripts 5"
    echo "  $(basename "$0") repository status UAVarPrior"
    echo "  $(basename "$0") verify"
    echo "  $(basename "$0") analyze"
}

case "$1" in
    organization|org|o)
        shift
        /home/sdodl001/genomics-git-organization/utils/gitorg "$@"
        ;;
    repository|repo|r)
        shift
        /home/sdodl001/genomics-git-organization/utils/repoutil "$@"
        ;;
    verify|check|v)
        /home/sdodl001/genomics-git-organization/utils/verify_organization.sh
        ;;
    analyze|a)
        /home/sdodl001/genomics-git-organization/utils/analyze_home_clutter.sh
        ;;
    status|stat|s)
        cat /home/sdodl001/STATUS.md | less
        ;;
    intro|i)
        /home/sdodl001/genomics-git-organization/launcher/genomics-intro.sh
        ;;
    help|h|--help|-h)
        show_usage
        ;;
    *)
        echo "❓ Unknown tool: $1"
        show_usage
        ;;
esac
EOF
  chmod +x "${ORG_DIR}/launcher/genomics-tools.sh"
  echo "✓ Updated gtools with new analyze capability"
fi

# 11. Create README for system-utils directory
cat > "${SYS_DIR}/README.md" << 'EOF'
# System Utilities

This directory contains system utilities, logs, and configuration files that are not directly related to the genomics-git-organization project but are important for system maintenance.

## Directory Structure

- **logs/**: Contains system and application logs
  - `java/`: Java application logs
  - `xrdp/`: Remote desktop connection logs
  
- **temp/**: Temporary files
  - `history_backups/`: Backup files of shell history
  
- **backups/**: Backup files
  
- **test_output/**: Output from test runs
  
- **test_scripts/**: Test scripts

- **vscode_extensions/**: VS Code extension files

## Usage

Most files in this directory are meant to be referenced rather than executed directly. The organization helps keep the home directory clean while preserving important system files.
EOF

# 12. Create README for notebooks directory
cat > "${NOTEBOOKS_DIR}/README.md" << 'EOF'
# Jupyter Notebooks

This directory contains Jupyter notebooks for various analyses and explorations.

## Directory Structure

- **analysis/**: Notebooks for specific analysis tasks
  
- **tutorials/**: Educational notebooks and tutorials
  
- **exploratory/**: Exploratory data analysis notebooks
  
- **unsorted/**: Notebooks that have not been categorized yet

## Usage

To work with these notebooks, you can:

1. Navigate to the appropriate directory
2. Start Jupyter: `jupyter notebook` or `jupyter lab`
3. Open the notebook of interest

All notebooks related to the genomics projects should be stored in this organized structure rather than in the home directory.
EOF

echo ""
echo "✅ Enhanced cleanup complete!"
echo ""
echo "📂 Updated Directory Structure:"
echo "├── /home/sdodl001/"
echo "│   ├── genomics-git-organization/      # Main organization directory"
echo "│   │   ├── notebooks/                  # Jupyter notebooks"
echo "│   │   │   ├── analysis/               # Analysis notebooks"
echo "│   │   │   ├── tutorials/              # Tutorial notebooks" 
echo "│   │   │   ├── exploratory/            # Exploratory notebooks"
echo "│   │   │   └── unsorted/               # Unsorted notebooks"
echo "│   │   ├── configuration/              # Configuration files"
echo "│   │   │   ├── vscode/                 # VS Code settings"
echo "│   │   │   ├── workspaces/             # VS Code workspace files"
echo "│   │   │   └── shell/                  # Shell configurations"
echo "│   │   └── ... other existing dirs ... # Previously created directories"
echo "│   ├── system-utils/                   # System utilities directory"
echo "│   │   ├── logs/                       # Log files"
echo "│   │   ├── temp/                       # Temporary files"
echo "│   │   ├── backups/                    # Backup files" 
echo "│   │   ├── test_output/                # Test outputs"
echo "│   │   └── vscode_extensions/          # VS Code extensions"
echo "│   ├── github_automation/              # GitHub automation scripts"
echo "│   │   ├── setup_scripts/              # GitHub setup scripts"
echo "│   │   ├── deployment/                 # Deployment scripts"
echo "│   │   └── testing/                    # Testing scripts"
echo "│   ├── gtools                          # Symlink to unified tools launcher"
echo "│   └── analyze_home.sh                 # Symlink to home clutter analysis tool"
echo ""
echo "🚀 NEXT STEPS:"
echo "1. Run the additional_cleanup.sh script if you haven't already:"
echo "   ./additional_cleanup.sh"
echo ""
echo "2. Run this enhanced cleanup script:"
echo "   ./enhanced_cleanup_plan.sh"
echo ""
echo "3. Analyze remaining home directory clutter:"
echo "   ./analyze_home.sh"
echo "   or: gtools analyze"
echo ""
echo "4. Source the setup script to use tools immediately:"
echo "   bash: source setup_genomics_tools.sh"
echo "   tcsh: source setup_genomics_tools.csh"
