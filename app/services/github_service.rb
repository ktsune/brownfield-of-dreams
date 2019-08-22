class GithubService
  def initialize(user)
    @conn = Faraday.new(:url => "https://api.github.com/") do |f|
      #f.headers['Authorization'] = "token #{token}"
      f.basic_auth user.handle, user.token
      f.adapter Faraday.default_adapter
    end
  end

  def fetch_repos
    fetch('/user/repos')
  end

  private
  attr_reader :conn

  def fetch(uri)
    JSON.parse(conn.get(uri).body, symbolize_names: true)
  end
end
