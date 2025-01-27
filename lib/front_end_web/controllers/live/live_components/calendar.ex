defmodule FrontEndWeb.CalendarComponent do
  use Phoenix.LiveComponent
  alias FrontEnd.Errands

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       calendar: make_calendar(assigns.initial_date),
       weeks: weeks_in_month(assigns.initial_date),
       current_month: parse_month(assigns.initial_date.month),
       selected: assigns.initial_date.day |> to_string,
       errands: Errands.get_errands(assigns.initial_date)
     )}
  end

  @months ~w"January February March April May June July August September October November December"
  def render(assigns) do
    ~H"""
    <div class="dark:bg-coal rounded-lg shadow-lg p-18 text-2xl font-medium">
      <div class="flex justify-between items-center mb-14 text-primary dark:text-white">
        <div class="font-bold">
          <span>{@current_month} {@initial_date.year}</span>
        </div>
        <div class="flex flex-row space-between-8">
          <div class="size-8 justify-items-center rounded-full hover:bg-gray-300 dark:hover:bg-gray-500">
            <Heroicons.icon
              name="chevron-left"
              type="outline"
              class="size-5 m-auto mt-1"
              phx-click="prev_month"
              phx-target={@myself}
            />
          </div>
          <div class="justify-items-center size-8 rounded-full hover:bg-gray-300 dark:hover:bg-gray-500">
            <Heroicons.icon
              name="chevron-right"
              type="outline"
              class="size-5 m-auto mt-1"
              phx-click="next_month"
              phx-target={@myself}
            />
          </div>
        </div>
      </div>
        <table class="select-none font-regular">
          <tr>
            <th
              :for={week_day <- ~w"Mo Tu We Th Fr Sa Su"}
              class="size-14 text-center text-gray-600 dark:text-white"
            >
              {week_day}
            </th>
          </tr>
          <tr :for={week <- 0..(@weeks - 1)}>
            <td
              :for={day <- @calendar |> Enum.at(week)}
              class={"size-14 text-center align-middle " <>
          (if day == @selected, do: day_class(day, :selected), else: day_class(day, "none"))}
              phx-click="select"
              phx-target={@myself}
              phx-value-day={day}
            >
              <div class="size-7 m-auto mb-1">
                {day}
              </div>
            </td>
          </tr>
          <tr :if={@weeks < 6} class="h-10">
            <td colspan="7"></td>
          </tr>
          <tr :if={@weeks < 5} class="h-10">
            <td colspan="7"></td>
          </tr>
        </table>
      <div :if={@errands != []} div class="mt-4 dark:text-white border-t-2">
        <ul class="pt-4 space-y-2">
          <li :for={errand <- @errands} class="flex flex-col">
            <span class="text-sm text-slate-500">
              {Calendar.strftime(errand.to_do_at, "%I:%M %p")}
            </span>
            <span>{errand.description}</span>
          </li>
        </ul>
      </div>
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
       errands: Errands.get_errands(new_date),
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
       errands: Errands.get_errands(new_date),
       selected: "1"
     )}
  end

  def handle_event("select", %{"day" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("select", %{"day" => day}, socket) do
    new_date = %Date{socket.assigns.initial_date | day: String.to_integer(day)}

    {:noreply,
     socket
     |> assign(
       selected: day,
       initial_date: new_date,
       errands: Errands.get_errands(new_date)
     )}
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

  defp day_class("", _), do: ""
  defp day_class(_day, :selected), do: "bg-selected dark:bg-selected-dark text-white rounded-full"
  defp day_class(_day, _), do: "rounded-full text-secondary dark:text-secondary-dark hover:bg-gray-300 dark:hover:bg-gray-600"


end
