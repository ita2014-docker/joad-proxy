FROM matsumotory/ngx-mruby

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ADD ./run.sh /build/
CMD ["/build/run.sh"]
