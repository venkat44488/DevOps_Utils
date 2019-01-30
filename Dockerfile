FROM centos
MAINTAINER venkat44488@gmail.com
RUN yum -y update && \
    yum install epel-release -y && \
    yum install --enablerepo=epel nginx -y

COPY ./index.html /usr/share/nginx/html
CMD ["nginx", "-g","daemon off;"]
EXPOSE 80

#command to build dockerfile is docker build "mytestimage" -t .
