module Api
  class ApiController < ApplicationController

    before_action :check_auth

    def check_auth
      authenticate_or_request_with_http_basic do |username,password|
        resource = User.find_by_email(username)
        if resource && resource.valid_password?(password)
          sign_in :user, resource
        end
      end
    end
  end
end