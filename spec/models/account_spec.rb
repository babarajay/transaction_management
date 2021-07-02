require 'rails_helper'

RSpec.describe "Account", type: :model do

  describe 'Associations' do
    it "belongs_to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many transactions" do
      assc = described_class.reflect_on_association(:transactions)
      expect(assc.macro).to eq :has_many
    end
  end
end