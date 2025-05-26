#!/bin/bash
# Organization script for /home/sdodl001 directory
# This script will organize the various files created during the Git organization project
# into a more structured directory layout

echo "🗂️ ORGANIZING HOME DIRECTORY"
echo "=========================="
echo ""

# Create organization directories
echo "📁 Creating organization directories..."
mkdir -p /home/sdodl001/genomics-git-organization/{scripts,documentation,deployment,monitoring,archive}
mkdir -p /home/sdodl001/genomics-git-organization/scripts/{phase1-2,phase3,phase4,phase5,utils}
mkdir -p /home/sdodl001/genomics-git-organization/documentation/{guides,reports,templates}

# Organization directory base path
ORG_DIR="/home/sdodl001/genomics-git-organization"

echo ""
echo "🔄 Moving script files..."

# Phase 1-2 Infrastructure scripts
mv /home/sdodl001/implement_conventional_commits.csh "${ORG_DIR}/scripts/phase1-2/"
mv /home/sdodl001/implement_git_organization.csh "${ORG_DIR}/scripts/phase1-2/"
mv /home/sdodl001/implement_quick_wins.csh "${ORG_DIR}/scripts/phase1-2/"
mv /home/sdodl001/quick_wins_summary.csh "${ORG_DIR}/scripts/phase1-2/"
mv /home/sdodl001/git_organization_complete.csh "${ORG_DIR}/scripts/phase1-2/"
mv /home/sdodl001/organization_success_summary.csh "${ORG_DIR}/scripts/phase1-2/"

# Phase 3 Automation scripts
mv /home/sdodl001/implement_phase3_automation.csh "${ORG_DIR}/scripts/phase3/"
mv /home/sdodl001/phase3_automation_complete.csh "${ORG_DIR}/scripts/phase3/"

# Phase 4 Enterprise scripts
mv /home/sdodl001/implement_phase4_enterprise.csh "${ORG_DIR}/scripts/phase4/"
mv /home/sdodl001/implementation_complete_summary.csh "${ORG_DIR}/scripts/phase4/"

# Phase 5 Deployment scripts
mv /home/sdodl001/implement_phase5_deployment.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/github_deployment_complete.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/execute_github_deployment.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/execute_github_deployment.sh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/execute_first_release.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/execute_first_release.sh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/setup_meta_repository.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/setup_github_meta_repository.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/test_coordinated_release.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/quick_deployment_check.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/final_deployment_readiness_report.csh "${ORG_DIR}/scripts/phase5/"
mv /home/sdodl001/FINAL_DEPLOYMENT_STATUS.csh "${ORG_DIR}/scripts/phase5/"

# Utility scripts
mv /home/sdodl001/push_all_repos.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/push_all_repos_enhanced.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/push_to_all_accounts.sh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/check_all_accounts.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/check_github_repos.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/verify_deployment.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/verify_deployment.sh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/verify_github_deployments.sh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/verify_repos.sh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/organize_github_scripts.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/github_quick_ref.csh "${ORG_DIR}/scripts/utils/"
mv /home/sdodl001/cleanup_redundant_scripts.csh "${ORG_DIR}/scripts/utils/"

# Repository-specific scripts
mkdir -p "${ORG_DIR}/scripts/repos"
mv /home/sdodl001/prepare_UAVarPrior_release.csh "${ORG_DIR}/scripts/repos/"
mv /home/sdodl001/prepare_GenomicLightning_release.csh "${ORG_DIR}/scripts/repos/"
mv /home/sdodl001/prepare_FuGEP_release.csh "${ORG_DIR}/scripts/repos/"
mv /home/sdodl001/prepare_TransMet_release.csh "${ORG_DIR}/scripts/repos/"
mv /home/sdodl001/test_github_setup.sh "${ORG_DIR}/scripts/repos/"

echo ""
echo "📄 Moving documentation files..."

# Documentation - Guides
mv /home/sdodl001/COMPLETE_DEPLOYMENT_GUIDE.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/DETAILED_GITHUB_CREATION_GUIDE.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/GITHUB_CREATION_YOUR_SITUATION.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/STEP_BY_STEP_TOKEN_CREATION_GUIDE.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/THREE_ACCOUNT_SETUP.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/CREDENTIAL_MANAGEMENT_GUIDE.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/PASSWORD_VS_TOKEN_EXPLANATION.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/EXACTLY_WHAT_TO_DO_NOW.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/FINAL_SETUP_GUIDE.md "${ORG_DIR}/documentation/guides/"
mv /home/sdodl001/QUICK_DEPLOYMENT_CARD.txt "${ORG_DIR}/documentation/guides/"

# Documentation - Reports
mv /home/sdodl001/GITHUB_DEPLOYMENT_STATUS_REPORT.md "${ORG_DIR}/documentation/reports/"
mv /home/sdodl001/FINAL_DEPLOYMENT_REPORT.md "${ORG_DIR}/documentation/reports/"
mv /home/sdodl001/INFRASTRUCTURE_COMPLETION_REPORT.md "${ORG_DIR}/documentation/reports/"
mv /home/sdodl001/FINAL_SOLUTION_SUMMARY.md "${ORG_DIR}/documentation/reports/"
mv /home/sdodl001/DEPLOYMENT_COMPLETE.md "${ORG_DIR}/documentation/reports/"
mv /home/sdodl001/COMPLETE_WORKFLOW_GUIDE.md "${ORG_DIR}/documentation/reports/"

# Monitoring setup
mv /home/sdodl001/deploy_monitoring.csh "${ORG_DIR}/monitoring/"
mv /home/sdodl001/deploy_monitoring.sh "${ORG_DIR}/monitoring/"
mv /home/sdodl001/setup_github_actions.sh "${ORG_DIR}/monitoring/"
mv /home/sdodl001/MONITORING_IMPLEMENTATION_PLAN.md "${ORG_DIR}/monitoring/"
mv /home/sdodl001/BRANCH_PROTECTION_SETUP.md "${ORG_DIR}/monitoring/"

echo ""
echo "🧹 Creating README file for the organization directory..."

# Create README file
cat > "${ORG_DIR}/README.md" << 'README_EOF'
# Genomics Git Organization Project

This directory contains the organized files related to the comprehensive Git organization improvement system for genomics research repositories.

## Directory Structure

- **scripts/**: All scripts used in the project, organized by phase
  - **phase1-2/**: Infrastructure setup scripts
  - **phase3/**: Advanced automation scripts
  - **phase4/**: Enterprise integration scripts
  - **phase5/**: GitHub deployment scripts
  - **utils/**: Utility scripts for repository management
  - **repos/**: Repository-specific scripts

- **documentation/**: All documentation files
  - **guides/**: Step-by-step guides for setup and deployment
  - **reports/**: Project status and completion reports
  - **templates/**: Templates for GitHub files and configurations

- **deployment/**: Deployment-related files
  - Contains scripts and configurations for GitHub deployment

- **monitoring/**: Monitoring infrastructure setup
  - Scripts and documentation for setting up continuous monitoring

- **archive/**: Archived files
  - Older versions of scripts and documentation

## Key Files

### Critical Scripts
- `scripts/phase5/execute_github_deployment.sh`: Main deployment script
- `scripts/phase5/execute_first_release.sh`: Script for coordinated releases
- `scripts/utils/verify_github_deployments.sh`: Script to verify deployment status
- `scripts/utils/push_to_all_accounts.sh`: Script to push to all GitHub accounts

### Critical Documentation
- `documentation/guides/COMPLETE_DEPLOYMENT_GUIDE.md`: Comprehensive deployment instructions
- `documentation/guides/DETAILED_GITHUB_CREATION_GUIDE.md`: GitHub repository creation guide
- `monitoring/MONITORING_IMPLEMENTATION_PLAN.md`: Plan for implementing continuous monitoring
- `monitoring/BRANCH_PROTECTION_SETUP.md`: Guide for setting up branch protection rules

## GitHub Repositories

All repositories are deployed to three GitHub accounts:
- SanjeevaRDodlapati
- sdodlapa
- sdodlapati3

### Projects
1. UAVarPrior
2. GenomicLightning
3. FuGEP
4. TransMet
5. genomics-workspace (meta-repository)

## Current Status

- All repositories successfully deployed to GitHub with v0.1.0 tags
- Submodule integration completed in genomics-workspace
- Branch protection rules and GitHub Actions workflows need to be set up
- Continuous monitoring implementation is the next step
README_EOF

echo ""
echo "🏷️ Creating symlinks to critical files for easy access..."

# Create symlinks to critical files
ln -sf "${ORG_DIR}/scripts/phase5/execute_github_deployment.sh" /home/sdodl001/github_deploy.sh
ln -sf "${ORG_DIR}/scripts/utils/verify_github_deployments.sh" /home/sdodl001/github_verify.sh
ln -sf "${ORG_DIR}/documentation/reports/GITHUB_DEPLOYMENT_STATUS_REPORT.md" /home/sdodl001/STATUS.md
ln -sf "${ORG_DIR}/monitoring/MONITORING_IMPLEMENTATION_PLAN.md" /home/sdodl001/NEXT_STEPS.md

echo ""
echo "✅ Organization complete! Files have been moved to structured directories."
echo ""
echo "📂 Directory structure created:"
echo "   ${ORG_DIR}/"
echo "   ├── scripts/"
echo "   │   ├── phase1-2/"
echo "   │   ├── phase3/"
echo "   │   ├── phase4/"
echo "   │   ├── phase5/"
echo "   │   ├── utils/"
echo "   │   └── repos/"
echo "   ├── documentation/"
echo "   │   ├── guides/"
echo "   │   ├── reports/"
echo "   │   └── templates/"
echo "   ├── deployment/"
echo "   ├── monitoring/"
echo "   └── archive/"
echo ""
echo "🔗 Symlinks created for easy access:"
echo "   github_deploy.sh -> Deployment script"
echo "   github_verify.sh -> Verification script"
echo "   STATUS.md -> Deployment status report"
echo "   NEXT_STEPS.md -> Monitoring implementation plan"
echo ""
echo "📝 You can find a complete guide in ${ORG_DIR}/README.md"
