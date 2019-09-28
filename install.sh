#!/bin/bash

sites_root="/var/www/html"

echo "Leyendo ficheros de configuración del directorio"
for site in $(find ./config/ -name '*.yml')
do
  echo "Fichero: $site"
  filename=$(basename -- "$site")
  extension="${filename##*.}"
  alias="${filename%.*}"
  theme=$(jq -r .theme ./config/$alias.json)
  child_theme=$(jq -r .child_theme ./config/$alias.json)
  plugins=$(jq -r .plugins ./config/$alias.json)
  langs=$(jq -r .langs ./config/$alias.json)

  echo "Creo carpeta del site $sites_root/$alias"
  mkdir $sites_root/$alias

  echo "Copio configuración a la carpeta de ejecución"
  cp $site ./wp-cli.yml

  echo "Instalando WordPress en $sites_root/$alias"
  wp core download 

  echo "Creo el fichero de configuración wp-config.php"
  wp config create
  
  echo "Reseteo la base de datos (dev purposes)"
  wp db reset --yes

  echo "Creo la base de datos"
  wp db create

  echo "Instalo el core usando la configuración"
  wp core install 

  echo "Cambio la descripción del site"
  wp option update blogdescription 'Otro barrio realizado con WordPress'

  echo "Instalo el tema $theme"
  wp theme install $theme --activate

  echo "Creo un tema hijo a partir del tema padre $theme"
  wp scaffold child-theme $child_theme --activate
  
  echo "Instalo los plugins"
  wp plugin install $plugins

  echo "Instalo idioma $lang"
  wp language core install $lang

  echo "Cambio a idioma por defecto"
  wp site switch-language $lang

  echo "Creo taxonomías aleatorias"
  wp term generate category

  echo "Creo contenido aleatorio"
  curl -k "https://baconipsum.com/api/?type=meat-and-filler&paras=10&format=html" | wp post generate | xargs -0 -d ' ' -I % wp comment generate --post_id=%

  echo "Elimino fichero de configuración yml"
  rm ./wp-cli.yml
done