defmodule FrontEnd.Errands do
  @moduledoc """
  Context for running Errands. So far only a getter, but can be expanded with new needs.
  """
  import Ecto.Query
  alias FrontEnd.Errand
  alias FrontEnd.Repo

  def get_errands(%Date{} = date) do
    from = date |> DateTime.new!(Time.new!(0, 0, 0), "Etc/UTC")
    till = from |> DateTime.add(1, :day)

    Repo.all(
      from(e in Errand, where: e.to_do_at >= ^from and e.to_do_at < ^till, order_by: e.to_do_at)
    )
    |> Enum.map(&Map.from_struct/1)
  end
end
