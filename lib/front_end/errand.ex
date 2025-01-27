defmodule FrontEnd.Errand do
  use Ecto.Schema
  import Ecto.Changeset

  schema "errands" do
    field :description, :string
    field :to_do_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(errand, attrs) do
    errand
    |> cast(attrs, [:description, :to_do_at])
    |> validate_required([:description, :to_do_at])
  end
end
