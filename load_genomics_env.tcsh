#!/bin/tcsh
# Load genomics tools for the current session

echo "🧰 Loading genomics tools environment..."

# Source the shell setup script
source /home/sdodl001/setup_genomics_tools.csh

# Show the guide
echo "📖 Organization guide available at: /home/sdodl001/ORGANIZATION_GUIDE.md"

# Show available tools
echo "\n📋 Available commands:"
echo "  gtools              - Access all genomics tools"
echo "  gorg                - Navigate organization (shortcut for gtools organization)"
echo "  grepo               - Manage repositories (shortcut for gtools repository)"
echo "  project_manager     - Manage projects directly"
echo "  review_organization.sh - Review organization structure"

echo "\n🚀 Try 'gtools help' to get started"

# Clean up any temporary files in the home directory that might be left over
if (-e /home/sdodl001/archive_cleanup_scripts.tcsh) then
    echo "\n🧹 Archiving final cleanup script..."
    mv /home/sdodl001/archive_cleanup_scripts.tcsh /home/sdodl001/genomics-git-organization/archive/organization_scripts/
    mv /home/sdodl001/standardize_project_configs.tcsh /home/sdodl001/genomics-git-organization/archive/organization_scripts/
endif

# Show the welcome message
/home/sdodl001/genomics-git-organization/launcher/genomics-intro.sh
