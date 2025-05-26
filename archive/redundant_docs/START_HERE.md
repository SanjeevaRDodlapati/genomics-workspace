# Genomics Git Project Organization

**Welcome to the Genomics Git Project Organization!**

This guide provides an overview of the genomics projects organization structure and introduces the tools available for navigating and managing these projects efficiently.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Directory Structure](#directory-structure)
3. [Available Tools](#available-tools)
4. [Getting Started](#getting-started)
5. [Common Workflows](#common-workflows)
6. [Project-Specific Information](#project-specific-information)
7. [Troubleshooting](#troubleshooting)

## Project Overview

This workspace contains several genomics-related projects:

- **FuGEP**: Functional Gene Expression Prediction - Tools for predicting gene expression patterns from genomic sequences.
- **GenomicLightning**: Unified framework for genomic deep learning, integrating various neural network architectures.
- **TransMet**: Transfer learning for methylation analysis, building on the DeepCpG framework.
- **UAVarPrior**: Universal Annotation Variant Prioritization - Variant effect prediction using deep learning.

## Directory Structure

The organization follows this structure:

```
/home/sdodl001/
├── FuGEP/                   # Functional Gene Expression Prediction project
├── GenomicLightning/        # Genomic deep learning framework
├── TransMet/                # Transfer learning for methylation analysis
├── UAVarPrior/              # Variant prioritization project
├── genomics-git-organization/
│   ├── scripts/             # Shared scripts across projects
│   │   ├── phase1-2/        # Phase 1-2 scripts
│   │   ├── phase3/          # Phase 3 scripts
│   │   ├── phase4/          # Phase 4 scripts
│   │   ├── phase5/          # Phase 5 scripts
│   │   ├── utils/           # Utility scripts
│   │   └── repos/           # Repository management scripts
│   ├── documentation/       # Shared documentation
│   │   ├── guides/          # User guides
│   │   ├── reports/         # Analysis reports
│   │   └── templates/       # Template files
│   ├── deployment/          # Deployment configurations
│   ├── monitoring/          # Monitoring scripts and configs
│   ├── archive/             # Archived files and scripts
│   ├── utils/               # Organization utility tools
│   │   ├── gitorg           # Navigation tool
│   │   └── repoutil         # Repository management tool
│   └── launcher/            # Command launchers
│       ├── genomics-tools.sh # Main command interface
│       └── extended_help.sh  # Extended help information
├── system-utils/            # System-specific utilities
├── gtools -> genomics-git-organization/launcher/genomics-tools.sh # Tool symlink
├── gitorg -> genomics-git-organization/utils/gitorg # Navigation symlink
├── repoutil -> genomics-git-organization/utils/repoutil # Repo mgmt symlink
└── genomics_env.csh         # Environment setup script
```

## Available Tools

We've developed several tools to help you navigate and manage these projects:

### Main Command Interface

- **`gtools`**: Unified command interface for all genomics tools
  - Usage: `gtools [tool] [options]`
  - Example: `gtools nav fugep` to navigate to FuGEP project

### Navigation

- **`gitorg`** (or `gtools nav`): Navigate between projects and organization directories
  - Usage: `gitorg [option] [project]`
  - Example: `gitorg fugep` to navigate to FuGEP project

### Repository Management

- **`repoutil`** (or `gtools repo`): Manage git repositories across projects
  - Usage: `repoutil [action] [project] [options]`
  - Example: `repoutil status all` to show status for all projects

### Environment Management

- **`gtools env`**: Load and manage genomics environment settings
  - Usage: `gtools env [environment]`
  - Example: `gtools env tensorflow` to load TensorFlow environment

## Getting Started

1. **Set up the environment**:
   ```bash
   gtools env
   ```
   This loads necessary environment variables and paths.

2. **Navigate to a project**:
   ```bash
   gtools nav fugep  # Navigate to FuGEP project
   ```

3. **Check project status**:
   ```bash
   gtools repo status fugep  # Check git status for FuGEP
   ```

4. **Install project requirements**:
   ```bash
   gtools repo install fugep  # Install FuGEP requirements
   ```

5. **Run project commands**:
   ```bash
   gtools run fugep test  # Run tests for FuGEP
   ```

## Common Workflows

### Daily Development Workflow

```bash
# 1. Load environment
gtools env

# 2. Navigate to project
gtools nav fugep

# 3. Get latest changes
gtools repo pull fugep

# 4. Make your code changes...

# 5. Check status
gtools repo status fugep

# 6. Add and commit changes
git add .
git commit -m "Your commit message"

# 7. Push changes
gtools repo push fugep
```

### Testing Across Projects

```bash
# Test GenomicLightning
gtools nav lightning
gtools run lightning test

# Test UAVarPrior
gtools nav uavarprior
gtools run uavarprior test

# Check status of all projects
gtools repo status all
```

## Project-Specific Information

### FuGEP

The Functional Gene Expression Prediction project provides tools for predicting gene expression patterns from genomic sequences.

- **Key directories**:
  - `fugep/`: Main package code
  - `config_examples/`: Example configuration files
  - `scripts/`: Utility scripts

- **Common commands**:
  ```bash
  gtools run fugep test       # Run tests
  gtools run fugep train      # Train a model
  gtools run fugep predict    # Make predictions
  gtools run fugep evaluate   # Evaluate model performance
  ```

### GenomicLightning

Unified framework for genomic deep learning, integrating various neural network architectures.

- **Key directories**:
  - `genomic_lightning/`: Main package code
  - `configs/`: Configuration files
  - `examples/`: Example scripts

- **Common commands**:
  ```bash
  gtools run lightning test        # Run tests
  gtools run lightning train       # Train a model
  gtools run lightning predict     # Make predictions
  gtools run lightning evaluate    # Evaluate model performance
  ```

### TransMet

Transfer learning for methylation analysis, building on the DeepCpG framework.

- **Key directories**:
  - `deepcpg/`: Main package code
  - `scripts/`: Utility scripts
  - `training/`: Training scripts

- **Common commands**:
  ```bash
  gtools run transmet test     # Run tests
  gtools run transmet train    # Train a model
  gtools run transmet eval     # Evaluate model
  gtools run transmet motif    # Motif analysis
  ```

### UAVarPrior

Universal Annotation Variant Prioritization - Variant effect prediction using deep learning.

- **Key directories**:
  - `uavarprior/`: Main package code
  - `docs/`: Documentation
  - `tutorials/`: Tutorial notebooks

- **Common commands**:
  ```bash
  gtools run uavarprior test       # Run tests
  gtools run uavarprior train      # Train a model
  gtools run uavarprior predict    # Make predictions
  gtools run uavarprior analyze    # Analyze variant data
  ```

## Troubleshooting

### Common Issues

1. **Tool not found**:
   - Ensure your environment is properly loaded: `gtools env`
   - Check if symlinks are properly set up in your home directory

2. **Command not executing properly**:
   - Ensure the script has executable permissions: `chmod +x ~/genomics-git-organization/utils/gitorg`

3. **Project import errors**:
   - Verify the project is installed: `gtools repo install [project]`
   - Check PYTHONPATH includes the project directory

### Getting Help

For more detailed help on specific tools:

- `gtools help` - Basic help information
- `gtools extended` - Extended help with examples
- `gtools nav --help` - Help for navigation tool
- `gtools repo --help` - Help for repository management tool

## Additional Resources

For more information about specific projects, refer to their respective README files:

- FuGEP: `/home/sdodl001/FuGEP/README.md`
- GenomicLightning: `/home/sdodl001/GenomicLightning/README.md`
- TransMet: `/home/sdodl001/TransMet/README.rst`
- UAVarPrior: UAVarPrior documentation in `/home/sdodl001/UAVarPrior/docs/`

---

*This organization structure was created on May 26, 2025.*
