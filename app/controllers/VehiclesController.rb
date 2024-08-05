class VehiclesController < ApplicationController
  before_action :authenticate_request

  def scrape
    task = Task.create(
      user_email: permited_params[:user_email],
      uuid: SecureRandom.uuid,
      status: "pending"
      )

    NotificationWorker.perform_async(options = {
      task_uuid: task.uuid,
      user_email: task.user_email,
      status: task.status
    })

    VehicleScraperWorker.perform_async(
      options = {
        vehicle_type: permited_params[:vehicle_type],
        task: task.id }
      )
    render json: task, status: :accepted
  end

  def vehicles
    task = Task.find_by(uuid: permited_params[:uuid])

    if !task.nil?
      render json: task.vehicles, status: :ok
    else
      render "not found", status: :unprocessable_entity
    end
  end

  def tasks
    render json: Task.all, status: :ok
  end

  def destroy_task
    task = Task.find_by(uuid: permited_params[:uuid])

    task.destroy
    render status: :ok
  end

  private

  def permited_params
    params.permit(:vehicle_type, :user_email, :uuid)
  end
end
