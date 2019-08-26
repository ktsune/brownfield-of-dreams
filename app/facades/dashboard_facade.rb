class DashboardFacade
  def initialize(user)
    if user.token
      @service = GithubService.new(user)
      @auth = true
    else
      @auth = false
    end
    @friends = user.friends
  end
  attr_reader :friends

  def is_auth?; @auth end

  def repos
    if @auth
      @_repos ||= get_repos
    else
      []
    end
  end

  def video_section
    
  end

  def followers
    @_followers ||= get_followers
  end

  def following
    @_following ||= get_following
  end

  private
  attr_reader :service

  def get_repos
    service.fetch_repos.take(5).map do |raw_repo|
      Github::Repo.new(raw_repo)
    end
  end

  def get_followers
    service.fetch_followers.map do |raw_follower|
      Github::User.new(raw_follower)
    end
  end

  def get_following
    service.fetch_following.map do |raw_following|
      Github::User.new(raw_following)
    end
  end
end
