# Genomics Workspace Management Guide

## Overview
This guide provides comprehensive instructions for managing the genomics development workspace, including environment setup, project organization, and cleanup procedures.

## Quick Start
If you're new to this workspace, start here:

1. **Set up your environment**:
   ```bash
   source genomics_env.csh
   ```

2. **Load genomics tools**:
   ```bash
   source load_genomics_env.tcsh
   ```

3. **Clean up workspace**:
   ```bash
   ./workspace_cleanup.sh --dry-run
   ```

## Environment Configuration

### genomics_env.csh
Core environment setup script that configures:
- Python environment with genomics-specific packages
- CUDA and TensorFlow GPU support
- Common paths and aliases

### load_genomics_env.tcsh
Advanced environment loader that sets up:
- Project-specific Python paths
- Tool integrations
- Development utilities

## Workspace Organization

### Directory Structure
```
genomics-workspace/
├── configs/          # Configuration templates
├── docs/            # Documentation
├── projects/        # Submodule projects
├── scripts/         # Utility scripts
└── releases/        # Release management
```

### Available Tools

#### workspace_cleanup.sh
Comprehensive cleanup manager with options:
- `--dry-run`: Preview changes without executing
- `--deep`: Thorough cleanup including logs and temp files
- `--archive`: Preserve removed files in archive directory

#### organize_home_directory.sh
Home directory organization tool for:
- Moving files to appropriate directories
- Creating organized folder structures
- Cleaning up temporary files

#### standardize_project_configs.tcsh
Project standardization tool that:
- Ensures consistent .gitignore files
- Standardizes project configurations
- Updates documentation templates

## Development Workflow

### Daily Workflow
1. Load environment: `source load_genomics_env.tcsh`
2. Check project status: `cd projects && git submodule status`
3. Work on your projects
4. Clean workspace: `./workspace_cleanup.sh`

### Project Management
- Use submodules for coordinated development
- Keep configurations synchronized
- Regular cleanup and organization
- Consistent documentation

### Integration with Other Tools
This workspace integrates with:
- **genomics-git-organization/**: Repository management tools
- **github_automation/**: Deployment and automation scripts

## Troubleshooting

### Common Issues
- **Environment not loading**: Check Python installation and paths
- **Permission errors**: Verify file permissions and ownership
- **Module conflicts**: Use virtual environments for isolation

### Recovery Procedures
1. Reset environment: `source genomics_env.csh`
2. Clean workspace: `./workspace_cleanup.sh --deep`
3. Verify setup: `source load_genomics_env.tcsh`

## Best Practices

### File Organization
- Keep projects in `projects/` subdirectory
- Use descriptive names for scripts and configs
- Regular cleanup to prevent clutter

### Environment Management
- Use virtual environments for different projects
- Keep environment scripts updated
- Document any custom modifications

### Documentation
- Update this guide when adding new tools
- Document project-specific procedures
- Maintain changelog for significant changes

---
*Last updated: May 26, 2025*
*Merged from: START_HERE.md, EXACTLY_WHAT_TO_DO_NOW.md, README.md*
