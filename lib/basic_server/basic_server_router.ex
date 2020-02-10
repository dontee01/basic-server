defmodule BasicServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)

  # GET Request Handler for /test path
  get "/test-get" do
    send_resp(conn, 200, "testing")
  end

  post "/test-post" do
    {:ok, body, conn} = read_body(conn)

    body = Poison.decode!(body)
    IO.inspect(body)

    send_resp(conn, 201, "created: #{get_in(body, ["message"])}")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
