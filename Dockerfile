FROM centos:7

RUN yum install -y yum-utils \
      device-mapper-persistent-data \
      lvm2

RUN yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo

RUN yum install docker-ce -y
RUN yum -y install initscripts && yum clean all
RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum -y install nodejs

COPY ./ /project/
RUN cd /project & npm install express --save
RUN chmod +x /project/entrypoint.sh

EXPOSE 80 3000 8761
CMD ["/project/entrypoint.sh"]