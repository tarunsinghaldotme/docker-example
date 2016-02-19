FROM ubuntu:vivid

MAINTAINER Minoru Osuka "mosuka@zlab.co.jp"

RUN apt-get update \
 && apt-get -y install nodejs npm git \
 && apt-get clean

RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

# Add group
ENV EXAMPLE_GROUP example
RUN groupadd -r $EXAMPLE_GROUP

# Add user
ENV EXAMPLE_USER example
ENV EXAMPLE_UID 3000
RUN useradd -r -u $EXAMPLE_UID -g $EXAMPLE_GROUP $EXAMPLE_USER

# Build application
RUN mkdir /opt/example
WORKDIR /opt
RUN git clone https://github.com/mosuka/example.git
WORKDIR /opt/example
RUN npm install

EXPOSE 3000
USER EXAMPLE_USER

CMD [ "npm", "start"]
