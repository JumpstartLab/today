class Authentication
  def self.perform(code)
    User.from_github Github.authenticate(code)
  end
end
