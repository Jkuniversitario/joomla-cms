# Use uma imagem oficial do PHP com Apache
FROM php:8.0-apache

# Atualize o sistema e instale dependências
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    curl \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql \
    && rm -r /var/lib/apt/lists/*

# Habilite mod_rewrite no Apache
RUN a2enmod rewrite

# Copie os arquivos do Joomla para o diretório do Apache
COPY . /var/www/html/

# Ajuste as permissões dos arquivos para garantir que o Apache tenha acesso
RUN chown -R www-data:www-data /var/www/html/

# Exponha a porta 80 para o Apache
EXPOSE 80

# Defina o comando de inicialização do Apache
CMD ["apache2-foreground"]
