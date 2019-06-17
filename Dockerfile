FROM python:3.7
LABEL maintainer="jonathan@peoplesized.com"

# Install the C compiler tools
RUN apt-get update -y && \
  apt-get install build-essential -y && \
  pip install --upgrade pip

# Install libspatialindex
WORKDIR /tmp
RUN wget http://download.osgeo.org/libspatialindex/spatialindex-src-1.9.0.tar.gz && \
  tar -xvzf spatialindex-src-1.9.0.tar.gz && \
  cd spatialindex-src-1.9.0 && \
  ./configure && \
  make && \
  make install && \
  cd - && \
  rm -rf spatialindex-src-1.9.0* && \
  ldconfig

# Install rtree and geopandas
RUN pip install rtree geopandas