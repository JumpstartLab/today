class Github
  def self.login_url
    "https://github.com/login/oauth/authorize?client_id=#{ENV.fetch('GITHUB_CLIENT_ID')}"
  end

  def self.authenticate(code)
    conn = Faraday.new(:url => 'https://github.com') do |c|
      c.use Faraday::Response::Logger
      c.use Faraday::Adapter::NetHttp
    end

    options = {
      client_id: ENV.fetch('GITHUB_CLIENT_ID'),
      client_secret: ENV.fetch('GITHUB_CLIENT_SECRET'),
      code: code
    }

    options = options.map {|k,v| "#{k}=#{v}"}.join('&')

    response = conn.post do |req|
      req.url '/login/oauth/access_token'
      req.headers['Accept'] = 'application/json'
      req.headers['User-Agent'] = user_agent
      req.body = options
    end
    access_token = JSON.parse(response.body)['access_token']

    conn = Faraday.new(:url => 'https://api.github.com') do |c|
      c.use Faraday::Response::Logger
      c.use Faraday::Adapter::NetHttp
    end

    response = conn.get do |req|
      req.url '/user'
      req.headers['User-Agent'] = user_agent
      req.params['access_token'] = access_token
    end
    JSON.parse(response.body)
  end

  def self.user_agent
    'github.com:JumpstartLab/today'
  end
end
