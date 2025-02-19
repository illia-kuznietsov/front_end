defmodule FrontEndWeb.FormLive do
  use FrontEndWeb, :live_view

  @initial_form_data %{
    "name" => "",
    "email" => "",
    "phone" => "",
    "company" => "",
    "services-dev" => nil,
    "services-web" => nil,
    "services-marketing" => nil,
    "services-other" => nil,
    "budget" => nil
  }

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(current_stage: 1, form_data: @initial_form_data, errors: %{})}
  end

  def handle_event("change", %{"_target" => ["name"], "name" => name} = form_data, socket) do
    errors = validate_name(socket.assigns.errors, name)

    {:noreply,
     assign(socket, form_data: Map.merge(socket.assigns.form_data, form_data), errors: errors)}
  end

  def handle_event("change", %{"_target" => ["email"], "email" => email} = form_data, socket) do
    errors = validate_email(socket.assigns.errors, email)

    {:noreply,
     assign(socket, form_data: Map.merge(socket.assigns.form_data, form_data), errors: errors)}
  end

  def handle_event("change", %{"_target" => ["phone"], "phone" => phone} = form_data, socket) do
    errors = validate_phone(socket.assigns.errors, phone)

    {:noreply,
     assign(socket, form_data: Map.merge(socket.assigns.form_data, form_data), errors: errors)}
  end

  def handle_event(
        "change",
        %{"_target" => ["company"], "company" => company} = form_data,
        socket
      ) do
    errors = validate_company(socket.assigns.errors, company)

    {:noreply,
     assign(socket, form_data: Map.merge(socket.assigns.form_data, form_data), errors: errors)}
  end

  def handle_event("change", form_data, socket) do
    {:noreply, assign(socket, form_data: form_data)}
  end

  def handle_event("next-step", _, %{assigns: %{current_stage: stage, form_data: form}} = socket) do
    case validate_current_stage(stage, form) do
      :ok ->
        {:noreply, assign(socket, current_stage: stage + 1, errors: %{})}

      {:error, errors} ->
        {:noreply, assign(socket, errors: errors)}
    end
  end

  def handle_event("prev-step", _, %{assigns: %{current_stage: stage}} = socket) do
    {:noreply, assign(socket, current_stage: max(stage - 1, 1))}
  end

  def handle_event("submit", form_data, socket) do
    {:noreply,
     socket
     |> put_flash(
       :info,
       "Thanks for submitting the form, here's the data: #{Jason.encode!([form_data])}"
     )}
  end

  # Validation Functions
  defp validate_name(errors, name) do
    if String.split(name) |> Enum.count() < 2 do
      Map.put(errors, :name, "Name must be at least two words.")
    else
      Map.delete(errors, :name)
    end
  end

  defp validate_email(errors, email) do
    if Regex.match?(~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/, email) do
      Map.delete(errors, :email)
    else
      Map.put(errors, :email, "Invalid email format.")
    end
  end

  defp validate_phone(errors, phone) do
    if Regex.match?(~r/^\(\d{3}\) \d{3} - \d{4}$/, phone) do
      Map.delete(errors, :phone)
    else
      Map.put(errors, :phone, "Invalid phone number format. Use (123) 456 - 7890.")
    end
  end

  defp validate_company(errors, company) do
    if String.trim(company) == "" do
      Map.put(errors, :company, "Company name cannot be blank.")
    else
      Map.delete(errors, :company)
    end
  end

  defp validate_checkboxes(form, errors) do
    if Enum.any?(
         ["services-dev", "services-web", "services-marketing", "services-other"],
         &(!is_nil(form[&1]))
       ) do
      Map.delete(errors, :services)
    else
      Map.put(errors, :services, "Please select at least one service.")
    end
  end

  defp validate_budget(form, errors) do
    if form["budget"] in ["5k", "10k", "20k", "50k"] do
      Map.delete(errors, :budget)
    else
      Map.put(errors, :budget, "Please select a budget.")
    end
  end

  defp validate_current_stage(1, form) do
    errors =
      %{}
      |> validate_name(form["name"])
      |> validate_email(form["email"])
      |> validate_phone(form["phone"])
      |> validate_company(form["company"])

    if map_size(errors) == 0, do: :ok, else: {:error, errors}
  end

  defp validate_current_stage(2, form) do
    errors = validate_checkboxes(form, %{})

    if map_size(errors) == 0, do: :ok, else: {:error, errors}
  end

  defp validate_current_stage(3, form) do
    errors = validate_budget(form, %{})

    if map_size(errors) == 0, do: :ok, else: {:error, errors}
  end

  defp validate_current_stage(_, _), do: :ok
end
