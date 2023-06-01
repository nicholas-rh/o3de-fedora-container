# Build from within the container after making code changes
ENGINE_DIR=${1:-$HOME/o3de}
PACKAGE_DIR=${2:-$HOME/o3de-packages}
PROJECT_NAME=${4:-proj}
PROJECT_DIR=${3:-$HOME/O3DE/Projects/$PROJECT_NAME}

# Build the engine
cd $ENGINE_DIR
cmake -B build/linux -S . -G "Ninja Multi-Config" -DLY_3RDPARTY_PATH=$PACKAGE_DIR
cmake --build build/linux --target Editor --config profile

# Build the project
cd $PROJECT_DIR
cmake -B build/linux -S . -G "Ninja Multi-Config"
cmake --build build/linux --target $PROJECT_NAME.GameLauncher Editor --config profile
