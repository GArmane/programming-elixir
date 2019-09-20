defmodule Stack.Application do
  @moduledoc false

  use Application

  def start(_type, _arg) do
    {:ok, _pid} = Stack
      .Supervisor
      .start_link([])
  end
end
