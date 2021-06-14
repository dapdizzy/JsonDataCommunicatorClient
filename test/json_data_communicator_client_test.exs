defmodule JsonDataCommunicatorClientTest do
  use ExUnit.Case
  doctest JsonDataCommunicatorClient

  test "greets the world" do
    assert JsonDataCommunicatorClient.hello() == :world
  end
end
