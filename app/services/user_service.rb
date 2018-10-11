class UserService

  def initialize(filter = {})
    @filter = filter
  end

  def find_user
    get_json("/api/v1/users/#{@filter[:id]}")
  end

  def all_users
    get_json("/api/v1/users")
  end

  def update_user
    conn.patch "/api/v1/users/#{@filter[:id]}", { :email => @filter[:email] }
  end


  private

  def conn
    Faraday.new(url: "https://polar-refuge-52259.herokuapp.com") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
