# spec/workers/vehicle_scraper_worker_spec.rb
require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.describe VehicleScraperWorker, type: :worker do
  let!(:task) { FactoryBot.create(:task) }
  let!(:vehicles) { FactoryBot.create_list(:vehicle, 50, task_id: task.id) }

  it 'scrapes vehicles and creates records', :vcr do
    expect {
      VehicleScraperWorker.new.perform( options = { "task": task.id, "vehicle_type": 'carros-novos' })
    }.to change { Vehicle.count }.by_at_least(50)
  end
end
