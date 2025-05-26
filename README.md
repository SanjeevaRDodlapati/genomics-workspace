# Genomics Workspace

A coordinated development environment for genomics research projects.

## Projects

This workspace contains the following genomics research projects as submodules:

- **UAVarPrior**: Advanced variant prioritization using deep learning
- **GenomicLightning**: High-performance genomics model training framework  
- **FuGEP**: Functional Genomics Prediction pipeline
- **TransMet**: Transfer learning for methylation analysis

## Quick Start

```bash
# Clone with all submodules
git clone --recursive https://github.com/[username]/genomics-workspace.git

# Or if already cloned, initialize submodules
git submodule update --init --recursive
```

## Development Workflow

### 1. Working with Submodules

```bash
# Update all submodules to latest
./scripts/update_all_submodules.sh

# Sync and push all repositories
./scripts/sync_all_repos.sh
```

### 2. Coordinated Releases

```bash
# Create coordinated release across all projects
./scripts/create_release.sh v1.0.0
```

### 3. Testing

```bash
# Run integration tests across all projects
./scripts/run_integration_tests.sh
```

## Repository Structure

```
genomics-workspace/
├── docs/                    # Shared documentation
│   ├── architecture/        # System architecture docs
│   ├── guides/             # Development guides
│   └── apis/               # API documentation
├── scripts/                # Automation scripts
│   ├── deployment/         # Deployment automation
│   ├── testing/            # Testing utilities
│   └── maintenance/        # Maintenance tasks
├── configs/                # Shared configurations
│   ├── shared/             # Shared config templates
│   └── environment/        # Environment setup
├── releases/               # Release artifacts
├── UAVarPrior/            # Submodule: Variant prioritization
├── GenomicLightning/      # Submodule: Training framework
├── FuGEP/                 # Submodule: Functional genomics
└── TransMet/              # Submodule: Transfer learning
```

## Contributing

1. Each project maintains its own development workflow
2. Coordinated changes use the meta-repository workflow
3. All commits follow conventional commit standards
4. Integration tests must pass before merging

## Release Management

- Semantic versioning across all projects
- Coordinated releases with compatibility matrix
- Automated dependency management
- Change logs aggregated across projects
