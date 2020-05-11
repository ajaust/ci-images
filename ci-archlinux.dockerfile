FROM archlinux:latest

# Add the precice user to run test with mpi
RUN useradd -m -s /bin/bash precice
ENV PRECICE_USER precice

# Install necessary dependencies for preCICE
# Installing PETSc from AUR requires a non-root user
RUN pacman -Syu --needed --noconfirm git cmake make base-devel gcc clang libxml2 boost eigen python python-numpy
RUN useradd -m -G wheel aur && \
    echo "%wheel         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    su -l aur -c "git clone https://aur.archlinux.org/petsc.git && cd petsc && yes | makepkg -si" && \
    userdel -rf aur && \
    yes | pacman -Scc
