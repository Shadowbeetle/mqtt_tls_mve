# MqttTlsMve

MVE for testing Tortoise against an MQTT broker.

## Setup

1. `git clone git@github.com:Shadowbeetle/mqtt_tls_mve.git`
2. `cd mqtt_tls_mve`
3. [Install asdf](https://asdf-vm.com/guide/getting-started.html#_2-download-asdf)
4. Install erlang
   - `asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git`
   - `asdf install erlang latest`
   - `asdf global erlang latest`
5. Install elixir
   - `asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`
   - `asdf install elixir latest`
   - `asdf global elixir latest`
6. Download project dependencies
   - `mix deps.get`
7. Setup the `.env` file. You can copy the provided `.env.example` and fill it in with the adequate values.
   - Run `export $(cat .env | xargs)` to set up the env vars in your shell session.
8. Run
   - `mix run --no-halt`

## Project structure

1. Root
   - `isrgrootx1.pem`
   - `.env`
2. `lib/mqtt_tls_mve/application.ex`
   - `application.ex`: Tortoise setup. Refer to the erlang [SSL documentation](https://www.erlang.org/doc/man/ssl) regarding the `server: {}` setup.
   - `tortoise_handler.ex`: Various [tortoise events](https://hexdocs.pm/tortoise/Tortoise.Handler.html) to log.