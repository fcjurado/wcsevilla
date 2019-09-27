#!/bin/bash


# https://kinsta.com/blog/wp-cli/
# https://www.alibabacloud.com/blog/advanced-wordpress-management-using-wp-cli-on-alibaba-cloud-ecs--part-2_591110
# https://www.codeinwp.com/blog/wp-cli/
# https://www.smashingmagazine.com/2015/09/wordpress-management-with-wp-cli/
# https://danielbachhuber.com/2017/05/16/10-advanced-wp-cli-tricks/

sites_root="/var/www/html"

echo "Leyendo ficheros de configuración del directorio"
for site in $(find ./config/ -name '*.yml')
do
  echo "Fichero: $site"
  filename=$(basename -- "$site")
  extension="${filename##*.}"
  alias="${filename%.*}"
  theme=$(jq .theme ./config/$alias.json)
  plugins=$(jq .plugins ./config/$alias.json)

  echo "Creo carpeta del site $sites_root/$alias"
  mkdir $sites_root/$alias

  echo "Copio configuración a su carpeta final"
  cp $site $sites_root/$alias/wp-cli.yml

  echo "Entro en la carpeta de site"
  cd $sites_root/$alias

  echo "Instalando WordPress en $sites_root/$alias"
  wp core download 

  echo "Creo el fichero de configuración wp-config.php"
  wp config create

  echo "Creo la base de datos"
  wp db create

  echo "Instalo el core usando la configuración"
  wp core install 

  echo "Cambio la descripción del site"
  wp option update blogdescription 'Otro barrio realizado con WordPress'

  echo "Instalo el tema $theme"
  wp theme install $theme

  echo "Creo un tema hijo a partir del tema padre $theme"
  wp scaffold child-theme $theme --activate
  
  echo "Instalo los plugins"
  wp plugin install $plugins

  echo "Elimino fichero de configuración yml"
  rm $sites_root/$alias/wp-cli.yml
done