class NotificationService < ApplicationService
  def self.call(task_uuid, user_email, status)
    connection = Faraday.new(url: ENV.fetch("NOTIFICATION_SERVICE_URL", "https://d1db-179-124-14-31.ngrok-free.app")) do |faraday|
      faraday.request :json
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    response = connection.post('/notifications') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        notification: {
          task_uuid: task_uuid,
          user_email: user_email,
          status: status
        }
      }.to_json
    end

    handle_response(response)
  end

  private

  def self.handle_response(response)
    case response.status
    when 200..299
      puts 'Notification created successfully'
    else
      puts "Error: #{response.status} - #{response.body}"
    end
  end
end
