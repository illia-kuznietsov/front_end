# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FrontEnd.Repo.insert!(%FrontEnd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FrontEnd.Errand
alias FrontEnd.Repo

unless Repo.exists?(Errand) do
  errands = [
    %{
      description: "Breakfast",
      to_do_at: DateTime.new!(Date.new!(2025, 1, 2), Time.new!(8, 0, 0)),
      inserted_at: DateTime.utc_now(:second),
      updated_at: DateTime.utc_now(:second)
    },
    %{
      description: "Travel to venue",
      to_do_at: DateTime.new!(Date.new!(2025, 1, 2), Time.new!(10, 0, 0)),
      inserted_at: DateTime.utc_now(:second),
      updated_at: DateTime.utc_now(:second)
    },
    %{
      description: "Ceremony",
      to_do_at: DateTime.new!(Date.new!(2025, 1, 2), Time.new!(10, 30, 0)),
      inserted_at: DateTime.utc_now(:second),
      updated_at: DateTime.utc_now(:second)
    },
    %{
      description: "Take Ellie for a walk",
      to_do_at: DateTime.new!(Date.new!(2025, 1, 14), Time.new!(8, 30, 0)),
      inserted_at: DateTime.utc_now(:second),
      updated_at: DateTime.utc_now(:second)
    },
    %{
      description: "Dial for morning check-in",
      to_do_at: DateTime.new!(Date.new!(2025, 1, 14), Time.new!(10, 0, 0)),
      inserted_at: DateTime.utc_now(:second),
      updated_at: DateTime.utc_now(:second)
    }
  ]

  Repo.insert_all(Errand, errands)
end
