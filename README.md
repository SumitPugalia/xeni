# Xeni

Setup
  * Install Erlang OTP 24
  * Install Elixir 1.14.3
  * Install Postgres

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies.
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

API DOC
  * http://localhost:4000/swaggerui/

TEST
  * mix test

NOTE
  * Haven't used any auth.
  * Have stored all the values in integer to prevent precision loss.
  * Conversion of incoming params is handled by controller & outgoing params is handled by views
