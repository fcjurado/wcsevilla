#!/bin/bash

echo "Instalando paquetes necesarios de WP-CLI"
wp package install markri/wp-sec
wp package install wp-cli/profile-command

echo "Modo mantenimiento ON"
wp @all maintenance-mode activate

echo "Actualizo idiomas de core, plugins y temas"
wp @all language core update
wp @all language plugin update
wp @all language theme update

echo "Actualizo plugins"
wp @all plugin update-all

echo "Actualizo temas"
wp @all theme update-all

echo "Actualizo core"
wp @all core update

echo "Reemplazo 'ipsum' por 'muspi'"
wp @all search-replace "entrada" "Post" wp_posts wp_postmeta 

echo "Realizo un backup del sitio"
wp @all db export ~/$(date "+%Y-%m-%d-%H-%M-%S").sql

echo "Elimino transients expirados"
wp @all transient delete

echo "Flush de caché"
wp @all cache flush

echo "WP-SEC"
wp @all wp-sec check

echo "Profiling"
wp @all profile stage

echo "Optimizo y reparo la BD"
wp @all db optimize
wp @all db repair

echo "Modo mantenimiento OFF"
wp @all maintenance-mode deactivate