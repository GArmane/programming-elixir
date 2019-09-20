defmodule Sequence.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    {:ok, _pid} = Sequence.Supervisor.start_link(0)
  end
end
