defmodule MqttTlsMve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    File.read!("isrgrootx1.pem") |> IO.puts()
    System.get_env("MQTT_USER") |> then(&IO.puts("MQTT_USER: #{&1}"))
    System.get_env("MQTT_PASSWORD") |> then(&IO.puts("MQTT_PASSWORD: #{&1}"))
    System.get_env("MQTT_HOST") |> then(&IO.puts("MQTT_HOST: #{&1}"))
    System.get_env("MQTT_PORT", "8883") |> then(&IO.puts("MQTT_PORT: #{&1}"))

    children = [
      {Tortoise.Connection,
       [
         client_id: HelloWorld,
         user_name: System.get_env("MQTT_USER"),
         password: System.get_env("MQTT_PASSWORD"),
         server: {
           Tortoise.Transport.SSL,
           log_level: :debug,
           host: System.get_env("MQTT_HOST"),
           port: System.get_env("MQTT_PORT", "8883") |> String.to_integer(),
           cacertfile: "isrgrootx1.pem",
           verify: :verify_peer
         },
         handler: {MqttTlsMve.TortoiseHandler, []},
         subscriptions: [
           {"#", 0}
         ]
       ]}
      # {MqttTlsMve.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MqttTlsMve.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
