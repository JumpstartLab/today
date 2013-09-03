class User < ActiveRecord::Base
  has_one :application, inverse_of: :user

  def self.from_github(data)
    user = User.where(github_id: data['id']).first
    user_data = {
      name: data['name'],
      email: data['email'],
      location: data['location'],
      github_id: data['id'],
      avatar_url: data['avatar_url'],
      gravatar_id: data['gravatar_id']
    }
    user ||= User.new(user_data)
    user.username = data['login'] # always update the GitHub username
    user.save
    user
  end

  def guest?
    false
  end

  def admin?
    is_admin
  end

  def applying?
    application && application.completed?('bio')
  end

  def apply
    build_application unless application
    application
  end

  def apply!
    create_application unless application
    application
  end

  def admin!
    self.is_admin = true
    save
  end
end
