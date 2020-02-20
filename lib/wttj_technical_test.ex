defmodule WttjTechnicalTest do
  @moduledoc """
  Documentation for `WttjTechnicalTest`.
  """
  alias NimbleCSV.RFC4180, as: CSV

  @jobs_file "./data/technical-test-jobs.csv"
  @profession_file "./data/technical-test-professions.csv"

  def aggregate_professions do
    continents = Continents.get_continents
    professions = get_professions()

    @jobs_file
    |> File.stream!
    |> CSV.parse_stream
    |> Enum.map(fn [profession_id,_contract_type,_name,lat,long] ->
      profession = professions[profession_id] || "Unknown"
      determine_profession_continent(long, lat, continents, profession)
    end)
    |> Enum.reduce(%{}, fn {continent, profession}, acc ->
      updated_map = %{
        continent => %{
          profession => (acc[continent][profession] || 0) + 1,
          "Total" => (acc[continent]["Total"] || 0) + 1
        }
      }

      Map.merge(acc, updated_map, fn _k, v1, v2 -> Map.merge(v1, v2) end)
    end)
  end

  def get_professions() do
    @profession_file
    |> File.stream!
    |> CSV.parse_stream
    |> Enum.into(%{}, fn [id, _job, profession] -> {id, profession} end)
  end

  def determine_profession_continent(long, lat, continents, profession) do
    default_value = {"Unknown localisation", profession}

    if long != "" && lat != "" do
      continents
      |> Enum.find_value(default_value, &(
        if Continents.contains?(&1, String.to_float(long), String.to_float(lat)), do: {&1.name, profession}
      ))
    else
      default_value
    end
  end
end
