# Use uma imagem base com PHP e extensões necessárias para o Joomla
FROM php:8.0-apache

# Instale dependências adicionais e extensões necessárias para o Joomla
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Copie os arquivos do Joomla para o diretório do Apache
COPY . /var/www/html/

# Defina o diretório de trabalho
WORKDIR /var/www/html/

# Permita que o Apache seja executado em segundo plano
CMD ["apache2-foreground"]
