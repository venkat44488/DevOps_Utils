FROM centos
MAINTAINER venkat44488@gmail.com

COPY ./index.html /usr/share/nginx/html
CMD ["nginx", "-g","daemon off;"]
EXPOSE 80

#command to build dockerfile is docker build "mytestimage" -t .
