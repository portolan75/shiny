# This Dockerfile includes the following five steps:

#     - Import Ubuntu version 24.04 image as the baseline image
#     - Set arguments and environment variables. That includes the R version settings, the CRAN mirror, etc.
#     - Install R dependencies and command lines tools- Debian libraries (git, C and Fortran compilers, vim, curl, etc.)
#     - Install R and set it, and Quarto
#     - Set Python virtual environment and install radian

# Setting an R environment from scratch 
# Step 1 - Import base image
FROM ubuntu:24.04

# Step 2 - Set arguments and environment variables
# Define arguments
ARG VENV_NAME=SHINY_STOCK_ANALYZER
ARG R_VERSION_MAJOR=4
ARG R_VERSION_MINOR=4
ARG R_VERSION_PATCH=2
ARG DEBIAN_FRONTEND=noninteractive
ARG CRAN_MIRROR=https://cran.rstudio.com/
ARG QUARTO_VER="1.6.40"

# Define environment variables
ENV VENV_NAME=$VENV_NAME
ENV R_VERSION_MAJOR=$R_VERSION_MAJOR
ENV R_VERSION_MINOR=$R_VERSION_MINOR
ENV R_VERSION_PATCH=$R_VERSION_PATCH
ENV QUARTO_VER=$QUARTO_VER
ENV CONFIGURE_OPTIONS="--with-cairo --with-jpeglib --enable-R-shlib --with-blas --with-lapack"
ENV TZ=UTC
ENV CRAN_MIRROR=$CRAN_MIRROR

# Step 3 - Install R dependencies
# Since we are using Ubuntu base image, we must first install the Debian dependencies that R requires before we can install it. 
# We will use the apt-get command to install those dependencies and some command-line tools.
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils\
    gfortran \
    git \
    g++ \
    libreadline-dev \
    libx11-dev \
    libxt-dev \
    libpng-dev \
    libjpeg-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libudunits2-dev \
    libgdal-dev \
    libbz2-dev \
    libzstd-dev \
    liblzma-dev \
    libpcre2-dev \
    locales \
    openjdk-8-jdk \
    screen \
    texinfo \
    texlive \
    texlive-fonts-extra \
    vim \
    wget \
    xvfb \
    tzdata \
    sudo\
    jq\
    curl\
    libgit2-dev \
    libmagick++-dev \
    make \
    tmux \
    python3-launchpadlib \
    python3-dev \
    python3-venv \
    python3-pip \
    lsof \
    && rm -rf /var/lib/apt/lists/*

# Step 4 - Install R
RUN wget https://cran.rstudio.com/src/base/R-${R_VERSION_MAJOR}/R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz && \
    tar zxvf R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz && \
    rm R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz

WORKDIR /R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}

RUN ./configure ${CONFIGURE_OPTIONS} && \
    make && \
    make install

RUN locale-gen en_US.UTF-8

WORKDIR /root

RUN mkdir settings

# Step 5 - Install R packages
COPY packages.json install_packages.R requirements.txt install_quarto.sh ./settings/
RUN Rscript ./settings/install_packages.R

# Step 6 - Install Quarto
RUN bash ./settings/install_quarto.sh $QUARTO_VER

# Step 7 - Copy Rprofile in root
COPY .Rprofile /root/

# Step 8 - Set Python Environmentt
RUN python3 -m venv /opt/$VENV_NAME  \
    && export PATH=/opt/$VENV_NAME/bin:$PATH \
    && echo "source /opt/$VENV_NAME/bin/activate" >> ~/.bashrc

# Step 9 - Install radian (to run R on the command line)
RUN /opt/$VENV_NAME/bin/pip install --requirement ./settings/requirements.txt
# NOTE: Instead of using pip3 install, which tries to install packages system-wide (not allowed in Ubuntu 24.04), \
# We directly call pip from the virtual environment (/opt/$VENV_NAME/bin/pip), ensuring packages are installed inside the environment.