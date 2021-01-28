# Lenra Server

Prerequis : 
  * Démarrer la base de donnée avec docker `docker run --restart always -p 5432:5432 --name lenra-postgres -e POSTGRES_DB=lenra_dev -e POSTGRES_PASSWORD=postgres -d postgres`
  * Créer la db et démarrer la migration `mix setup`. Cela équivaux à lancer les commandes suivantes : 
    * `mix deps.get` pour installer les dépendances
    * `mix ecto.create` pour créer la base de donnée
    * `mix ecto.migrate` pour démarrer toutes les migrations et avoir une base de donnée à jour
    * `mix run priv/repo/seeds.exs` pour alimenter la base de donnée avec les valeurs par défaut

Vous pouvez à présent démarrer votre serveur avec la commande `mix phx.server`

Le serveur est démarré à l'adresse `localhost:4000`

Vérification de qualité de code : 
  * formattage du code avec `mix format`
  * Vérification de syntaxe/règles de code `mix credo --strict`
  * Vérification de sécurité `mix sobelow`
  * lancer les tests `mix test`
  * Test + couverture de code `mix coveralls`
  * Test + couverture de code + rapport html `mix coveralls.html`

## Liens utiles

  * Site officiel: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
