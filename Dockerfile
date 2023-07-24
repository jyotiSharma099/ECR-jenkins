#set the base image
FROM ubuntu:20.04

# Install dependencies and set timezone
RUN apt-get update && apt-get install -y tzdata
ENV TZ=UTC

# Installation of apache2, php, mysql, wget, unzip
RUN apt-get install -y apache2 apache2-utils mysql-client php php-gd php-cli php-common php-mysql wget unzip

# Installation of WordPress
RUN wget https://wordpress.org/latest.zip && unzip latest.zip && rm latest.zip

# Copy the wp-config file
RUN cp -r wordpress/* /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
RUN rm -f /var/www/html/index.html

# Set the ServerName directive to suppress AH00558 warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expose necessary port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-DFOREGROUND"]
