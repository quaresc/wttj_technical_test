defmodule WttjTechnicalTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :wttj_technical_test,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {API.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:topo, "~> 0.4.0"},
      {:nimble_csv, "~> 0.7"},
      {:poison, "~> 4.0.1"},
      {:plug, "~> 1.9"},
      {:plug_cowboy, "~> 2.0"},
      {:distance, "~> 0.2.1"}
    ]
  end
end
