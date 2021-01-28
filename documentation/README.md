# Documentation de Lenra

La génération du site de doc se fait en 2 étapes : 
* Générer les documentation markdown à partir des [schema JSON](https://gitlab.com/lenra/platform/lenra_core/-/tree/staging/json_validator)
* Générer le site de documentation à partir de tous les markdown dans le dossier **docs**

## Générer le markdown des schema
```bash
cd documentation
jsonschema2md -d ../json_validator -o docs/schema -x -
```

Cela crée un dossier dans documentation/docs/schema contenant l'ensemble des markdown des schema json.

## Générer le site web de doc

```bash
cd documentation/website
npm install
npm run build
```

le site est généré dans `documentation/website/build/lenra-documentation`