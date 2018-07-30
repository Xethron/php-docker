FROM nginx:latest

MAINTAINER Bernhard Breytenbach <docker@coffeecode.co.za>

RUN apt-get update && apt-get upgrade -y \
    && apt-get autoclean \
    && apt-get clean \
    && apt-get autoremove;

ADD ./site.conf /etc/nginx/conf.d/site.conf
ADD ./startup.sh /startup.sh

RUN chmod +x /startup.sh

CMD /startup.sh;
