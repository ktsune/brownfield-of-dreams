class DashboardFacade
  def initialize(user)
    @service = GithubService.new(user.token)
    @friendships = user.friendship_uids
  end

  def repos
    @_repos ||= get_repos
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
      Github::Handle.new(raw_follower, @friendships)
    end
  end

  def get_following
    service.fetch_following.map do |raw_following|
      Github::Handle.new(raw_following, @friendships)
    end
  end
end
