#!/bin/sh

activate_env() {
  ENV_NAME=$2

  SOURCE_CMD="source $HOME/.bashrc"
  echo $SOURCE_CMD
  eval $SOURCE_CMD

  echo "Using conda installation at $(which conda)"
  ACT_CMD="conda activate $ENV_NAME"

  echo $ACT_CMD
  eval $ACT_CMD

  echo "Using python: $(which python)"
}


install_deps() {
  OUTPUT_BASE=$1

  cd "$OUTPUT_BASE/SMARTS"
  echo "Current directory: $PWD"
  
  SMARTS_INSTALL_CMD="pip install -e ."
  echo $SMARTS_INSTALL_CMD
  eval $SMARTS_INSTALL_CMD

  cd "competition/track1"
  echo "Current directory: $PWD"

  TRAIN_INSTALL_CMD="pip install -e ./train"
  echo $TRAIN_INSTALL_CMD
  eval $TRAIN_INSTALL_CMD
}

activate_env

if [ $? -eq 0 ]; then
   echo "Activated environment successfully"
else
   echo "Failed to activate environment. Exiting"
   exit 1
fi

install_deps

if [ $? -eq 0 ]; then
   echo "Installed deps succesfully. Completed set up"
   DATE_END = $(date +"%Y-%m-%d--%H-%M-%S")
   echo "Script completed successfully at $DATE_END"
else
   echo "Failed to install deps. Exiting"
   exit 1
fi

cd "$1/SMARTS/competition/track1/train"
echo "Running run.py with python: $(which python)"

python run.py