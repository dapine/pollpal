defmodule Pollpal.Repo do
  use Ecto.Repo,
    otp_app: :pollpal,
    adapter: Ecto.Adapters.Postgres
end
