#!/bin/tcsh
# standardize_project_configs.tcsh
# Script to standardize the configurations across genomics projects

set HOME_DIR="/home/sdodl001"
set TEMPLATE_DIR="$HOME_DIR/genomics-git-organization/documentation/templates"
set PROJECTS=( "FuGEP" "GenomicLightning" "TransMet" "UAVarPrior" )

# Create the templates directory if it doesn't exist
mkdir -p $TEMPLATE_DIR

# Create a template for standard project README
cat > "$TEMPLATE_DIR/README_TEMPLATE.md" << 'EOF'
# PROJECT_NAME

## Overview

Brief description of the project.

## Installation

```bash
# Clone the repository
git clone https://github.com/username/PROJECT_NAME.git
cd PROJECT_NAME

# Install dependencies
pip install -r requirements.txt

# Install the package in development mode
pip install -e .
```

## Usage

```python
import PROJECT_IMPORT

# Example usage
```

## Features

- Feature 1
- Feature 2
- Feature 3

## Development

### Setting Up Development Environment

```bash
# Run the deployment script to set up development environment
./deploy.sh
```

### Running Tests

```bash
pytest
```

## License

This project is licensed under the LICENSE_TYPE - see the LICENSE file for details.
EOF

# Create a template for CI workflow
cat > "$TEMPLATE_DIR/ci_workflow_template.yml" << 'EOF'
name: CI

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  tests:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, '3.10']

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v2
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
        pip install pytest pytest-cov
    - name: Install package
      run: |
        pip install -e .
    - name: Test with pytest
      run: |
        pytest --cov=PROJECT_PACKAGE tests/
EOF

# Create a template for project gitignore
cat > "$TEMPLATE_DIR/gitignore_template" << 'EOF'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
dist/
build/
*.egg-info/
*.egg
MANIFEST

# Unit test / coverage reports
htmlcov/
.tox/
.coverage
.coverage.*
.cache
coverage.xml
*.cover
.pytest_cache/

# Jupyter Notebook
.ipynb_checkpoints

# Environments
.env
.venv
env/
venv/
ENV/

# IDE files
.idea/
.vscode/
*.swp
*.swo

# Output files
*.log
output/
results/
EOF

echo "🧰 Standardizing project configurations..."

foreach project ($PROJECTS)
    echo "\n🔧 Working on $project..."
    cd $HOME_DIR/$project
    
    # Create standard directories if they don't exist
    echo "  Creating standard directories..."
    mkdir -p configs docs tests examples scripts
    
    # Create a .github directory with workflows if it doesn't exist
    if (! -d .github/workflows) then
        mkdir -p .github/workflows
        echo "  Setting up GitHub workflow configuration..."
        sed "s/PROJECT_PACKAGE/`basename $project | tr '[:upper:]' '[:lower:]'`/g" $TEMPLATE_DIR/ci_workflow_template.yml > .github/workflows/ci.yml
    endif
    
    # Create/update .gitignore if it doesn't exist
    if (! -f .gitignore) then
        echo "  Creating standard .gitignore..."
        cp $TEMPLATE_DIR/gitignore_template .gitignore
    endif
    
    # Create/update LICENSE if it doesn't exist
    if (! -f LICENSE && -f LICENSE.txt) then
        echo "  Standardizing LICENSE file name..."
        cp LICENSE.txt LICENSE
    endif
    
    # Create a quick pytest configuration if it doesn't exist
    if (! -f pytest.ini) then
        echo "  Creating pytest configuration..."
        cat > pytest.ini << 'EOF'
[pytest]
testpaths = tests
python_files = test_*.py
EOF
    endif
end

# Create a central management script for all projects
cat > "$HOME_DIR/genomics-git-organization/utils/project_manager.tcsh" << 'EOF'
#!/bin/tcsh
# project_manager.tcsh - Utility to manage genomics projects

set USAGE = "Usage: project_manager.tcsh [command] [project] [options]

Commands:
  status      - Show status of all projects or a specific project
  update      - Update all projects or a specific project
  create      - Create a new project with standard structure
  fix         - Fix standardization issues in a project
  
Examples:
  project_manager.tcsh status           # Status of all projects
  project_manager.tcsh status FuGEP     # Status of FuGEP project
  project_manager.tcsh update TransMet  # Update TransMet
  project_manager.tcsh create NewPrj    # Create a new project"

set HOME_DIR="/home/sdodl001"
set PROJECTS=( "FuGEP" "GenomicLightning" "TransMet" "UAVarPrior" )

if ($#argv < 1) then
    echo "$USAGE"
    exit 1
endif

set COMMAND = $argv[1]

switch($COMMAND)
    case "status":
        if ($#argv > 1) then
            set PROJECT = $argv[2]
            if (-d "$HOME_DIR/$PROJECT") then
                echo "Status for $PROJECT:"
                cd "$HOME_DIR/$PROJECT"
                if (-d .git) then
                    git status -s
                    git log -1 --pretty=format:"Last commit: %h - %s (%cr)"
                    echo ""
                else
                    echo "Not a git repository."
                endif
                
                # Check for key files
                if (! -f setup.py && ! -f pyproject.toml) then
                    echo "⚠️  No setup.py or pyproject.toml found"
                endif
                
                if (! -f requirements.txt) then
                    echo "⚠️  No requirements.txt found"
                endif
                
                if (! -d tests) then
                    echo "⚠️  No tests directory found" 
                endif
            else
                echo "Error: Project $PROJECT not found."
            endif
        else
            echo "Status for all projects:"
            echo "======================="
            foreach project ($PROJECTS)
                echo "\n[$project]"
                if (-d "$HOME_DIR/$project/.git") then
                    cd "$HOME_DIR/$project"
                    git status -s
                else
                    echo "Not a git repository."
                endif
            end
        endif
        breaksw
        
    case "update":
        if ($#argv > 1) then
            set PROJECT = $argv[2]
            if (-d "$HOME_DIR/$PROJECT") then
                echo "Updating $PROJECT..."
                cd "$HOME_DIR/$PROJECT"
                if (-f deploy.sh) then
                    bash deploy.sh
                else
                    echo "No deploy.sh script found."
                endif
            else
                echo "Error: Project $PROJECT not found."
            endif
        else
            echo "Updating all projects..."
            foreach project ($PROJECTS)
                echo "\n[$project]"
                if (-d "$HOME_DIR/$project") then
                    cd "$HOME_DIR/$project"
                    if (-f deploy.sh) then
                        bash deploy.sh
                    else
                        echo "No deploy.sh script found."
                    endif
                endif
            end
        endif
        breaksw
        
    case "create":
        if ($#argv < 2) then
            echo "Error: Project name required."
            echo "$USAGE"
            exit 1
        endif
        
        set PROJECT = $argv[2]
        if (-d "$HOME_DIR/$PROJECT") then
            echo "Error: Directory $PROJECT already exists."
            exit 1
        endif
        
        echo "Creating new project: $PROJECT"
        mkdir -p "$HOME_DIR/$PROJECT"
        cd "$HOME_DIR/$PROJECT"
        
        # Create standard directories
        mkdir -p configs docs tests examples scripts
        
        # Create basic files
        echo "# $PROJECT" > README.md
        echo "Creating project structure..."
        
        # Create basic setup.py
        cat > setup.py << EOF
from setuptools import setup, find_packages

setup(
    name="$PROJECT",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        # Add dependencies here
    ],
    author="",
    author_email="",
    description="$PROJECT - Genomics Analysis Package",
    keywords="genomics, bioinformatics",
    url="",
)
EOF
        
        # Create requirements.txt
        cat > requirements.txt << EOF
# Core requirements
numpy
pandas
matplotlib
# Add other dependencies as needed
EOF
        
        # Create pytest.ini
        cat > pytest.ini << EOF
[pytest]
testpaths = tests
python_files = test_*.py
EOF
        
        # Create main package directory
        set PACKAGE_NAME = `echo $PROJECT | tr '[:upper:]' '[:lower:]'`
        mkdir -p $PACKAGE_NAME
        cat > $PACKAGE_NAME/__init__.py << EOF
"""$PROJECT - Genomics Analysis Package."""

__version__ = "0.1.0"
EOF
        
        # Create deploy.sh
        cat > deploy.sh << EOF
#!/bin/bash
# Standard deployment script for $PROJECT
echo "Deploying $PROJECT..."

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
        chmod +x deploy.sh
        
        # Initialize git repo
        git init
        echo "# Core files" > .gitignore
        cat "$HOME_DIR/genomics-git-organization/documentation/templates/gitignore_template" >> .gitignore
        
        echo "\n✅ Project $PROJECT created successfully!"
        echo "Next steps:"
        echo "1. cd $PROJECT"
        echo "2. ./deploy.sh"
        echo "3. Edit setup.py with your project details"
        breaksw
        
    case "fix":
        if ($#argv > 1) then
            set PROJECT = $argv[2]
            if (-d "$HOME_DIR/$PROJECT") then
                echo "Fixing standardization for $PROJECT..."
                cd "$HOME_DIR/$PROJECT"
                
                # Create standard directories if they don't exist
                foreach dir (configs docs tests examples scripts)
                    if (! -d $dir) then
                        mkdir -p $dir
                        echo "Created missing directory: $dir"
                    endif
                end
                
                # Create deploy.sh if missing
                if (! -f deploy.sh) then
                    cat > deploy.sh << EOF
#!/bin/bash
# Standard deployment script for $PROJECT
echo "Deploying $PROJECT..."

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
                    chmod +x deploy.sh
                    echo "Created missing deploy.sh"
                endif
                
                # Create VERSION if missing
                if (! -f VERSION) then
                    echo "0.1.0" > VERSION
                    echo "Created missing VERSION file"
                endif
                
                echo "\n✅ Standardization fixes applied to $PROJECT"
            else
                echo "Error: Project $PROJECT not found."
            endif
        else
            echo "Error: Project name required for fix command."
            echo "$USAGE"
        endif
        breaksw
        
    default:
        echo "Unknown command: $COMMAND"
        echo "$USAGE"
        breaksw
endsw
EOF

# Make the project manager script executable
chmod +x "$HOME_DIR/genomics-git-organization/utils/project_manager.tcsh"

# Create a symlink to the project manager in the home directory
ln -sf "$HOME_DIR/genomics-git-organization/utils/project_manager.tcsh" "$HOME_DIR/project_manager"

# Update gtools to include the project manager
if (-e "$HOME_DIR/gtools") then
    set GTOOLS_FILE = "$HOME_DIR/genomics-git-organization/launcher/genomics-tools.sh"
    
    # Update the gtools script if the project command doesn't exist
    if (`grep -c "project|proj|p)" $GTOOLS_FILE` == 0) then
        echo "  Updating gtools with project management capability..."
        
        # Find the case statement section in the gtools file
        sed -i '/case "$1" in/a\\    project|proj|p)\n        shift\n        /home/sdodl001/genomics-git-organization/utils/project_manager.tcsh "$@"\n        ;;\n' $GTOOLS_FILE
        
        # Update the help function to include the new option
        sed -i '/Available tools:/a\\  project     - Project management tools' $GTOOLS_FILE
        
        # Add example for project management
        sed -i '/Examples:/a\\  $(basename "$0") project create NewProject' $GTOOLS_FILE
    endif
endif

echo "\n✅ Project standardization complete!"
echo "Your genomics projects now have consistent structure and configurations."
echo "To manage your projects, use the project_manager script:"
echo "  ./project_manager status        # Check status of all projects"
echo "  ./project_manager create NewPrj # Create a new project with standard structure"
echo "Or use gtools:"
echo "  gtools project status           # Check status of all projects"
echo "  gtools project create NewPrj    # Create a new project"
