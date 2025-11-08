<h3>Containerization</h3>

Containerization is the process of packaging and running applications in isolated environments, typically referred to as containers. These containers provide lightweight, consistent environments for applications to run, ensuring that they behave the same way, regardless of where they are deployed. Technologies like Docker, Docker Compose, and Linux Containers (LXC) make containerization possible, primarily in Linux-based systems. Containers differ from virtual machines in that they share the host system's kernel, making them far more lightweight and efficient. With these technologies, users can quickly create, deploy, and manage applications with improved security, portability, and scalability.

Containers are highly configurable, allowing users to tailor them to their specific needs, and their lightweight nature makes it easy to run multiple containers simultaneously on the same host system. This feature is particularly advantageous for scaling applications and managing complex microservice architectures.

Imagine you're organizing a big concert, and each band needs their own customized stage setup. Instead of building a completely new stage for each band (which would be like using a virtual machine), you create portable, self-contained "stage pods" that include everything the band needs lights, instruments, speakers, etc. These pods are lightweight, reusable, and can be easily moved from venue to venue. The key is that the pods all work seamlessly on the same main stage (the host system), but each one is isolated enough that no band's setup interferes with the others.

In the same way, containers package an application with all its required tools and settings, allowing it to run consistently across different systems without conflict, all while sharing the same "main stage" (the underlying system's resources).

Security is a critical aspect of containerization. Containers isolate applications from the host system and from each other, providing a barrier that reduces the risk of malicious activities affecting the host or other containers. This isolation, along with proper configuration and hardening techniques, adds an additional layer of security. However, it's important to note that containers do not offer the same level of isolation as traditional virtual machines. If not properly managed, vulnerabilities such as privilege escalation or container escapes can be exploited to gain unauthorized access to the host system or other containers.

In addition to enhanced security and resource efficiency, containers make applications easier to deploy, manage, and scale. Since containers encapsulate everything the application needs (e.g., libraries, dependencies), they allow for consistency across development, testing, and production environments. This portability ensures that applications run reliably across different environments.

However, it is important to recognize that, despite their advantages, containers are not immune to security risks. There are methods that we can use to escalate privileges or escape the isolation that containers provide.

<h3>Dockers</h3>

Docker is an open-source platform for automating the deployment of applications as self-contained units called containers. It uses a layered filesystem and resource isolation features to provide flexibility and portability. Additionally, it provides a robust set of tools for creating, deploying, and managing applications, which helps streamline the containerization process.

Imagine Docker containers as a sealed lunchbox. You can eat the food (run applications) inside, but once you close the box (stop the container), everything resets. To make a new lunchbox (new container) with updated contents (modified configurations), you create a new recipe (Dockerfile) based on the original. When serving multiple lunchboxes in a restaurant (production), you'd use a kitchen system (Kubernetes/Docker Compose) to manage all the orders smoothly.

<h3>Install Docker-Engine</h3>

Installing Docker is relatively straightforward. We can use the following script to install it on a Ubuntu host:

#!/bin/bash

# Preparation

sudo apt update -y

sudo apt install ca-certificates curl gnupg lsb-release -y

sudo mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine

sudo apt update -y

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add user htb-student to the Docker group

sudo usermod -aG docker htb-student

echo '[!] You need to log out and log back in for the group changes to take effect.'

# Test Docker installation

docker run hello-world
