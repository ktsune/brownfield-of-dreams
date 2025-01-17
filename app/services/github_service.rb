# frozen_string_literal: true

class GithubService
  def initialize(user)
    # binding.pry
    @conn = Faraday.new(url: 'https://api.github.com/') do |f|
      # f.headers['Authorization'] = "token #{ENV['GITHUB_TOKEN']}"
      f.basic_auth user.handle, user.token
      f.adapter Faraday.default_adapter
    end
  end

  def fetch_repos
    fetch('/user/repos')
  end

  def fetch_followers
    fetch('/user/followers')
  end

  def fetch_following
    fetch('/user/following')
  end

  def fetch_email(handle)
    fetch("/users/#{handle}")[:email]
  end

  private

  attr_reader :conn

  def fetch(uri)
    JSON.parse(conn.get(uri).body, symbolize_names: true)
  end
end
