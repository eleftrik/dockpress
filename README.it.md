Dockpress
===

![dockpress](https://user-images.githubusercontent.com/6959298/77827046-c0bab400-7113-11ea-82bc-ca1214fae140.png)

![GitHub stars](https://img.shields.io/github/stars/eleftrik/dockpress?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/eleftrik/dockpress?style=social)
![GitHub issues](https://img.shields.io/github/issues/eleftrik/dockpress)
![GitHub](https://img.shields.io/github/license/eleftrik/dockpress)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/eleftrik/dockpress?label=version)

**Dockpress** è un semplice ambiente di sviluppo LEMP basato su Docker per applicazioni [WordPress](https://wordpress.org/).

Cerchi qualcosa di simile per [Laravel](https://laravel.com/)? Dai un'occhiata a
[Laradhoc](https://github.com/eleftrik/laradhoc)!

## Caratteristiche

* Nginx
* PHP (7.2 / 7.3 / 7.4) con OPCache
* MySQL / MariaDB
* Mailhog
* Redis
* Nome di dominio personalizzato (es. `http://mydockpress.test`)

Puoi scegliere quale versione di PHP utilizzare (per esempio, `7.4`) impostando la variabile `${PHP_VERSION}`
nel tuo file `.env` (vedi `.env.example` per maggiori dettagli).

In maniera simile, puoi scegliere quale database usare (per esempio, `MariaDB 10.2`) impostando la variabile `${DATABASE_IMAGE}` nel tuo 
file `.env` (vedi `.env.example` per maggiori dettagli).

Nel caso in cui tu voglia personalizzare la configurazione Docker (es. aggiungendo un mount),
esegui `cp docker-compose.yml docker-compose.override.yml` quindi modifica il file
`docker-compose.override.yml`. Quest'ultimo verrà utilizzato da Docker. 

## Requisiti

* MacOS, Linux o Windows con WSL
* Docker

## Installazione

Clona questo repository.

Supponiamo che la tua applicazione WordPress debba essere accessibile all'indirizzo `mydockpress.test`:

```bash
git clone git@github.com:eleftrik/dockpress.git mydockpress.test
cd mydockpress.test
```

## Configurazione

### .env
Crea il file `.env` a partire da `.env.example`
```bash
cp .env.example .env

# Personalizza ogni variabile in base alle tue esigenze.
# Leggi i commenti in corrispondenza di ciascuna variabile nel file .env.example. 
```

### Dominio personalizzato
In base al valore della variabile `${APP_HOST}`, aggiungi il tuo dominio (es. `mydockpress.test`) al tuo file hosts 
```bash
sudo /bin/bash -c 'echo -e "127.0.0.1 mydockpress.test" >> /etc/hosts'
```

### Si parte
Esegui la *build* di tutti i container Docker e avviali
```bash
 .docker/scripts/init
```

Progetto WordPress nuovo di zecca? Nessun problema! Esegui:
```bash
.docker/scripts/wp-install
```
Un'installazione WordPress fresca fresca verrà scaricata in `${APP_SRC}`, configurata e disponibile all'indirizzo [http://${APP_HOST}]()
o [https://${APP_HOST}]()

Stufo di lavorare? Ferma tutto:
```bash
.docker/scripts/stop
```

La prossima volta che hai bisogno di eseguire la tua applicazione, se non hai modificato nulla a livello di configurazione Docker, esegui
```bash
 .docker/scripts/start
```

## Aggiornamenti

Quando esegui l'aggiornamento a partire da una versione precedente, segui questi passaggi:
- aggiorna il tuo codice
    - via `git pull` se punti ancora a questo repository, un fork o un repo privato
    - manualmente, scaricando una [release](https://github.com/eleftrik/dockpress/releases)
    
    In entrambi i casi, la cartella `src/` non verrà coinvolta 
- consulta `CHANGELOG.md`
- aggiorna il tuo file `./.env` confrontandolo con `./.env.example`
  (nuove variabili potrebbero essere state introdotte)
- se hai sovrascritto `docker-compose.yml` tramite `docker-compose.override.yml`, consulta
  `docker-compose.yml` per verificare se qualcosa è stato aggiunto, modificato o eliminato, confrontando
  con la precedente versione del file `docker-compose.yml` che stavi usando prima di effettuare l'aggiornamento 
- esegui `.docker/scripts/start --build`

## Script

Dockpress fornisce alcuni comodi script, situati nella cartella `.docker/scripts`.

Eseguili dalla cartella base in cui hai collocato il Dockpress.

### init

```bash
.docker/scripts/init
```
E' una scorciatoia per 
```bash
docker-compose up -d --build
```

Esegue e avvia i container

### start

```bash
.docker/scripts/start
```

E' una scorciatoia per
```bash
docker-compose up -d
```

Puoi usare il flag `--build` se vuoi eseguire la *build* delle immagini, altrimenti
```bash
.docker/scripts/start
```
è sufficiente per tirare su l'ambiente di sviluppo

### stop

Stanco di lavorare?
```bash
.docker/scripts/stop
```

### wp-install
Utile per tirare su un nuovo progetto WordPress da zero.
Rende disponibile una nuova installazione di WordPress nella cartella `${APP_SRC}`,
crea un file `${APP_SRC}/.env` contenente gli stessi valori presenti nel file `./env` principale,
infine crea un file `${APP_SRC}/wp-config.php` che usa il file `.env` sopra menzionato.

```bash
.docker/scripts/wp-install
```

### nah
Vuoi far fuori **tutto**?
Questo comando ferma tutti i container, cancella i volumi Docker e l'intera cartella `$APP_SRC`.

Per cui, prima di eseguirlo, **ASSICURATI** di aver compreso davvero bene che
perderai tutta la tua *codebase* WordPress e il relativo database!

```bash
.docker/scripts/nah
```

Per far fuori tutto e ripartire da zero, esegui
```bash
.docker/scripts/nah && .docker/scripts/init && .docker/scripts/wp-install
```

## Accedere al database

Puoi connetterti al tuo database via riga di comando o utilizzando un'applicazione.

Per esempio, da riga di comando:
```bash
source .env
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h127.0.0.1 $MYSQL_DATABASE
```
Però scommetto che preferisci utilizzare la tua applicazione preferita, ad esempio:
- TablePlus
- SequelPro
- HeidiSQL

ecc.

Utilizza i parametri presenti nel tuo file `.env`.

## MailHog

Per "acchiappare" tutte le mail in uscita utilizzando MailHog, installa un plugin WordPress
(es. WP Mail SMTP) e usa questa configurazione:
* SMTP host=mailhog
* SMTP port=1025
* SMTP username=(nessun valore)
* SMTP password=(nessun valore)

L'interfaccia web di MailHog è disponibile all'indirizzo

[http://${APP_HOST}:${MAILHOG_PORT}]()

Ad esempio: [http://mydockpress.test:8081]()


## Collaborazioni
Suggerimenti, revisioni, segnalazioni di bug sono i benvenuti.
Non si smette mai di imparare :-)

Le *pull request* sono ben accette. Per modifiche più sostanziose, prima apri un *issue* per spiegare cosa vorresti modificare.

## Ringraziamenti

Un ringraziamento a [Mauro Cerone](https://github.com/ceronem) per l'ispirazione


## Licenza
[MIT](https://choosealicense.com/licenses/mit/)
