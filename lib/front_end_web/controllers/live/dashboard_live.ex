defmodule FrontEndWeb.DashboardLive do
  use Phoenix.LiveView
  import Iconify

  def mount(_params, _session, socket) do
    bubble_cards = [
      %{title: "Available Position", stat: 24, note: "4 Urgently needed", color: "orange"},
      %{title: "Job Open", stat: 10, note: "4 Active hiring", color: "blue"},
      %{title: "Total Employees", stat: 24, note: "4 Departments", color: "pink"}
    ]

    graph_cards = [
      %{title: "Total Employees", amount: 216, men: 120, women: 96, percent: "+2"},
      %{title: "Talent Request", amount: 16, men: 10, women: 6, percent: "+5"}
    ]

    announcement_cards = [
      %{title: "Outing schedule for every departement", time: "5 Minutes ago", pinned: true},
      %{title: "Meeting HR Department", time: "Yesterday, 12:30 PM", pinned: false},
      %{
        title: "YIT Department need two more talents for UX/UI Designer position",
        time: "Yesterday, 09:15 AM",
        pinned: false
      }
    ]

    schedule_cards = %{
      priority: [
        %{title: "Review candidate applications", time: "5 Minutes ago"}
      ],
      other: [
        %{title: "Interview with candidates", time: "Today - 10.30 AM"},
        %{
          title: "Short meeting with product designer from IT Departement",
          time: "Today - 09.15 AM"
        },
        %{title: "Sort Front-end developer candidates", time: "Today - 11.30 AM"}
      ]
    }

    {:ok,
     socket
     |> assign(
       bubble_cards: bubble_cards,
       graph_cards: graph_cards,
       announcement_cards: announcement_cards,
       schedule_cards: schedule_cards
     )}
  end

  def bell_icon(assigns) do
    assigns = assign(assigns, attrs: assigns_to_attributes(assigns))

    ~H"""
    <svg width="19" height="20" viewBox="0 0 19 20" xmlns="http://www.w3.org/2000/svg" {@attrs}>
      <path
        d="M9.50146 20C10.8066 20 11.8745 19.0769 11.8745 17.9487H7.12843C7.12843 18.4928 7.37845 19.0145 7.82348 19.3992C8.26851 19.7839 8.8721 20 9.50146 20ZM16.6205 13.8462V8.71795C16.6205 5.56923 14.6747 2.93333 11.2812 2.2359V1.53846C11.2812 0.68718 10.4863 0 9.50146 0C8.51666 0 7.72169 0.68718 7.72169 1.53846V2.2359C4.3164 2.93333 2.38238 5.55897 2.38238 8.71795V13.8462L0.851774 15.1692C0.104271 15.8154 0.626337 16.9231 1.68233 16.9231H17.3087C18.3647 16.9231 18.8987 15.8154 18.1512 15.1692L16.6205 13.8462Z"
        fill="#B2B2B2"
      />
      <circle cx="15" cy="4" r="4.5" fill="#FF5151" stroke="white" />
    </svg>
    """
  end

  def magnify_icon(assigns) do
    assigns = assign(assigns, attrs: assigns_to_attributes(assigns))

    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" {@attrs}>
      <path
        fill="currentColor"
        stroke="currentColor"
        stroke-width="2"
        fill-rule="evenodd"
        d="M11.5 2.75a8.75 8.75 0 1 0 0 17.5a8.75 8.75 0 0 0 0-17.5M1.25 11.5c0-5.66 4.59-10.25 10.25-10.25S21.75 5.84 21.75 11.5c0 2.56-.939 4.902-2.491 6.698l3.271 3.272a.75.75 0 1 1-1.06 1.06l-3.272-3.271A10.2 10.2 0 0 1 11.5 21.75c-5.66 0-10.25-4.59-10.25-10.25"
        clip-rule="evenodd"
      />
    </svg>
    """
  end

  def department_icon(assigns) do
    assigns = assign(assigns, attrs: assigns_to_attributes(assigns))

    ~H"""
    <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg" {@attrs}>
      <path
        d="M9 0C4.032 0 0 4.032 0 9C0 13.968 4.032 18 9 18C13.968 18 18 13.968 18 9C18 4.032 13.968 0 9 0ZM5.4 13.95C4.80326 13.95 4.23097 13.7129 3.80901 13.291C3.38705 12.869 3.15 12.2967 3.15 11.7C3.15 11.1033 3.38705 10.531 3.80901 10.109C4.23097 9.68705 4.80326 9.45 5.4 9.45C5.99674 9.45 6.56903 9.68705 6.99099 10.109C7.41295 10.531 7.65 11.1033 7.65 11.7C7.65 12.2967 7.41295 12.869 6.99099 13.291C6.56903 13.7129 5.99674 13.95 5.4 13.95ZM6.75 5.4C6.75 4.80326 6.98705 4.23097 7.40901 3.80901C7.83097 3.38705 8.40326 3.15 9 3.15C9.59674 3.15 10.169 3.38705 10.591 3.80901C11.0129 4.23097 11.25 4.80326 11.25 5.4C11.25 5.99674 11.0129 6.56903 10.591 6.99099C10.169 7.41295 9.59674 7.65 9 7.65C8.40326 7.65 7.83097 7.41295 7.40901 6.99099C6.98705 6.56903 6.75 5.99674 6.75 5.4V5.4ZM12.6 13.95C12.0033 13.95 11.431 13.7129 11.009 13.291C10.5871 12.869 10.35 12.2967 10.35 11.7C10.35 11.1033 10.5871 10.531 11.009 10.109C11.431 9.68705 12.0033 9.45 12.6 9.45C13.1967 9.45 13.769 9.68705 14.191 10.109C14.6129 10.531 14.85 11.1033 14.85 11.7C14.85 12.2967 14.6129 12.869 14.191 13.291C13.769 13.7129 13.1967 13.95 12.6 13.95Z"
        fill="#B2B2B2"
      />
    </svg>
    """
  end

  def color_bubble(assigns) do
    ~H"""
    <div class={"bg-#{@card.color}-100 pl-5 p-3 space-y-4 rounded-lg"}>
      <p class="font-medium">{@card.title}</p>
      <p class="text-3xl font-medium text-gray-800 mt-2">{@card.stat}</p>
      <p class={"font-roboto text-sm text-#{@card.color}-800 mt-1"}>{@card.note}</p>
    </div>
    """
  end

  def graph_bubble(assigns) do
    ~H"""
    <div class="flex justify-between p-5 space-x-10 border-gray-400 border-[1px] rounded-lg">
      <div>
        <h3 class="text-base font-medium mb-0.5">{@card.title}</h3>
        <p class="text-myxl font-medium text-gray-800 mt-5 mb-8">{@card.amount}</p>
        <div class="space-y-1">
          <p class="text-sm text-gray-500">{@card.men} Men</p>
          <p class="text-sm text-gray-500">{@card.women} Women</p>
        </div>
      </div>
      <div class="grid grid-cols-1 relative">
        <p class="text-orange-800 text-xxs font-rubik font-medium translate-y-[40%] translate-x-[40%]">
          {@card.percent}%
        </p>
        <image src="/images/graph.svg" class="justify-self-stretch" />
        <p class="size-fit font-roboto text-xs rounded-md bg-orange-100 ml-2 px-2.5 py-1 mt-4 text-center">
          {@card.percent}% Past month
        </p>
      </div>
    </div>
    """
  end

  slot :inner_block

  def list_bubble(assigns) do
    ~H"""
    <div class="border-gray-400 border-[1px] rounded-lg divide-y-2 overflow-hidden">
      <div class="p-5 space-y-4">
        <div class="flex justify-between">
          <h3 class="text-base font-medium mb-0.5">{@title}</h3>
          <div class="flex justify-between py-1 border-gray-50 border-[1px] rounded-md">
            <p class="ml-1.5 text-xxs text-gray-500 font-roboto">{@time}</p>
            <.iconify icon="solar:alt-arrow-down-line-duotone" class="mx-2 h-4 w-4 text-gray-300" />
          </div>
        </div>
        {render_slot(@inner_block)}
      </div>
      <p class="text-orange-800 text-sm font-medium text-center p-2.5">{@bottom_text}</p>
    </div>
    """
  end

  def gray_bubble(assigns) do
    ~H"""
    <div class="bg-gray-100 border-[1px] rounded-md space-y-[5px] py-2">
      <p class="pl-3.5 mr-2.5 text-sm">{@card.title}</p>
      <div class="flex px-3.5 justify-between">
        <p class="text-xxs">{@card.time}</p>
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end
end
