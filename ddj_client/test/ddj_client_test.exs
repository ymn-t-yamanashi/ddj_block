defmodule DdjClientTest do
  use ExUnit.Case
  doctest DdjClient

  test "greets the world" do
    assert DdjClient.hello() == :world
  end
end
