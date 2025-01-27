defmodule FrontEndWeb.FormLive do
  use FrontEndWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(current_stage: 1)}
  end

  def handle_event("next-step", _, %{assigns: %{current_stage: stage}} = socket) do
    {:noreply, socket |> assign(current_stage: stage + 1)}
  end

  def handle_event("prev-step", _, %{assigns: %{current_stage: stage}} = socket) do
    {:noreply, socket |> assign(current_stage: stage - 1)}
  end

  def form_container(assigns) do
    ~H"""
    <form class="border shadow-xl pt-8 pl-11 pr-14 pb-20 mb-8 rounded-[34px]">
      <.stage_progress />
    </form>
    """
  end

  def stage_progress(assigns) do
    ~H"""
      <div class="flex justify-between bg-white mb-16 border-b pb-4">
        <%= for block <- intersperse_lists(1..4, stage_bar_indexes(4)) do %>
          <%= case block do %>
            <% {:sep, index} -> %>
              <.stage_bar current_stage={1} stage={index} />
            <% _ -> %>
              <.stage_circle stage={block} />
          <% end %>
        <% end %>
      </div>
    """
  end

  def stage_circle(assigns) do
    ~H"""
    <span class="shrink-0 size-8 rounded-full bg-left bg-gradient-to-l from-gray-200
      to-blue-500 bg-[size:300%] text-white font-bold content-center text-center">
      {@stage}
    </span>
    """
  end

  def stage_bar(assigns) do
    ~H"""
    <span class={"grow h-[6px] mx-[18px] self-center rounded-full bg-right bg-gradient-to-l from-gray-200
        to-blue-500 bg-[size:300%]"<>(@current_stage > @stage && " animate-bg-shift" || "")}>
    </span>
    """
  end

  defp stage_bar_indexes(total) do
    for i <- 2..total do
      {:sep, i}
    end
  end

  defp intersperse_lists(list1, list2) do
    combined = Enum.zip(list1, list2)

    combined
    |> Enum.flat_map(fn {a, b} -> [a, b] end)
    |> Enum.concat(Enum.drop(list1, length(list2)))
  end
end
