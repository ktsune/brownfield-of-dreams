# frozen_string_literal: true

module Github
  class Repo
    attr_reader :full_path, :path

    def initialize(data)
      puts data
      @full_path = data[:html_url]
      @path = data[:full_name]
    end
  end
end
