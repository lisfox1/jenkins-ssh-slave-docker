FROM jenkinsci/ssh-slave
LABEL MAINTAINER="Krzysztof Lis <lisfox1@gmail.com>"

#Update the apt package index:
RUN apt-get update

#Install packages to allow apt to use a repository over HTTPS
RUN apt-get install -y \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg2 \
         software-properties-common

#Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

#Set up the stable repository
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

#Update the apt package index
RUN apt-get update

#Install the latest version of Docker CE
RUN apt-get install -y docker-ce

#Add jenkins to the docker group
RUN usermod -a -G docker jenkins