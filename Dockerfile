FROM python:3.7.7-buster
LABEL maintainer="jonathan@peoplesized.com"

# Install the C compiler tools
RUN apt-get update -y && \
  apt-get install build-essential -y && \
  pip install --upgrade pip

# Install R latest (~3.6?)
RUN apt-get install -y dirmngr --install-recommends && \
  apt-get install -y software-properties-common && \
  apt-get install -y apt-transport-https && \
  apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian buster-cran35/' && \
  apt-get update -y && \ 
  apt-get install -y r-base

# Install libspatialindex
WORKDIR /tmp
RUN wget https://github.com/libspatialindex/libspatialindex/releases/download/1.9.3/spatialindex-src-1.9.3.tar.gz && \
  tar -xvzf spatialindex-src-1.9.3.tar.gz && \
  cd spatialindex-src-1.9.3 && \
  ./configure && \
  make && \
  make install && \
  cd - && \
  rm -rf spatialindex-src-1.9.3* && \
  ldconfig

# Install rtree and geopandas
RUN pip install rtree geopandas
