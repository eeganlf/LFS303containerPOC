# Use a base image, e.g., Ubuntu
FROM ubuntu:22.04

# Update and install sudo
RUN apt-get update && apt-get install -y sudo

# Install vim
RUN apt-get install vim

# Create a user 'student'
RUN useradd -m student && echo "student:student" | chpasswd

# # Set user to student
# USER student
# WORKDIR /home/student

