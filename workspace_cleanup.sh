#!/bin/bash
# Comprehensive Workspace Cleanup Manager
# Merged from: additional_cleanup.sh, enhanced_cleanup_plan.sh, final_cleanup.sh, cleanup_redundant_scripts.csh
# Created: May 26, 2025

echo "🧹 COMPREHENSIVE WORKSPACE CLEANUP"
echo "=================================="
echo ""

# Configuration
WORKSPACE_ROOT="/home/sdodl001"
REPOS=("UAVarPrior" "GenomicLightning" "FuGEP" "TransMet" "genomics-workspace")
DRY_RUN=false
DEEP_CLEAN=false
ARCHIVE_OLD=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--dry-run)
            DRY_RUN=true
            echo "🔍 DRY RUN MODE - No actual changes will be made"
            echo ""
            shift
            ;;
        -d|--deep)
            DEEP_CLEAN=true
            shift
            ;;
        -a|--archive)
            ARCHIVE_OLD=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -n, --dry-run     Show what would be done without executing"
            echo "  -d, --deep        Perform deep cleanup (removes more files)"
            echo "  -a, --archive     Archive old files instead of deleting"
            echo "  -h, --help        Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Function to execute or show command
execute_or_show() {
    if $DRY_RUN; then
        echo "    Would execute: $*"
    else
        "$@"
    fi
}

# Function to clean repository
clean_repository() {
    local repo=$1
    local repo_path="$WORKSPACE_ROOT/$repo"
    
    if [[ ! -d "$repo_path" ]]; then
        echo "⚠️  Repository $repo not found"
        return
    fi
    
    echo "🔧 Cleaning $repo..."
    cd "$repo_path"
    
    # Clean Python artifacts
    echo "  Cleaning Python artifacts..."
    if $ARCHIVE_OLD && [[ -d "__pycache__" || -d "*.egg-info" ]]; then
        execute_or_show mkdir -p "archive/python_artifacts"
        execute_or_show find . -name "__pycache__" -type d -exec mv {} "archive/python_artifacts/" \; 2>/dev/null || true
        execute_or_show find . -name "*.egg-info" -type d -exec mv {} "archive/python_artifacts/" \; 2>/dev/null || true
    else
        execute_or_show find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
        execute_or_show find . -name "*.egg-info" -type d -exec rm -rf {} + 2>/dev/null || true
    fi
    
    execute_or_show find . -name "*.pyc" -delete 2>/dev/null || true
    execute_or_show find . -name "*.pyo" -delete 2>/dev/null || true
    
    # Clean build artifacts
    echo "  Cleaning build artifacts..."
    if $ARCHIVE_OLD && [[ -d "build" || -d "dist" ]]; then
        execute_or_show mkdir -p "archive/build_artifacts"
        execute_or_show mv build "archive/build_artifacts/" 2>/dev/null || true
        execute_or_show mv dist "archive/build_artifacts/" 2>/dev/null || true
    else
        execute_or_show rm -rf build dist 2>/dev/null || true
    fi
    
    # Clean test outputs
    echo "  Cleaning test outputs..."
    execute_or_show find . -name "test_output.txt" -delete 2>/dev/null || true
    execute_or_show find . -name "*_test_output*" -delete 2>/dev/null || true
    execute_or_show rm -f .coverage coverage.xml 2>/dev/null || true
    
    # Deep clean if requested
    if $DEEP_CLEAN; then
        echo "  Deep cleaning..."
        execute_or_show find . -name "*.log" -delete 2>/dev/null || true
        execute_or_show find . -name "*.tmp" -delete 2>/dev/null || true
        execute_or_show find . -name ".DS_Store" -delete 2>/dev/null || true
    fi
    
    echo "  ✅ $repo cleaned"
}

# Function to organize home directory
organize_home() {
    echo "🏠 Organizing home directory..."
    cd "$WORKSPACE_ROOT"
    
    # Move log files
    if ls *.log >/dev/null 2>&1; then
        execute_or_show mkdir -p logs
        execute_or_show mv *.log logs/ 2>/dev/null || true
    fi
    
    # Move temporary files
    if ls *.tmp >/dev/null 2>&1 || ls temp_* >/dev/null 2>&1; then
        execute_or_show mkdir -p temp_archive
        execute_or_show mv *.tmp temp_* temp_archive/ 2>/dev/null || true
    fi
    
    # Clean up duplicate scripts (already moved by our organization)
    if ls *_backup* >/dev/null 2>&1; then
        execute_or_show mkdir -p archive/backups
        execute_or_show mv *_backup* archive/backups/ 2>/dev/null || true
    fi
}

# Function to standardize configurations
standardize_configs() {
    echo "⚙️  Standardizing project configurations..."
    
    for repo in "${REPOS[@]}"; do
        repo_path="$WORKSPACE_ROOT/$repo"
        if [[ -d "$repo_path" ]]; then
            cd "$repo_path"
            
            # Ensure .gitignore exists and is comprehensive
            if [[ ! -f ".gitignore" ]] || ! grep -q "__pycache__" ".gitignore" 2>/dev/null; then
                echo "  Updating .gitignore for $repo..."
                execute_or_show cat >> .gitignore << 'GITIGNORE_EOF'

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Testing
.coverage
.pytest_cache/
htmlcov/

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
GITIGNORE_EOF
            fi
        fi
    done
}

# Main execution
echo "Starting workspace cleanup..."
echo "Repositories to clean: ${REPOS[*]}"
echo ""

# Clean each repository
for repo in "${REPOS[@]}"; do
    clean_repository "$repo"
    echo ""
done

# Organize home directory
organize_home
echo ""

# Standardize configurations
standardize_configs
echo ""

echo "🎉 Workspace cleanup complete!"
echo ""
echo "Summary:"
echo "- Cleaned ${#REPOS[@]} repositories"
echo "- Organized home directory"
echo "- Standardized configurations"
if $DRY_RUN; then
    echo "- This was a dry run - no actual changes made"
fi
echo ""
echo "Next steps:"
echo "- Run with --deep for more thorough cleaning"
echo "- Run with --archive to preserve removed files"
echo "- Commit any .gitignore changes to repositories"

exit 0
