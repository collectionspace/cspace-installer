FROM ubuntu:20.04
MAINTAINER mark.cooper@lyrasis.org

RUN (echo 'root'; echo 'root') | passwd root && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        aptitude \
        openssh-server \
        python3 \
        python3-apt \
        systemctl \
        sudo && \
    mkdir /var/run/sshd && \
    sed -i -E 's/(#|^)PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22 8080
CMD ["/usr/sbin/sshd", "-D"]
