#Builder image (need to build, tag and push it to repo)
FROM tomcat:latest

# Install packages
RUN apt-get update
RUN apt-get install fontconfig openjdk-11-jre -y

# Install ssh
RUN apt-get install openssh-client -y

# Configure ssh client
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

RUN apt-get install maven docker.io -y
