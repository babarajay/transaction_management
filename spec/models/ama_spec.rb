require 'rails_helper'

RSpec.describe "Ama", type: :model do

  before(:each) do
    @user = User.create(email: "test@test.com", first_name: "test", password: "12345678", password_confirmation: "12345678")
    @ama = Ama.create(title: "Test", start_date: Time.now, speaker_id: @user.id)
  end

  describe 'state' do
    it 'is unstart' do
      expect(@ama.state).to eq('unstart')
    end
    it 'is preparing' do
      (1..60).each do |m|
        @ama.start_date = Time.now + m.minutes
        @ama.refresh_state
        expect(@ama.state).to eq('preparing')
      end
    end
    it 'is live' do
      (0..59).each do |m|
        @ama.start_date = Time.now - m.minutes
        @ama.refresh_state
        expect(@ama.state).to eq('live')
      end
    end
    it 'is finished' do
      @ama.start_date = Time.now - 2.hours
      @ama.refresh_state
      expect(@ama.state).to eq('finished')
    end
    it 'is completed' do
      @ama.start_date = Time.now - 24.hours
      @ama.refresh_state
      expect(@ama.state).to eq('completed')
    end
  end
end