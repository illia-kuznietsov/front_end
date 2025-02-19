defmodule FrontEndWeb.IconLive do
  use FrontEndWeb, :live_view

  def render(assigns) do
    ~H"""
    <Heroicons.icon name="trophy" type="outline" class="size-1/2" /> yay, you tried
    """
  end
end
