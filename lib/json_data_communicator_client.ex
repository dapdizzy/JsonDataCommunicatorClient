defmodule JsonDataCommunicatorClient do
  use GenServer
  defstruct [:org_id, :secret, :datastore_id, :base_url]
  @self __MODULE__
  alias JsonDataCommunicatorClient.User

  # API
  def start_link(base_url) do
    @self |> GenServer.start_link(base_url, name: @self)
  end

  def post_data(server \\ @self, json_data) do
    server |> GenServer.call({:post_data, json_data})
  end

  # Callbacks
  def init(base_url) do
    org_id = System.get_env("OrganizationId")
    secret = System.get_env("Secret")
    datastore_id = System.get_env("DatastoreId")
    unless org_id && secret && datastore_id do
      raise "OrganizationId, Secret and DatastoreId env variables must be defined prior to starting the application"
    end
    {:ok, %@self{org_id: org_id, secret: secret, datastore_id: datastore_id, base_url: base_url}}
  end

  def handle_call({:post_data, json_data}, _from, %@self{org_id: org_id, secret: secret, datastore_id: datastore_id, base_url: base_url} = state) do
    response = HTTPoison.post! build_url(base_url, "user", datastore_id), serialize(%User{attributes: %User.Attributes{firstName: "Dmitry", lastName: "Pyatkov", city: "Moscow"}, email: "dima.pyatkov@gmail.com", password: "Secret", username: "dapdizzy0}"}), [{"Authorization", "Basic #{basic_auth(org_id, secret)}"}, {"Content-Type", "application/json"}, {"Accept", "application/json"}]
    {:reply, response, state}
  end

  # Private function
  defp build_url(base_url, type, datastore_id) do
    base_url |> URI.merge(type) |> URI.merge("datastore/#{datastore_id}") |> to_string()
  end

  defp serialize(struct) do
    Jason.encode!(struct)
  end

  defp basic_auth(org_id, secret) do
    Base.encode64("#{org_id}:#{secret}")
  end
end
