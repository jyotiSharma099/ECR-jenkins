#set the base image
FROM ubuntu:20.04

#install dependencies;
RUN apt-get update && apt-get install tzdata -y

#installation of apache2,php,mysql
RUN apt-get update -y && apt-get install apache2 -y && apt-get install apache2-utils -y
RUN apt-get install mysql-client -y && apt-get install php php-gd php-cli php-common php-mysql -y
RUN apt-get install wget unzip -y

# installation of wordpress
RUN wget https://wordpress.org/latest.zip && unzip latest.zip

# copy the wp-config file
RUN cp -r wordpress/* /var/www/html/
RUN chown www-data:www-data -R /var/www/html/
RUN rm -rf /var/www/html/index.html

#expose necessary port
EXPOSE 80
ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]
