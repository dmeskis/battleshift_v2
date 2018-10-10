class UserLogic
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def single_user
    User.new(service.find_user)
  end

  def many_users
    @users ||= service.all_users
    @users.map do |user_data|
      User.new(user_data)
    end
  end

  def update_user
    service.update_user
  end

  private
    def service
      UserService.new(params)
    end
end
