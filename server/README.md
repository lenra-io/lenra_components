# LenraServer

Prerequis : 
  * Start the database with docker `docker run -p 5432:5432 --name lenra-postgres -e POSTGRES_PASSWORD=postgres -d postgres`
  * Create the db and migrate `mix setup`. Under the hood it runs the following commands
    * `mix ecto.create` to create the database
    * `mix ecto.migrate` to run all the migration to get an up-to-date database
    * `mix run priv/repo/seeds.exs` to populate the database with default values 

Then you can start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

To check some quality code : 
  * Format code with `mix format`
  * Check syntaxe and rules `mix credo --strict`
  * Check security `mix sobelow`

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
