defmodule SteembotPrototype.NewPostsConsumer do
  @moduledoc """
  Module that handles Steemex events
  """
  use GenStage
  alias Steemex.MungedOps
  require Logger

  def start_link(args, options \\ []) do
    GenStage.start_link(__MODULE__, args, options)
  end

  def init(state) do
    Logger.info("New posts consumer is initializing...")
    {:consumer, state, subscribe_to: state[:subscribe_to]}
  end

  def handle_events(events, _from, state) do
    IO.inspect("Events arrived: #{length(events)}")
    for op <- events do
      process_event(op)
    end

    {:noreply, [], state}
  end

  def process_event(%{data: data, metadata: metadata = %{type: :comment, block_height: h, timestamp: t}}) do
    if is_nil(data.parent_author) do
      Logger.info("New post: #{data.title} by #{data.author}")
    end
  end

  def process_event(ev) do
    :noop
  end
end
