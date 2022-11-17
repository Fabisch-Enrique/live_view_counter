defmodule LiveViewCounterWeb.Counter do
  use Phoenix.LiveView

  #each client connected tothe app subscribes to this channel, when it's updated all client see the update
  #Uses Phoenix's built-in channels ("WebSocket")system
  @topic "live"
  def mount(_params, _session, socket) do
    LiveViewCounterWeb.Endpoint.subscribe(@topic) #subscription to the channel "topic"
    {:ok, assign(socket, :val, 0)}
  end

  def handle_event("inc", _, socket) do
    new_state =  update(socket, :val, &(&1 + 1))
    LiveViewCounterWeb.Endpoint.broadcast_from(self(), @topic, "inc", new_state.assigns)
    {:noreply, new_state}
  end

  def handle_event("dec", _, socket) do
    new_state =  update(socket, :val, &(&1 - 1))
    LiveViewCounterWeb.Endpoint.broadcast_from(self(), @topic, "dec", new_state.assigns)
    {:noreply, new_state}
  end

  def handle_info(msg, socket) do
    {:noreply, assign(socket, val: msg.payload.val)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>The Count is: <%= @val %></h1>
      <button phx-click="dec"> - </button>
      <button phx-click="inc"> + </button>
    </div>
    """
  end
end
