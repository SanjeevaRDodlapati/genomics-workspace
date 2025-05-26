#!/bin/bash
# Further home directory organization
# This script extends the organization to further reduce clutter

echo "🧹 ADDITIONAL HOME DIRECTORY CLEANUP"
echo "=================================="
echo ""

# Create additional organization directories
echo "📁 Creating additional organization directories..."
mkdir -p /home/sdodl001/system-utils
mkdir -p /home/sdodl001/genomics-git-organization/utils
mkdir -p /home/sdodl001/genomics-git-organization/wrappers
mkdir -p /home/sdodl001/genomics-git-organization/launcher

# Base directories
ORG_DIR="/home/sdodl001/genomics-git-organization"
SYS_DIR="/home/sdodl001/system-utils"

echo ""
echo "🔄 Organizing utility scripts..."

# Move remaining utility scripts to the appropriate location
mv /home/sdodl001/repoutil "${ORG_DIR}/utils/"
mv /home/sdodl001/verify_organization.sh "${ORG_DIR}/utils/"
mv /home/sdodl001/python_hpc_wrapper.sh "${ORG_DIR}/wrappers/"
mv /home/sdodl001/genomics-intro.sh "${ORG_DIR}/launcher/"

# Update symlinks for moved files
ln -sf "${ORG_DIR}/utils/repoutil" /home/sdodl001/repoutil
ln -sf "${ORG_DIR}/utils/verify_organization.sh" /home/sdodl001/verify_organization.sh
ln -sf "${ORG_DIR}/wrappers/python_hpc_wrapper.sh" /home/sdodl001/python_hpc_wrapper.sh

# Move project documentation to the organization directory
echo ""
echo "📄 Organizing documentation files..."

mv /home/sdodl001/ORGANIZATION_SUMMARY.md "${ORG_DIR}/documentation/reports/"
mv /home/sdodl001/GITORG_REFERENCE.md "${ORG_DIR}/documentation/guides/"

# Update symlinks for moved documentation
ln -sf "${ORG_DIR}/documentation/reports/ORGANIZATION_SUMMARY.md" /home/sdodl001/ORGANIZATION_SUMMARY.md
ln -sf "${ORG_DIR}/documentation/guides/GITORG_REFERENCE.md" /home/sdodl001/GITORG_REFERENCE.md

echo ""
echo "🧹 Cleaning up log files..."

# Create a directory for system logs
mkdir -p ${SYS_DIR}/logs/xrdp

# Move XRDP log files to a more organized location
mv /home/sdodl001/.xorgxrdp*.log* ${SYS_DIR}/logs/xrdp/ 2>/dev/null

# Create unified tool access script
echo ""
echo "🛠️ Creating unified tool access script..."

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
    echo "  status       - Show project status"
    echo "  intro        - Display project introduction"
    echo "  help         - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") organization scripts 5"
    echo "  $(basename "$0") repository status UAVarPrior"
    echo "  $(basename "$0") verify"
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
ln -sf "${ORG_DIR}/launcher/genomics-tools.sh" /home/sdodl001/gtools

# Move gitorg to utils directory
echo ""
echo "🔄 Moving gitorg to utils directory..."
mv /home/sdodl001/gitorg "${ORG_DIR}/utils/"
ln -sf "${ORG_DIR}/utils/gitorg" /home/sdodl001/gitorg

# Update startup configuration to add the tools to the PATH
echo ""
echo "🔄 Updating shell configuration..."

# Backup original bashrc if it exists
if [ -f /home/sdodl001/.bashrc ]; then
    cp /home/sdodl001/.bashrc /home/sdodl001/.bashrc.bak.$(date +%Y%m%d)
fi

# Backup original tcshrc if it exists
if [ -f /home/sdodl001/.tcshrc ]; then
    cp /home/sdodl001/.tcshrc /home/sdodl001/.tcshrc.bak.$(date +%Y%m%d)
fi

# Create a shell setup script for genomics tools
cat > "${ORG_DIR}/launcher/shell_setup.sh" << 'EOF'
# Genomics tools shell configuration
# Source this file in your .bashrc or equivalent

# Add genomics tools to PATH
export GENOMICS_TOOLS_DIR=/home/sdodl001/genomics-git-organization
export PATH=$PATH:$GENOMICS_TOOLS_DIR/utils:$GENOMICS_TOOLS_DIR/launcher:$GENOMICS_TOOLS_DIR/wrappers

# Set aliases for common commands
alias gtools='/home/sdodl001/gtools'
alias grepo='gtools repository'
alias gorg='gtools organization'
alias gstatus='gtools status'
EOF

# Create a tcsh setup script for genomics tools
cat > "${ORG_DIR}/launcher/shell_setup.csh" << 'EOF'
# Genomics tools shell configuration for tcsh
# Source this file in your .tcshrc or equivalent

# Add genomics tools to PATH
setenv GENOMICS_TOOLS_DIR /home/sdodl001/genomics-git-organization
set path = ($path $GENOMICS_TOOLS_DIR/utils $GENOMICS_TOOLS_DIR/launcher $GENOMICS_TOOLS_DIR/wrappers)

# Set aliases for common commands
alias gtools '/home/sdodl001/gtools'
alias grepo 'gtools repository'
alias gorg 'gtools organization'
alias gstatus 'gtools status'
EOF

# Setup entry in .bashrc (if not already present)
if [ -f /home/sdodl001/.bashrc ] && ! grep -q "Genomics tools shell configuration" /home/sdodl001/.bashrc; then
    echo "" >> /home/sdodl001/.bashrc
    echo "# Source genomics tools configuration" >> /home/sdodl001/.bashrc
    echo "if [ -f \"${ORG_DIR}/launcher/shell_setup.sh\" ]; then" >> /home/sdodl001/.bashrc
    echo "    . \"${ORG_DIR}/launcher/shell_setup.sh\"" >> /home/sdodl001/.bashrc
    echo "fi" >> /home/sdodl001/.bashrc
fi

# Setup entry in .tcshrc (if not already present)
if [ -f /home/sdodl001/.tcshrc ] && ! grep -q "Genomics tools shell configuration" /home/sdodl001/.tcshrc; then
    echo "" >> /home/sdodl001/.tcshrc
    echo "# Source genomics tools configuration" >> /home/sdodl001/.tcshrc
    echo "if ( -f \"${ORG_DIR}/launcher/shell_setup.csh\" ) then" >> /home/sdodl001/.tcshrc
    echo "    source \"${ORG_DIR}/launcher/shell_setup.csh\"" >> /home/sdodl001/.tcshrc
    echo "endif" >> /home/sdodl001/.tcshrc
fi

# Create a setup script that can be sourced for immediate use
cat > /home/sdodl001/setup_genomics_tools.sh << EOF
#!/bin/bash
# Setup genomics tools for the current session
export GENOMICS_TOOLS_DIR=${ORG_DIR}
export PATH=\$PATH:\$GENOMICS_TOOLS_DIR/utils:\$GENOMICS_TOOLS_DIR/launcher:\$GENOMICS_TOOLS_DIR/wrappers

# Set aliases for common commands
alias gtools='/home/sdodl001/gtools'
alias grepo='gtools repository' 
alias gorg='gtools organization'
alias gstatus='gtools status'

# Show the intro message
\${GENOMICS_TOOLS_DIR}/launcher/genomics-intro.sh

echo ""
echo "🧰 Genomics tools are now available!"
echo "Try using 'gtools help' to get started."
EOF

chmod +x /home/sdodl001/setup_genomics_tools.sh

# Create a tcsh version of the setup script
cat > /home/sdodl001/setup_genomics_tools.csh << EOF
#!/bin/tcsh
# Setup genomics tools for the current session
setenv GENOMICS_TOOLS_DIR ${ORG_DIR}
set path = (\$path \$GENOMICS_TOOLS_DIR/utils \$GENOMICS_TOOLS_DIR/launcher \$GENOMICS_TOOLS_DIR/wrappers)

# Set aliases for common commands
alias gtools '/home/sdodl001/gtools'
alias grepo 'gtools repository'
alias gorg 'gtools organization'
alias gstatus 'gtools status'

# Show the intro message
\${GENOMICS_TOOLS_DIR}/launcher/genomics-intro.sh

echo ""
echo "🧰 Genomics tools are now available!"
echo "Try using 'gtools help' to get started."
EOF

chmod +x /home/sdodl001/setup_genomics_tools.csh

echo ""
echo "✅ Additional cleanup complete!"
echo ""
echo "📂 Updated Directory Structure:"
echo "├── /home/sdodl001/"
echo "│   ├── setup_genomics_tools.sh       # Quick setup for bash"
echo "│   ├── setup_genomics_tools.csh      # Quick setup for tcsh"
echo "│   ├── gtools                        # Symlink to the unified tools launcher"
echo "│   ├── gitorg                        # Symlink to the organization navigator"
echo "│   ├── repoutil                      # Symlink to the repository manager"
echo "│   ├── STATUS.md                     # Symlink to deployment status"
echo "│   ├── NEXT_STEPS.md                 # Symlink to implementation plan"
echo "│   ├── ORGANIZATION_SUMMARY.md       # Symlink to organization summary"
echo "│   ├── GITORG_REFERENCE.md           # Symlink to quick reference guide"
echo "│   └── genomics-git-organization/    # Main organization directory"
echo "│       ├── utils/                    # Utility scripts"
echo "│       ├── launcher/                 # Launcher scripts"
echo "│       ├── wrappers/                 # Wrapper scripts"
echo "│       ├── scripts/                  # Project scripts"
echo "│       ├── documentation/            # Documentation"
echo "│       └── monitoring/               # Monitoring files"
echo ""
echo "🚀 NEXT STEPS:"
echo "1. Source the setup script to use tools immediately:"
echo "   bash: source setup_genomics_tools.sh"
echo "   tcsh: source setup_genomics_tools.csh"
echo ""
echo "2. Use the unified 'gtools' command for all operations:"
echo "   gtools help                 # Show available tools"
echo "   gtools organization scripts # Navigate organization"
echo "   gtools repository status UAVarPrior # Check repository status"
echo ""
echo "3. Use shell aliases for quick access:"
echo "   gorg scripts                # Same as gtools organization scripts"
echo "   grepo status UAVarPrior     # Same as gtools repository status UAVarPrior"
echo "   gstatus                     # Show project status"
echo ""
echo "Shell configuration will be automatically loaded in new sessions."
