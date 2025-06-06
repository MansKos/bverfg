FROM rocker/r-ver:4.4.0

#RUN sudo apt-get remove -y rstudio-server # only if tidyverse or verse base images used

# Update package lists and install essential packages first
RUN apt-get update && apt-get upgrade -y

# TeX layer
RUN apt-get update && apt-get install -y pandoc pandoc-citeproc texlive-science texlive-latex-extra texlive-lang-german

# System dependency layer - install packages individually to avoid issues
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    libatlas3-base \
    libopenblas-base \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libmagick++-dev \
    libpoppler-cpp-dev \
    libsodium-dev \
    libudunits2-dev \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libglpk-dev \
    tesseract-ocr \
    tesseract-ocr-deu

# Python layer
COPY etc/requirements-python.txt .
RUN pip install -r requirements-python.txt

# R layer
COPY etc/requirements-R.R .
RUN Rscript requirements-R.R

# Settings
WORKDIR /ce-bverfg

CMD "R"
