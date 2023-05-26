FROM fedora:38

ARG GIT_HEAD=development
ARG BUILD_CONFIG=profile
ARG USER_NAME=user1
ARG PROJ_NAME=proj

ENV PROJ_PATH=/home/$USER_NAME/O3DE/Projects/$PROJ_NAME
ENV O3DE_PACKAGE_DIR=/home/$USER_NAME/o3de-packages

RUN dnf update -y

RUN dnf install -y openssl cmake clang ninja-build git git-lfs openssl-devel libunwind-devel libzstd-devel which \
		zlib-devel libxkbcommon-x11-devel libcurl-devel fontconfig-devel libxcb-devel mesa-libGLU-devel \
                qt5-qtbase-devel lldb

RUN useradd -ms /bin/bash $USER_NAME

USER $USER_NAME
 
WORKDIR /home/$USER_NAME

RUN git clone https://github.com/o3de/o3de.git

WORKDIR o3de

RUN git checkout $GIT_HEAD

RUN mkdir $O3DE_PACKAGE_DIR

RUN git lfs pull

RUN python/get_python.sh

RUN cmake -B build/linux -S . -G "Ninja Multi-Config" -DLY_3RDPARTY_PATH=$O3DE_PACKAGE_DIR

RUN cmake --build build/linux --target Editor --config $BUILD_CONFIG

RUN scripts/o3de.sh register --this-engine

RUN scripts/o3de.sh create-project --project-path $PROJ_PATH

WORKDIR $PROJ_PATH

RUN cmake -B build/linux -S . -G "Ninja Multi-Config"

RUN cmake --build build/linux --target $PROJ_NAME.GameLauncher Editor --config $BUILD_CONFIG -j $NUM_JOBS
