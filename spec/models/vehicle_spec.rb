require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it 'has a valid factory' do
    task = FactoryBot.build(:task)
    vehicle = FactoryBot.build(:vehicle, task_id: task.id)
    expect(vehicle).to be_valid
  end
end
