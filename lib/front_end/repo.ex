defmodule FrontEnd.Repo do
  use Ecto.Repo,
    otp_app: :front_end,
    adapter: Ecto.Adapters.MyXQL
end
