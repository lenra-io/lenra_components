# Composants

Les composants d'interface des applications sont les éléments que les utilisateurs de la plateforme Lenra voient lors de l'utilisation des applications. Cette page décrit les principes des composants.

- [Composants](#composants)
  - [Principes](#principes)
  - [Composants de base](#composants-de-base)


## Principes

Les composants sont décrits en JSON de manière à décrire leur fonctionnement quel que soit la technologie utilisée pour le client.

Un composant peut prendre des attributs en entrée afin d'utiliser leurs valeurs dans l'interface. En plus de ces attributs, le composant peut utiliser le [thème visuel](theme.md) et le [contexte visuel](context.md) du composant. Ces éléments sont des références aux valeurs de l'application de manière à ce que le rendu visuel change automatiquement lors du changement d'une valeur.

## Composants de base

Les composants de base sont ceux qui ne sont pas composés de sous composants. Il sont propre au système.

Les composants :
- [`text`](components/text.md) : permet d'afficher du texte sur l'interface.
- [`container`](components/container.md) : mettre en forme l'élément enfant.