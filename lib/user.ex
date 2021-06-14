defmodule JsonDataCommunicatorClient.User do
  @derive Jason.Encoder
  defstruct [:attributes, :email, :password, :username]
end
