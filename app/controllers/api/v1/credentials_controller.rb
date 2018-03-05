class Api::V1::CredentialsController < ApplicationController
  before_action :doorkeeper_authorize!

  def me
    render json: UserSerializer.new(current_resource_owner).serialized_json
  end

  private

  # Find the user that owns the access token
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
