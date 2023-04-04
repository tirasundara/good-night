module Api
  class BaseApiController < ApplicationController
    include ErrorHandler


    private

    # Assume, the authentication system is already handled
    # in real world, we can use token-based authentication such as JWT
    def current_user
      return @current_user if defined? @current_user

      @current_user = User.find_or_create_by(name: "Bob")
    end
  end
end
