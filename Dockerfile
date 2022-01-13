FROM debian
RUN echo "deb http://ftp.tw.debian.org/debian bullseye main" > /etc/apt/sources.list.d/taiwan.list && \
    apt-get update && apt-get -y upgrade && apt-get -y install nginx
RUN apt-get clean && rm -rf /var/www/* && mkdir -p /var/www/company.com/img
COPY index.html /var/www/company.com/ 
COPY hackeru.png /var/www/company.com/img/
RUN chmod -R 754 /var/www/company.com && useradd Maxim && useradd Kishmereshkin && usermod -a -G Maxim Kishmereshkin && \
    chown -R Maxim:Kishmereshkin /var/www/company.com && sed -i 's% /var/www/html% /var/www/company.com%' /etc/nginx/sites-enabled/default && \
    sed -i 's%www-data% Maxim%' /etc/nginx/nginx.conf  
CMD ["nginx", "-g", "daemon off;"]
COPY proof_screen.jpg /var/www/company.com/img
