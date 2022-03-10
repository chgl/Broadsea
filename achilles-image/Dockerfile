FROM ubuntu:20.04

WORKDIR /opt/achilles
ENV DATABASECONNECTOR_JAR_FOLDER="/opt/achilles/drivers"

RUN groupadd -g 10001 achilles && \
  useradd -u 10001 -g achilles achilles && \
  mkdir ./output && \
  mkdir ./drivers && \
  chown -R achilles .

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
  /usr/sbin/update-locale LANG=en_US.UTF-8

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# via https://cran.r-project.org/bin/linux/ubuntu/
# hadolint ignore=DL3008
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  r-base \
  r-base-dev && \
  rm -rf /var/lib/apt/lists/* && \
  R CMD javareconf

# TODO: https://cran.r-project.org/web/packages/SqlRender/index.html SqlRender from cran
RUN R -e "install.packages(c('remotes', 'rJava', 'httr', 'rjson', 'ParallelLogger'))" && \
  R -e "remotes::install_github('OHDSI/SqlRender@a3b38a9306c651b005718acf1aaaef35d7b56d50')" && \
  R -e "remotes::install_github('OHDSI/Castor@a64faf53509b50bfedf9057f042355fe2e17974b')" && \
  R -e "remotes::install_github('OHDSI/DatabaseConnector@b3d3162711aad954c3eb649751544c7a3d01455c')" && \
  R -e "library(DatabaseConnector); downloadJdbcDrivers('postgresql')"

RUN R -e "remotes::install_github('OHDSI/Achilles@c6b7adb6330e75c2311880db2eb3dc4c12341c4f')"

COPY entrypoint.r ./

USER 10001
CMD ["Rscript", "entrypoint.r"]
