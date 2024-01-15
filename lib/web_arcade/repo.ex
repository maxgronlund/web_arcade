defmodule WebArcade.Repo do
  use Ecto.Repo,
    otp_app: :web_arcade,
    adapter: Ecto.Adapters.Postgres
end
