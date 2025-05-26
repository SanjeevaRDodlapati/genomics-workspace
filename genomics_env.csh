#!/bin/tcsh
# genomics_env.csh - Environment loader for genomics projects
# Version: 1.0

# Set base paths
setenv GENOMICS_BASE "$HOME/genomics-git-organization"
setenv FUGEP_PATH "$HOME/FuGEP"
setenv LIGHTNING_PATH "$HOME/GenomicLightning"
setenv TRANSMET_PATH "$HOME/TransMet"
setenv UAVARPRIOR_PATH "$HOME/UAVarPrior"

# Add utils to path
setenv PATH "${GENOMICS_BASE}/utils:${PATH}"

# Set Python path
setenv PYTHONPATH "${FUGEP_PATH}:${LIGHTNING_PATH}:${TRANSMET_PATH}:${UAVARPRIOR_PATH}:${PYTHONPATH}"

# Load specific environment if requested
if ("$1" == "tensorflow") then
    echo "Loading TensorFlow environment..."
    module load tensorflow-gpu/2.16.1
else if ("$1" == "pytorch") then
    echo "Loading PyTorch environment..."
    module load pytorch
endif

# Print environment info
echo "Genomics Environment Loaded:"
echo "- Base directory: ${GENOMICS_BASE}"
echo "- Projects:"
echo "  - FuGEP: ${FUGEP_PATH}"
echo "  - GenomicLightning: ${LIGHTNING_PATH}" 
echo "  - TransMet: ${TRANSMET_PATH}"
echo "  - UAVarPrior: ${UAVARPRIOR_PATH}"
echo ""
echo "Available tools:"
echo "  - gtools: Unified command interface"
echo "  - gitorg: Project navigation"
echo "  - repoutil: Repository management"
echo "  - project: Project management"
echo ""
echo "Environment ready for use."
