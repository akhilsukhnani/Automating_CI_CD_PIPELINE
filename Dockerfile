FROM centos
#this means our base os would be centos above which we would be making the changes
ENV USER=root
#the user to which ssh has to be done ,by default its it is root from our side in case user doesn't provide us the user, we have given this because because we would like to do ssh from inside the conatainer to the host os or any of the OS , because we don't want to launch the webserver in the same container
ENV DEST_IP $DEST_IP
#this would be taken at the run time when we go for docker run command,it is the ip of the host os or the machine upon which you want to launch the webserver upon(with the help of docker)
RUN yum install wget -y
#to download anything from the internet we need this command , and we have to download jenkins so we need this software also
RUN yum install openssh-server openssh-clients -y
#installing ssh so that we can get the access of the machine from where we have to execute the docker engine
COPY script.sh  /
#copying the script to root directory of the container that is going to be launched , this script conatins ssh commands to get the co0ntrol of the host os and they all needed to be executed in a single run.
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#to install jenkins, as mentioned on the jenkins official site
RUN yum install java  jenkins git sudo -y
#installing java because jenkins require java background to run and install jenkins package that we have downloaded ,and installing git because our code (code for the webserver)would be downloaded inside the same conatiner
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#to give jenkins user sudo power to do root level tasks and run commands as well
EXPOSE 8080
#because jenkins by default runs on the port 8080
CMD bash script.sh
#running our script inside the container which we copied , because we can only run CMD command inside the dockerfile only once.
