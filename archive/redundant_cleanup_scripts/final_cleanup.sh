#!/bin/bash
# Final cleanup script for /home/sdodl001
# Integrates remaining organization tasks and consolidates project structure

echo "🌟 FINAL HOME DIRECTORY CLEANUP"
echo "============================="
echo ""

# Define base directories
HOME_DIR="/home/sdodl001"
ORG_DIR="${HOME_DIR}/genomics-git-organization"
SYS_DIR="${HOME_DIR}/system-utils"
CODE_DIRS=( "${HOME_DIR}/FuGEP" "${HOME_DIR}/GenomicLightning" "${HOME_DIR}/TransMet" "${HOME_DIR}/UAVarPrior" )

# 1. Create a project workspace consolidation directory
echo "📁 Setting up project consolidation structure..."
mkdir -p "${ORG_DIR}/genomics-workspace/projects"

# 2. Create consistent configuration directories in each project
echo ""
echo "🔄 Creating consistent configuration layouts for project organization..."

for dir in "${CODE_DIRS[@]}"; do
  # Get just the directory name (basename)
  project_name=$(basename "$dir")
  echo "  Processing $project_name project..."
  
  # Create standard directories in each project if they don't exist
  mkdir -p "$dir/configs" 2>/dev/null
  mkdir -p "$dir/docs" 2>/dev/null
  
  # Create a standard deployment script
  if [ ! -f "$dir/deploy.sh" ]; then
    cat > "$dir/deploy.sh" << EOF
#!/bin/bash
# Standard deployment script for $project_name
# Created by organization automation

echo "Deploying $project_name..."

# Check for requirements
if [ -f "requirements.txt" ]; then
  echo "Installing requirements..."
  pip install -r requirements.txt
fi

# Install the package in development mode
if [ -f "setup.py" ]; then
  echo "Installing package in development mode..."
  pip install -e .
fi

echo "Deployment complete!"
EOF
    chmod +x "$dir/deploy.sh"
    echo "  ✓ Created standard deploy.sh for $project_name"
  fi
  
  # Create a version file if it doesn't exist
  if [ ! -f "$dir/VERSION" ]; then
    # Try to extract version from setup.py if it exists
    if [ -f "$dir/setup.py" ]; then
      version=$(grep -Eo "version\s*=\s*['\"][0-9]+\.[0-9]+\.[0-9]+['\"]" "$dir/setup.py" | cut -d'"' -f2 || echo "0.1.0")
    else
      version="0.1.0"
    fi
    echo "$version" > "$dir/VERSION"
    echo "  ✓ Created VERSION file for $project_name"
  fi
done

# 3. Create a unified workspace file if it doesn't exist
echo ""
echo "🖥️ Creating unified VS Code workspace..."

# Create a unified workspace file
cat > "${ORG_DIR}/configuration/workspaces/genomics-unified.code-workspace" << EOF
{
  "folders": [
    {
      "path": "${HOME_DIR}/FuGEP",
      "name": "FuGEP"
    },
    {
      "path": "${HOME_DIR}/GenomicLightning",
      "name": "GenomicLightning"
    },
    {
      "path": "${HOME_DIR}/TransMet",
      "name": "TransMet"
    },
    {
      "path": "${HOME_DIR}/UAVarPrior",
      "name": "UAVarPrior"
    },
    {
      "path": "${HOME_DIR}/genomics-git-organization",
      "name": "Organization"
    }
  ],
  "settings": {
    "files.autoSave": "afterDelay",
    "editor.formatOnSave": true,
    "python.linting.enabled": true,
    "python.formatting.provider": "autopep8",
    "python.linting.pylintEnabled": true,
    "git.enableSmartCommit": true
  }
}
EOF
echo "  ✓ Created unified VS Code workspace file"

# Create symlink to workspace file in home directory
ln -sf "${ORG_DIR}/configuration/workspaces/genomics-unified.code-workspace" "${HOME_DIR}/genomics-unified.code-workspace"

# 4. Clean up any redundant workspace files
echo ""
echo "🧹 Cleaning up redundant workspace files..."
if [ -f "${HOME_DIR}/.code-workspace.code-workspace" ]; then
  rm -f "${HOME_DIR}/.code-workspace.code-workspace"
  echo "  ✓ Removed redundant .code-workspace.code-workspace file"
fi

# 5. Create shell scripts to manage the projects
echo ""
echo "🔄 Creating unified project management scripts..."

# Create a script to update all projects at once
cat > "${ORG_DIR}/launcher/update_all_projects.tcsh" << 'EOF'
#!/bin/tcsh
# Script to update all genomics projects at once

set HOME_DIR="/home/sdodl001"
set PROJECTS=( FuGEP GenomicLightning TransMet UAVarPrior )

echo "🔄 Updating all genomics projects..."
echo "=================================="

foreach project ($PROJECTS)
  echo ""
  echo "📦 Processing $project..."
  cd "$HOME_DIR/$project"
  
  # Update git repository
  if (-d .git) then
    echo "  ↓ Pulling latest changes..."
    git pull
  endif
  
  # Run deployment script if it exists
  if (-e deploy.sh) then
    echo "  🚀 Running deployment script..."
    bash deploy.sh
  endif
end

echo ""
echo "✅ All projects updated!"
EOF
chmod +x "${ORG_DIR}/launcher/update_all_projects.tcsh"
ln -sf "${ORG_DIR}/launcher/update_all_projects.tcsh" "${HOME_DIR}/update_all_projects.tcsh"

# 6. Final organization review script
echo ""
echo "📋 Creating final organization review script..."

cat > "${ORG_DIR}/utils/organization_review.sh" << 'EOF'
#!/bin/bash
# Script to review the organization of the home directory and projects

HOME_DIR="/home/sdodl001"
ORG_DIR="${HOME_DIR}/genomics-git-organization"
REPORT_FILE="${ORG_DIR}/documentation/reports/ORGANIZATION_REVIEW.md"

# Create directory if it doesn't exist
mkdir -p "${ORG_DIR}/documentation/reports"

echo "# Genomics Project Organization Review" > "$REPORT_FILE"
echo "Generated on $(date)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Report on symlinks
echo "## Symlinks in Home Directory" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "Symlinks provide quick access to important files:" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "| Link | Target |" >> "$REPORT_FILE"
echo "|------|--------|" >> "$REPORT_FILE"
find "$HOME_DIR" -maxdepth 1 -type l -exec sh -c 'echo "| $(basename {}) | $(readlink {}) |"' \; | sort >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Report on directory structure
echo "## Directory Structure" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "Key directories in the organization:" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "### Main Organization" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
find "${ORG_DIR}" -type d -not -path "*/\.*" | sort | sed "s|${ORG_DIR}|genomics-git-organization|" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Report on system utilities
echo "### System Utilities" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
find "${HOME_DIR}/system-utils" -type d | sort | sed "s|${HOME_DIR}/system-utils|system-utils|" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check for unorganized files
echo "## Remaining Items to Organize" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "Files directly in home directory (excluding dotfiles and symlinks):" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
find "$HOME_DIR" -maxdepth 1 -type f -not -name ".*" | grep -v "HOME_CLEANUP_REPORT.md" | sort >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"

# Done
echo "" >> "$REPORT_FILE"
echo "## Next Steps" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "1. Review any remaining unorganized files" >> "$REPORT_FILE"
echo "2. Consider archiving old/unused files" >> "$REPORT_FILE"
echo "3. Keep using the organization tools to maintain structure" >> "$REPORT_FILE"

echo "Organization review complete! Report generated at $REPORT_FILE"

# Create a symlink to the report in the home directory
ln -sf "$REPORT_FILE" "${HOME_DIR}/ORGANIZATION_REVIEW.md"
EOF
chmod +x "${ORG_DIR}/utils/organization_review.sh"
ln -sf "${ORG_DIR}/utils/organization_review.sh" "${HOME_DIR}/review_organization.sh"

# 7. Update gtools command to include the review
echo ""
echo "🔄 Updating gtools with review capability..."

if [ -f "${ORG_DIR}/launcher/genomics-tools.sh" ]; then
  # Create a backup of existing file
  cp "${ORG_DIR}/launcher/genomics-tools.sh" "${ORG_DIR}/launcher/genomics-tools.sh.bak"
  
  # Replace the file with updated version that includes review option
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
    echo "  review       - Review organization structure"
    echo "  update       - Update all projects"
    echo "  status       - Show project status"
    echo "  intro        - Display project introduction"
    echo "  help         - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") organization scripts 5"
    echo "  $(basename "$0") repository status UAVarPrior"
    echo "  $(basename "$0") verify"
    echo "  $(basename "$0") analyze"
    echo "  $(basename "$0") review"
    echo "  $(basename "$0") update"
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
    review|rev)
        /home/sdodl001/genomics-git-organization/utils/organization_review.sh
        ;;
    update|up)
        /home/sdodl001/genomics-git-organization/launcher/update_all_projects.tcsh
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
  echo "  ✓ Updated gtools with new capabilities"
fi

echo ""
echo "✅ Final cleanup complete!"
echo ""
echo "🚀 NEXT STEPS:"
echo "1. Run the organization review:"
echo "   ./review_organization.sh"
echo "   or: gtools review"
echo ""
echo "2. Open the unified workspace in VS Code:"
echo "   code genomics-unified.code-workspace"
echo ""
echo "3. Update all projects with a single command:"
echo "   ./update_all_projects.tcsh"
echo "   or: gtools update"
echo ""
echo "4. Source the setup script to use tools immediately:"
echo "   bash: source setup_genomics_tools.sh"
echo "   tcsh: source setup_genomics_tools.csh"
echo ""
echo "Your home directory is now well-organized and equipped with"
echo "powerful tools to help maintain its structure!"
