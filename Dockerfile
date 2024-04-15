# Docker Image: Sample flask-RESTX API
# =============================================================================
# Base Image
# =============================================================================
FROM com.example.dev/centos7-python3-mod_wsgi:3.8.r1

# =============================================================================
# Assume "apache" user last had control in base image.
# =============================================================================
USER root

# =============================================================================
# Proxy settings
# =============================================================================
ENV http_proxy="http://one.proxy.example.com:8080"
ENV https_proxy="http://one.proxy.example.com:8080"
ENV HTTPS_PROXY="http://one.proxy.example.com:8080"
ENV HTTPS_PROXY="http://one.proxy.example.com:8080"
ENV no_proxy="127.0.0.1"

# =============================================================================
# Install ENTRYPOINT shell scripts ...
# =============================================================================
WORKDIR /home/bin
COPY ./bin/ /home/bin/
RUN chown -R apache.apache /home/bin/ && chmod 770 /home/bin/*.sh

# =============================================================================
# Add "app" directory
# =============================================================================
WORKDIR /home/app

# =============================================================================
# Copy the project contents into the container at /home/app
# =============================================================================
COPY ./rest_api ./rest_api

# =============================================================================
# Install any needed packages specified in requirements.txt
# =============================================================================

COPY ./requirements.txt .
RUN pip install -r requirements.txt

# =============================================================================
# Webserver "apache" should own all the files.
# =============================================================================
RUN chown -R apache.apache ./

# =============================================================================
# Start an "application container"
# =============================================================================
# NOTE: Docker expects the IP 0.0.0.0 to get out to the network.
# =============================================================================
EXPOSE 8001
ENTRYPOINT /home/bin/start_server.sh
