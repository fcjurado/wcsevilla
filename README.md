# Automatiza tu WordPress con WP-CLI

## WordCamp Sevilla 2019

### Slides
* https://docs.google.com/presentation/d/122HofJDY8P6naQ4m3cBHcEXwGENN8h3xe5C9wNEvmQU

* Repositorio: https://github.com/fcjurado/wcsevilla

### Aperitivo formativo
Durante este taller vamos a varios sitios basados en WordPress y cómo podemos actualizarlos desde el mismo equipo desde el mismo equipo.

1. Vamos a crear 4 sites usando los comandos en un script SH y tomando los datos desde ficheros YML

Esto nos puede servir para, por ejemplo, tener ficheros de configuración para cada vez que montemos un nuevo proyecto, alguien se incorpore en el equipo, etc.

2. Luego vamos a actualizarlos, backup, chequeo wp-sec, etc. usando aliases

Aquí es donde está el ahorro del tiempo: puedes automatizar un número alto de sites con cualquier comando

Para ello, necesitarías tener instalado un entorno LAMP o LEMP. Puedes tenerlo en local o en tu propio hosting. Debe tener al menos estos requisitos:

* Entorno Mac/linux, Consola Cygwin (Windows), WSL (Windows)
* PHP >= 7.1
* WordPress >= 4/5
* Tener instalado WP-CLI. Si tienes un hosting, es posible que ya lo tengas instalado (Siteground lo tiene)

### Instalación de WP-CLI

```
$ curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
$ php wp-cli.phar --info
$ chmod +x wp-cli.phar
$ sudo mv wp-cli.phar /usr/local/bin/wp
$ wp --info
```

Si está instalado, ``` wp --info ``` mostrará una salida así:

```
OS:     Linux 4.4.0-17763-Microsoft #379-Microsoft Wed Mar 06 19:16:00 PST 2019 x86_64
Shell:  /bin/bash
PHP binary:     /usr/bin/php7.2
PHP version:    7.2.12-1+0~20181112102304.11+stretch~1.gbp55f215
php.ini used:   /etc/php/7.2/cli/php.ini
WP-CLI root dir:        phar://wp-cli.phar/vendor/wp-cli/wp-cli
WP-CLI vendor dir:      phar://wp-cli.phar/vendor
WP_CLI phar path:       /home/fcjurado
WP-CLI packages dir:    /home/fcjurado/.wp-cli/packages/
WP-CLI global config:
WP-CLI project config:
WP-CLI version: 2.3.0
```

### Lista de comandos

https://developer.wordpress.org/cli/commands/

https://make.wordpress.org/cli/handbook/config/

### Tipología de un comando:
```
$ wp <command> <subcommand> --<option-with-value>=<option-value> --<option-without-value>
```

## Lista de sites
1. Macarena
2. Norte
3. Triana
4. Bellavista

### Editar fichero hosts

```
127.0.0.1 macarena.local norte.local triana.local bellavista.local
```

Para hostings: dar de alta dominios o subdominios en su panel correspondiente

#### 1. Instalación de sitios

1. Configurar los ficheros YML de la carpeta /config
2. Configurar los ficheros JSON de la carpeta /config
3. Revisar los scripts del fichero [install.sh](install.sh)
4. Ejecutar el fichero [install.sh](install.sh)

No uso aliases porque la configuración por comando no se personaliza por alias:

```bash
Aliases to other WordPress installs (e.g. `wp @staging rewrite flush`)
An alias can include 'user', 'url', 'path', 'ssh', or 'http'
```

#### 2. Actualización y chequeo

1. Revisar los scripts del fichero [update.sh](update.sh)
2. Ejecutar el fichero [update.sh](update.sh)

### Algunos paquetes necesarios

```
$ wp package install markri/wp-sec
$ wp package install wp-cli/profile-command
```

