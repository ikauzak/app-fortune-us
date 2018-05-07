FROM httpd:2.4.33

LABEL maintainer "Bruno K. Masuda <bruno.masuda@agilitynetworks.com.br>"

RUN apt-get update && apt-get install -y cowsay fortunes supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/script

RUN echo "<embed src="cowsaying.txt" height="500" width="1000">" \
          > /usr/local/apache2/htdocs/index.html

WORKDIR /etc/supervisor/conf.d

COPY ./supervisord/supervisord.conf supervisord.conf

WORKDIR /var/script

COPY ./script/cowsay.sh cowsay.sh

RUN chown root:root cowsay.sh && chmod 777 cowsay.sh

ENTRYPOINT ["/usr/bin/supervisord"]
