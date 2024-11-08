# Use a base image, e.g., Ubuntu
FROM ubuntu:22.04

# Update and install sudo
RUN apt-get update && apt-get install -y sudo

# Create a user 'student' and add to sudoers
RUN useradd -m student && echo "student:student" | chpasswd && adduser student sudo

# Add the PATH enhancement to student's .bashrc
RUN echo 'PATH=$PATH:/usr/sbin:/sbin' >> /home/student/.bashrc

# Set user to student
USER student
WORKDIR /home/student

