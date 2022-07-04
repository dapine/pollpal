defmodule Pollpal.Repo.Migrations.RenameIpDuplicationField do
  use Ecto.Migration

  def change do
		rename table(:questions), :ip_duplication, to: :ip_duplication_check
  end
end
