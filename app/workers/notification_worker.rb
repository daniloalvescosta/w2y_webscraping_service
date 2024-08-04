class NotificationWorker
  include Sidekiq::Worker

  def perform(options = {})
  puts "PASSEI POR AQUI #{options["task_uuid"]}, #{options["user_email"]}, #{options["status"]}"
    NotificationService.call(
      options["task_uuid"], options["user_email"], options["status"]
    )
  end
end
