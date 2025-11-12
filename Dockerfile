# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

ARG RUN_FILE=sicl-25.11-1.cuda128.ubuntu2004.run
ENV RUN_FILE=${RUN_FILE}

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    bash curl coreutils util-linux ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
COPY ${RUN_FILE} /opt/${RUN_FILE}
RUN chmod +x /opt/${RUN_FILE}

CMD ["/bin/bash", "-c", "\
    set -eux; \
    cp /opt/${RUN_FILE} /host/tmp/${RUN_FILE}; \
    chmod +x /host/tmp/${RUN_FILE}; \
    chroot /host /bin/bash /tmp/${RUN_FILE}; \
    tail -f /dev/null \
    "]
