# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a valid factory' do
    task = FactoryBot.build(:task)
    expect(task).to be_valid
  end

  it 'is invalid without a user_email' do
    task = FactoryBot.build(:task, user_email: nil)
    expect(task).not_to be_valid
  end

  it 'is invalid without a user_id' do
    task = FactoryBot.build(:task, user_id: nil)
    expect(task).not_to be_valid
  end

  it 'is invalid without a status' do
    task = FactoryBot.build(:task, status: nil)
    expect(task).not_to be_valid
  end

  it 'is invalid without a uuid' do
    task = FactoryBot.build(:task, uuid: nil)
    expect(task).not_to be_valid
  end
end
