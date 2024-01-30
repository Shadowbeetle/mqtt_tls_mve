defmodule MqttTlsMve.TortoiseHandler do
  use Tortoise.Handler

  def init(args) do
    IO.puts("init tortoise")
    IO.inspect(args)
    {:ok, args}
  end

  def connection(status, state) do
    # `status` will be either `:up` or `:down`; you can use this to
    # inform the rest of your system if the connection is currently
    # open or closed; tortoise should be busy reconnecting if you get
    # a `:down`
    IO.puts("status")
    IO.inspect(status)
    {:ok, state}
  end
end
