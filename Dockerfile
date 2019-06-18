FROM python:3.7
LABEL maintainer="jonathan@peoplesized.com"

# Install the C compiler tools
RUN apt-get update -y && \
  apt-get install build-essential -y && \
  pip install --upgrade pip

RUN deb http://cran.rstudio.com/bin/linux/debian stretch-cran34/ && \
        sudo apt install dirmngr && \
        sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' &&\
        apt-get update && apt-get install -y r-base


# Install libspatialindex
WORKDIR /tmp
RUN wget http://download.osgeo.org/libspatialindex/spatialindex-src-1.8.5.tar.gz && \
  tar -xvzf spatialindex-src-1.8.5.tar.gz && \
  cd spatialindex-src-1.8.5 && \
  ./configure && \
  make && \
  make install && \
  cd - && \
  rm -rf spatialindex-src-1.8.5* && \
  ldconfig

# Install rtree and geopandas
RUN pip install rtree geopandas
