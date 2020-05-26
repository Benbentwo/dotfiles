Ver=3.7.0

apt -y install yum-utils && \
    apt-builddep -y python && \
    apt -y install make && \
    apt -y clean all

curl -O https://www.python.org/ftp/python/${Ver}/Python-${Ver}.tgz && \
    tar -xf Python-${Ver}.tgz && \
    cd Python-${Ver} && \
    ./configure && \
    make && \
    make install

