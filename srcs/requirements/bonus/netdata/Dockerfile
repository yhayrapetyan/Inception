FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN DISTRO_CODENAME="$(awk -F= '/VERSION_CODENAME/{print $2}' /etc/os-release)" && \
    echo "deb http://deb.debian.org/debian ${DISTRO_CODENAME}-backports main" > /etc/apt/sources.list.d/backports.list && \
    chown _apt:root /var/cache/apt /var/lib/apt && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends \
                    autoconf \
                    autoconf-archive \
                    automake \
                    bison \
                    build-essential \
                    ca-certificates \
                    cmake \
                    curl \
                    flex \
                    git \
                    jq \
                    libcurl4-openssl-dev \
                    libgcrypt-dev \
                    libjson-c-dev \
                    liblz4-dev \
                    libmariadb-dev \
                    libmnl-dev \
                    libmongoc-dev \
                    libpcre2-dev \
                    libprotobuf-dev \
                    libsnappy-dev \
                    libssl-dev \
                    libsystemd-dev \
                    libtool \
                    libuv1-dev \
                    libyaml-dev \
                    libzstd-dev \
                    ninja-build \
                    openssl \
                    patch \
                    pkgconf \
                    protobuf-compiler \
                    python3 \
                    python3-dev \
                    uuid-dev \
                    zlib1g-dev && \
    if [ "$(uname -m)" != "ppc64le" ]; then \
        apt-get install -y --no-install-recommends libfreeipmi-dev libipmimonitoring-dev || exit 1 ; \
    fi && \
    mkdir -p /deps/etc && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

ENV PATH="/usr/local/go/bin:${PATH}"

ADD https://raw.githubusercontent.com/netdata/netdata/master/packaging/check-for-go-toolchain.sh /tmp/check-for-go-toolchain.sh

RUN . /tmp/check-for-go-toolchain.sh && \
    if ! ensure_go_toolchain; then \
        echo "ERROR: ${GOLANG_FAILURE_REASON}" && exit 1 ; \
    fi

RUN curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh

RUN chmod +x /tmp/netdata-kickstart.sh

RUN /tmp/netdata-kickstart.sh

COPY ./tools/run_netdata.sh .

RUN chmod +x run_netdata.sh

EXPOSE 19999

CMD ["./run_netdata.sh"]
