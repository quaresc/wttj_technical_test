defmodule API.Endpoint do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  get "/offers" do
    conn = fetch_query_params(conn)
    params = conn.query_params

    origin = {String.to_float(params["longitude"]), String.to_float(params["latitude"])}
    radius = String.to_integer(params["radius"]) * 1000

    offers = WttjTechnicalTest.get_offers_in_radius(origin, radius)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(offers))
  end

  match _ do
    send_resp(conn, 404, "Requested route not found!")
  end
end
