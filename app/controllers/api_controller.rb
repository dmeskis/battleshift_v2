class ApiController < ActionController::API

  def api_key
    request.headers['X-Api-Key']
  end
end
