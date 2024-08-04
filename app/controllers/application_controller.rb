class ApplicationController < ActionController::API
  def authenticate_request
    token = request.headers['Authorization']
    render json: { error: 'Unauthorized' }, status: :unauthorized unless token_present?(token)
  end

  def token_present?(token)
    token.present? && valid_token?(token)
  end

  def valid_token?(token)
    token = token.split(' ').last if token.start_with?('Bearer ')
    secret_key = Rails.application.secrets.secret_key_base

    begin
      decoded_token = JWT.decode(token, secret_key, true, { algorithm: 'HS256' })
      true
    rescue JWT::DecodeError
      false
    end
  end
end
