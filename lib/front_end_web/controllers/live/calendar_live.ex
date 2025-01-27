defmodule FrontEndWeb.CalendarLive do
  use FrontEndWeb, :live_view
  alias FrontEndWeb.CalendarComponent, as: Calendar
  def render(assigns) do
    ~H"""
    <.live_component id="" module={Calendar} initial_date={Date.utc_today()}/>
    """
  end
end
