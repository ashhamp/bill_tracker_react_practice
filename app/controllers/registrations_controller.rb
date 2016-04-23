class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      render json: { redirect: bills_path, status: 200 }
    else
      @errors = @user.errors.full_messages.join(". ")
      render json: { errors: @errors, status: 500 }
    end
  end
end
