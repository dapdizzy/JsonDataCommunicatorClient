defmodule JsonDataCommunicatorClient.User.Attributes do
  @derive Jason.Encoder
  defstruct [:firstName, :lastName, :city]
end
