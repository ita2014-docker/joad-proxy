FROM matsumotory/ngx-mruby

ENV DOCKER_SERVER_IP 172.17.42.1
ENV PROXY_DOMAIN example.com

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log
RUN ln -sf /dev/stderr /usr/local/nginx/logs/error.log

ADD ./run.sh /build/
CMD ["/build/run.sh"]
