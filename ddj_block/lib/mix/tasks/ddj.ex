defmodule Mix.Tasks.Ddj do
  use Mix.Task

  def run(_arg) do
    DdjBlock.main()
  end
end
