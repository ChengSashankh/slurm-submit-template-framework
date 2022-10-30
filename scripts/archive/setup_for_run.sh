## NOT USED

# #!/bin/sh

# ################################################################
# # Args: 
# # $1: Source zip
# # $2: Working directory base  
# # $3: Conda environment name
# ################################################################
# # sh ./setup-for-run.sh $HOME/curr/repo.zip $HOME/runs py38new
# ################################################################

# unzip_source() {
#   SRC_FILE=$1
#   OUTPUT_BASE="$2/$(date +"%Y%m%d-%H%M%s")"

#   mkdir -p $OUTPUT_BASE
  
#   echo "Reading repo from $SRC_FILE"
#   echo "Writing extract to $OUTPUT_BASE"

#   UNZIP_CMD="unzip $SRC_FILE -d $OUTPUT_BASE"
#   echo $UNZIP_CMD

#   eval $UNZIP_CMD
# }

# activate_env() {
#   ENV_NAME=$3

#   SOURCE_CMD="source $HOME/.bashrc"
#   echo $SOURCE_CMD
#   eval $SOURCE_CMD

#   echo "Using conda installation at $(which conda)"
#   ACT_CMD="conda activate $ENV_NAME"

#   echo $ACT_CMD
#   eval $ACT_CMD

#   echo "Using python: $(which python)"
# }

# install_deps() {
#   cd "$OUTPUT_BASE/SMARTS"
#   echo "Current directory: $PWD"
  
#   SMARTS_INSTALL_CMD="pip install -e ."
#   echo $SMARTS_INSTALL_CMD
#   eval $SMARTS_INSTALL_CMD

#   cd "competition/track1"
#   echo "Current directory: $PWD"

#   TRAIN_INSTALL_CMD="pip install -e ./train"
#   echo $TRAIN_INSTALL_CMD
#   eval $TRAIN_INSTALL_CMD
# }


# ################################################################
# # Main
# ################################################################

# DATE_START = $(date +"%Y-%m-%d--%H-%M-%S")
# echo "Script triggered with params $* at $DATE_START"

# unzip_source

# if [ $? -eq 0 ]; then
#    echo "Unzipped source successfully"
# else
#    echo "Failed to unzip source. Exiting"
#    exit 1
# fi

# activate_env

# if [ $? -eq 0 ]; then
#    echo "Activated environment successfully"
# else
#    echo "Failed to activate environment. Exiting"
#    exit 1
# fi

# install_deps

# if [ $? -eq 0 ]; then
#    echo "Installed deps succesfully. Completed set up"
#    DATE_END = $(date +"%Y-%m-%d--%H-%M-%S")
#    echo "Script completed successfully at $DATE_END"
# else
#    echo "Failed to install deps. Exiting"
#    exit 1
# fi
