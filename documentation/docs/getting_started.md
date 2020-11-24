# Getting started


- [Getting started](#getting-started)
  - [Prérequis](#prérequis)
  - [Langages supportés](#langages-supportés)
  - [Configuration](#configuration)
  - [Nouveau projet](#nouveau-projet)
  - [Fonctionnement de Lenra](#fonctionnement-de-lenra)
    - [Modification des données utilisateur](#modification-des-données-utilisateur)
    - [Générer l'UI en fonction de la donnée utilisateur](#générer-lui-en-fonction-de-la-donnée-utilisateur)

## Prérequis 
- [faas-cli](https://github.com/openfaas/faas-cli)
- [docker](https://www.docker.com/)
- [Compte Gitlab](https://gitlab.com/) avec accès au projet [Openfaas Templates](https://gitlab.com/lenra/poc/openfaas-templates)

## Langages supportés

- Node 12

## Configuration

Connexion au registre docker gitlab
```bash
docker login registry.gitlab.com
```
Récupération des templates
```bash
faas template pull git@gitlab.com:lenra/poc/openfaas-templates.git[#branch]
```
Rempalcez [#branch] par le nom de la branche à récupérer. Ne rien mettre pour master.

## Nouveau projet
```bash
faas new [projectname] --lang node12
```
Cela va créer un dossier **`[projectname]`** ainsi qu'un fichier **`[projectname].yml`** dans le dossier actuel.  
***note** : le nom de votre projet doit être en minuscule sans espace.*

exemple : 
```bash
faas new helloworld --lang node12
```
**`helloworld.yml`**
``` yml
version: 1.0
provider:
  name: openfaas
  gateway: http://127.0.0.1:8080
functions:
  helloworld:
    lang: node12
    handler: ./helloworld
    image: helloworld:latest
```

- **version** : Correspon à la version de openfaas
- **provider** : défini les information d'accès à openfaas
  - **name** : le nom du système (openfaas)
  - **gateway** : l'url d'accès à la gateway (api d'openfaas)
- **functions** : la définition de vos fonctions (ici une seule)
  - **helloworld** : Le nom de la fonction
  - **lang** : Le nom du template utilisé
  - **handler** : le dossier du projet d'application Lenra
  - **image** : Le nom de votre image docker qui sera créé

**!! IMPORTANT !!** :  
Afin d'uploader l'image dans le registre gitlab permettant d'envoyer en prod l'application, il est nécessaire de d'ajouter ```registry.gitlab.com/lenra/poc/lenra-application-openwhisk/``` en préfix de l'image.

**`helloworld.yml`**
``` yml
version: 1.0
provider:
  name: openfaas
  gateway: http://127.0.0.1:8080
functions:
  helloworld:
    lang: node12
    handler: ./helloworld
    image: registry.gitlab.com/lenra/poc/lenra-application-openwhisk/helloworld:latest
```

**`helloworld`**
``` 
helloworld
├── listeners
│   ├── index.js
│   └── InitData.js
├── package.json
└── ui
    └── index.js
```
Ce dossier contient l'architecture de dossier du projet d'application Lenra.
- **listeners** contient toues les fonctions de manipulation de données, soit : 
  - **index.js** le point d'entrée servant d'aiguiage vers les bonnes fonctions
  - **InitData.js** la fonction d'initialisation des données utilisateur.
- **ui** contient toutes les fonctions d'UI
  - **index.js** Le point d'entrée afin de construire l'UI à partir de la donnée.
- **package.json** le fichier de gestion de dépendance de l'application

## Fonctionnement de Lenra 

Le système Lenra va fonctionner en 2 phases : 
- [Getting started](#getting-started)
  - [Prérequis](#prérequis)
  - [Langages supportés](#langages-supportés)
  - [Configuration](#configuration)
  - [Nouveau projet](#nouveau-projet)
  - [Fonctionnement de Lenra](#fonctionnement-de-lenra)
    - [Modification des données utilisateur](#modification-des-données-utilisateur)
    - [Générer l'UI en fonction de la donnée utilisateur](#générer-lui-en-fonction-de-la-donnée-utilisateur)

### Modification des données utilisateur
Lors du démarrage de l'application ou lors d'une action de l'utilisateur sur votre UI, le système Lenra vous donne la possibilité de réagir afin de modifier la donnée de l'utilisateur. Pour cela, la fonction exporté dans index.js est appelée avec plusieurs paramètres : 
- **action** le nom de l'action effectué par l'utilisateur (**InitData** pour le 1er appel)
- **data** un objet contenant votre donnée utilisateur (vide lors du 1er appel)
- **props** un objet contenant des informations attaché au listener de l'UI (nous reviendrons dessus)
- **event** un objet contenant des informations supplémentaire en rapport avec l'action de l'utilisateur sur votre UI (exemple : la valeur d'un champ de text)

Voyons le contenu de **`listeners/index.js`** : 
```js
'use strict'

const initData = require('./InitData');

module.exports = async (action, data, props, event) => {
  switch (action) {
    case "InitData":
      return initData();
    default:
      return {};
  }
}
```
Ici, le programme HelloWorld n'a pas d'autres action que le chargement initial de la page. On regarde donc la valeur du paramètre **action** afin de voir quelle fonction appeler. Lorsque **action** vaut **InitData**, le système nous informe qu'il souhaite initialiser les données de l'utilisateur. On lui retourne donc la donnée initiale, soit un simple objet ayant comme valeur "world".

**`listeners/InitData.js`** : 
```js
module.exports = function initData() {
    return {
        value: "world"
    }
}
```
Le système va donc enregistrer pour nous cette donnée et nous la redonner à chaque fois qu'il sera nécessaire de la modifier ou de recalculer l'UI.

### Générer l'UI en fonction de la donnée utilisateur
Une fois que le système a enregistré les données utilisateur, il va nous demander de générer l'UI à partir de ces données. Il fait donc appel à la fonction principale du fichier **`ui/index.js`**

**`ui/index.js`** : 
```js
'use strict'

module.exports = function main(data) {
  return {
    root: {
      type: "container",
      children: [{
        type: "text",
        value: `hello ${data.value}`
      }]
    }
  }
}
```

La fonction prends un seul paramètre : la donnée utilisateur. C'est la même que celle renvoyée précédemment par la fonction **initData**.
Cette renvoie simplement un objet contenant la description de l'interface qui sera affiché par le client : 
 - Un composant **container** avec un enfant unique
   - Un composant **text** ayant comme valeur ```hello ${data.value}``` soit ```Hello world```


Félicitation ! Vous avez fait votre premier programme Lenra ! ;)