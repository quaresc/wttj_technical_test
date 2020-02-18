defmodule WttjTechnicalTest do
  @moduledoc """
  Documentation for `WttjTechnicalTest`.
  """
  alias NimbleCSV.RFC4180, as: CSV

  def aggregate_jobs do
    continents = Continents.get_continents

    "./data/technical-test-jobs.csv"
    |> File.stream!
    |> CSV.parse_stream
    |> Stream.map(fn [_profession_id,_contract_type,_name,office_latitude,office_longitude] ->
      if office_latitude != "" && office_longitude != "" do
        continents
        |> Enum.find_value("Unknown", fn elem -> if Topo.contains?(elem.polygon, {String.to_float(office_longitude), String.to_float(office_latitude)}), do: elem.continent end)
      else
        "Unknown"
      end
    end)
    |> Enum.to_list()

  end
end
