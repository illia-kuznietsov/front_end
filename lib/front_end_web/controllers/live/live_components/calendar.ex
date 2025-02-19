defmodule FrontEndWeb.CalendarComponent do
  @moduledoc """
  Calendar LiveComponent. Can support Errands if needed be. Has light and dark theme.
  """
  use Phoenix.LiveComponent

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       calendar: make_calendar(assigns.initial_date),
       weeks: weeks_in_month(assigns.initial_date),
       current_month: parse_month(assigns.initial_date.month),
       selected: assigns.initial_date.day |> to_string,
       errands: []
     )}
  end

  @months ~w"January February March April May June July August September October November December"
  def render(assigns) do
    ~H"""
    <div class="w-fit p-18 rounded-xl shadow-lg text-2xl dark:bg-coal">
      <div class="flex justify-between mb-14 text-primary dark:text-white">
        <.month_year month={@current_month} year={@initial_date.year} />
        <.arrows myself={@myself} />
      </div>
      <.calendar_table weeks={@weeks} calendar={@calendar} selected={@selected} myself={@myself} />
    </div>
    """
  end

  def calendar_table(assigns) do
    ~H"""
    <div class="relative overflow-hidden p-0 -m-8">
      <table class="select-none border-separate border-spacing-5">
        <thead class="dark:text-white">
          <tr>
            <th :for={week_day <- ~w"Mo Tu We Th Fr Sa Su"} class="font-medium">
              {week_day}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr :for={week <- 0..(@weeks - 1)}>
            <td :for={day <- @calendar |> Enum.at(week)} class="text-center rounded-full">
              <.day_cell day={day} myself={@myself} />
            </td>
          </tr>
          <tr :if={@weeks < 6} class="h-10">
            <td colspan="7"></td>
          </tr>
          <tr :if={@weeks < 5} class="h-10">
            <td colspan="7"></td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  def month_year(assigns) do
    ~H"""
    <span class="font-bold">
      {@month} {@year}
    </span>
    """
  end

  def arrows(assigns) do
    ~H"""
    <span class="flex space-x-6">
      <span class="flex size-6 justify-center items-center rounded-full hover:shadow-lg hover:shadow-selected/50 dark:hover:shadow-selected-dark/50">
        <Heroicons.icon
          name="chevron-left"
          type="outline"
          class="size-5 mr-[2px]"
          phx-click="prev_month"
          phx-target={@myself}
        />
      </span>
      <span class="flex size-6 justify-center items-center rounded-full hover:shadow-lg hover:shadow-selected/50 dark:hover:shadow-selected-dark/50">
        <Heroicons.icon
          name="chevron-right"
          type="outline"
          class="size-5 ml-[2px]"
          phx-click="next_month"
          phx-target={@myself}
        />
      </span>
    </span>
    """
  end

  def day_cell(assigns) do
    ~H"""
    <div
      :if={@day != ""}
      id={"day-cell-#{@day}"}
      phx-click="select"
      phx-hook="DaySelection"
      phx-target={@myself}
      phx-value-day={@day}
      class={
      "flex text-2xl size-14 justify-center items-center text-secondary dark:text-secondary-dark rounded-full " <>
        if @day != "", do: "hover:shadow-lg hover:shadow-selected/50 dark:hover:shadow-selected-dark/50", else: ""
    }
    >
      {@day}
    </div>
    """
  end

  def handle_event("prev_month", _, socket) do
    new_date = socket.assigns.initial_date |> prev_month

    {:noreply,
     socket
     |> assign(
       initial_date: new_date,
       calendar: make_calendar(new_date),
       weeks: weeks_in_month(new_date),
       current_month: parse_month(new_date.month),
       errands: [],
       selected: "1"
     )}
  end

  def handle_event("next_month", _, socket) do
    new_date = socket.assigns.initial_date |> next_month

    {:noreply,
     socket
     |> assign(
       initial_date: new_date,
       calendar: make_calendar(new_date),
       weeks: weeks_in_month(new_date),
       current_month: parse_month(new_date.month),
       errands: [],
       selected: "1"
     )}
  end

  def handle_event("select", %{"day" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("select", %{"day" => day}, socket) do
    old_date = socket.assigns.initial_date
    new_date = %Date{old_date | day: String.to_integer(day)}

    {:noreply,
     socket
     |> assign(
       selected: day,
       initial_date: new_date,
       errands: []
     )
     |> push_event("update_selection", %{
       current_id: "day-cell-#{old_date.day}",
       new_id: "day-cell-#{day}"
     })}
  end

  defp make_calendar(date) do
    reference_date = Date.new!(date.year, date.month, 1)
    prepend = Date.day_of_week(reference_date) - 1

    1..(reference_date |> Date.days_in_month())
    |> Enum.map(&to_string/1)
    |> then(fn list -> apply(&Kernel.++/2, [List.duplicate("", prepend), list]) end)
    |> Enum.chunk_every(7)
  end

  def weeks_in_month(date) do
    first_day = Date.new!(date.year, date.month, 1)
    days_in_month = Date.days_in_month(first_day)
    first_day_of_week = Date.day_of_week(first_day)
    total_days = days_in_month + (first_day_of_week - 1)
    div(total_days, 7) + if rem(total_days, 7) > 0, do: 1, else: 0
  end

  defp parse_month(month), do: @months |> Enum.at(month - 1)

  defp prev_month(date) do
    previous_month = Date.add(date, -date.day)
    Date.beginning_of_month(previous_month)
  end

  defp next_month(date) do
    next_month = date |> Date.add(Date.days_in_month(date) - date.day + 1)
    Date.beginning_of_month(next_month)
  end
end
