FROM nginx

RUN sed -i 's%/usr/share/nginx/html%/var/www/instant-search-demo%' /etc/nginx/conf.d/*
COPY . /var/www/instant-search-demo 

