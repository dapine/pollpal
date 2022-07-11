defmodule Pollpal.Repo.Migrations.AddRemoteIpAddressField do
  use Ecto.Migration

  def change do
		alter table(:votes) do
			add :remote_ip_address, :string
		end
  end
end
