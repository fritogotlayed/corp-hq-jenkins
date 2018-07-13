FROM jenkins/jenkins:lts

EXPOSE 8080
EXPOSE 50000

# https://www.microsoft.com/net/download/linux-package-manager/debian9/sdk-current

USER root
RUN apt-get update && apt-get install -y\
    apt-utils\
    apt-transport-https

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg\
    && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/\
    && wget -q https://packages.microsoft.com/config/debian/9/prod.list\
    && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list\
    && chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg\
    && chown root:root /etc/apt/sources.list.d/microsoft-prod.list

# NOTE: This must be installed after another update
# that ensures the above dependencies are installed
RUN apt-get update && apt-get install -y\
    dotnet-sdk-2.1

RUN apt-get install -y\
    python3\
    python3-pip\
    virtualenv

USER jenkins