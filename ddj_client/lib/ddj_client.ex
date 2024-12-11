defmodule DdjClient do
  @moduledoc """
  Documentation for `DdjClient`.
  """

  alias Socket.Web

  def hello do
    Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")
    |> join()
    |> send_data("data")

    :world

  end

  def send_data(socket, data) do
    data = """
    ["3","4","ddj:lobby","new_msg",{"body":"#{data}"}]
    """
    Web.send!(socket, {:text, data})
    Process.sleep(250)
    socket
  end

  def join(socket) do
    phx_join = """
    ["3","3","ddj:lobby","phx_join",{}]
    """
    Web.send!(socket, {:text, phx_join})
    socket
  end
end
