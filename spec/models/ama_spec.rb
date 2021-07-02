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
      @ama.update(start_date: Time.now - 1.hour)
      @ama.refresh_state
      expect(@ama.state).to eq('preparing')
    end

    it 'is live' do
      @ama.update(start_date: Time.now - 24.hour, state: 2)
      @ama.refresh_state
      expect(@ama.state).to eq('live')
    end
  end
end