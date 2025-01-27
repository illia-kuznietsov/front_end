defmodule FrontEnd.Repo.Migrations.CreateErrands do
  use Ecto.Migration

  def change do
    create table(:errands) do
      add :description, :string
      add :to_do_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
