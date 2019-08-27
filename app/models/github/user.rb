# frozen_string_literal: true

module Github
  class User
    attr_reader :path, :name, :uid
    def initialize(data)
      @path = data[:html_url]
      @name = data[:login]
      @uid = data[:id].to_s
    end
  end
end
