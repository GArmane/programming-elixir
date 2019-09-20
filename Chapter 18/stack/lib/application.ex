defmodule Stack.Application do
  @moduledoc false

  use Application

  def start(_type, _arg) do
    {:ok, _pid} = Stack
      .Supervisor
      .start_link(Application.get_env(:stack, :initial_stack))
  end
end
