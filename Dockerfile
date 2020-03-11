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
  apt-get install -y r-base libspatialindex-c5

# Install common Python and R dependencies
RUN pip install rtree geopandas
RUN Rscript -e "install.packages(c('geojsonio', 'jsonlite', 'devtools', 'ranger', 'mgcv', 'RANN', 'httr', 'caret', 'parallel', 'spaMM', 'rjson'))"
