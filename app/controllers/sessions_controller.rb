class SessionsController < Devise::SessionsController
    respond_to :json

    def create

      super
    end
end
