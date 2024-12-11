defmodule DdjClient2 do
  @moduledoc """
  Documentation for `DdjClient`.
  """

  alias Socket.Web

  def hello do
    s= Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")

    s
    |> join()
    |> send_data("lll")

    loop(s)



    :world

  end

  def loop(s) do
    IO.inspect("----------------------")
    Socket.Web.recv!(s)
    |> IO.inspect()

    loop(s)
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
