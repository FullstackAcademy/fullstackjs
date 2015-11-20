FROM ubuntu:latest
MAINTAINER David Yang <david.g.yang@gmail.com>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

RUN apt-get update
#RUN apt-get install -y mongodb-org
RUN apt-get install -y mongodb-org git python build-essential curl libssl-dev
RUN apt-get install --yes --force-yes libgtk2.0-0 libidn11 libglu1-mesa
RUN service mongod start

RUN mkdir -p /data/db

RUN mkdir /Development

RUN cd /Development && git clone --branch v5.1.0 git://github.com/joyent/node
RUN cd /Development/node && ./configure && make && make install
RUN rm -rf /Development/node

RUN chmod 777 -R /Development

RUN npm install -g yo bower grunt-cli generator-meanjs express mongoose phantomjs
# RUN curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh

EXPOSE 80:80
EXPOSE 443:443
EXPOSE 3000:3000

RUN echo "\n##############################\n1. Create a new user with adduser, 'su' into that user.\n2. 'yo meanjs' to scaffold your app in the current directory.\n3. Start mongo in the background (e.g. 'mongod &')\n##############################\n"
