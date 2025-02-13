FROM fedora:34

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER=precice

# Install necessary dependencies for preCICE and PETSc
RUN dnf -y update && \
    dnf -y install \
    git \
    cmake \
    curl \
    wget \
    ccache \
    gcc-c++ \
    libxml2-devel \
    boost-devel \
    petsc-mpich-devel \
    mpich-devel \
    eigen3-devel \
    python3-devel \
    environment-modules \
    && \
    dnf clean all && \
    echo "module load mpi/mpich-x86_64" > /etc/profile.d/mpich.sh

# Run interactively using a bash login shell
CMD [ "bash", "--login" ]
