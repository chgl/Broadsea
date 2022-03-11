FROM ubuntu:20.04

WORKDIR /opt/achilles
ENV DATABASECONNECTOR_JAR_FOLDER="/opt/achilles/drivers"

RUN groupadd -g 10001 achilles && \
  useradd -u 10001 -g achilles achilles && \
  mkdir ./output && \
  mkdir ./drivers && \
  chown -R achilles .

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3008,DL3009
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  software-properties-common \
  libcurl4-openssl-dev \
  libssl-dev \
  openjdk-11-jdk \
  libxml2-dev \
  locales \
  wget && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  locale-gen en_US.utf8 && \
  /usr/sbin/update-locale LANG=en_US.UTF-8 && \
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  r-base \
  r-base-dev && \
  rm -rf /var/lib/apt/lists/* && \
  R CMD javareconf

# TODO: install_version with pinned versions for reproducable builds?
RUN R -e "install.packages(c('remotes', 'rJava', 'httr', 'rjson', 'ParallelLogger', 'SqlRender', 'DatabaseConnector'))" && \
  R -e "library(DatabaseConnector); downloadJdbcDrivers('postgresql')"

RUN R -e "remotes::install_github('OHDSI/Achilles@c6b7adb6330e75c2311880db2eb3dc4c12341c4f')"

COPY entrypoint.r ./

USER 10001
CMD ["Rscript", "entrypoint.r"]
