defmodule MqttTlsMve.TortoiseSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      %{
        id: Tortoise.Connection,
        start:
          {Tortoise.Connection, :start_link,
           [
             [
               client_id: HelloWorld,
               user_name: System.get_env("MQTT_USER"),
               password: System.get_env("MQTT_PASSWORD"),
               server:
                 {Tortoise.Transport.SSL,
                  host: System.get_env("MQTT_HOST"),
                  port: System.get_env("MQTT_PORT", "8883") |> String.to_integer(),
                  cacertfile: "isrgrootx1.pem",
                  verify: :verify_peer,
                  log_level: :debug},
               handler: {Tortoise.Handler.Logger, []},
               subscriptions: [
                 {"#", 0}
               ]
             ]
           ]},
        type: :worker,
        restart: :permanent,
        shutdown: 500
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
