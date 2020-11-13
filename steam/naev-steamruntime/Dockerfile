FROM registry.gitlab.steamos.cloud/steamrt/scout/sdk:latest-steam-client-general-availability

LABEL Description="Steam runtime development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."
LABEL Author="Jack Greiner <jack@emoss.org>"

RUN echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main" | sudo tee -a /etc/apt/sources.list

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes git ninja-build autoconf-archive
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python3 get-pip.py
RUN python3 -m pip install meson

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
