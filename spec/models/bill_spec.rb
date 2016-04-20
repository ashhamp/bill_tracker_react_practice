require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe "validations" do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    let!(:bill1) do FactoryGirl.create(
      :bill,
      nickname: "hello",
      user: user1)
    end

    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to have_valid(:nickname).when("Visa", "RE Tax") }
    it { is_expected.to_not have_valid(:nickname).when(nil, "") }

    it "validates uniqueness of nickname" do
      bill2 = FactoryGirl.build(:bill, nickname: "Hello", user: user1)
      bill3 = FactoryGirl.build(:bill, nickname: "Hello", user: user2)
      expect(bill2).to_not be_valid
      expect(bill3).to be_valid
    end

    it { is_expected.to validate_presence_of(:start_due_date) }
    it do is_expected.to have_valid(
      :start_due_date).when(
        "2016/09/01",
        "2017/08/03",
        "01/05/2019"
      )
    end
    it do is_expected.to_not have_valid(
      :start_due_date).when(
        nil,
        "",
        "apple",
        2016,
        "2015/01/04",
        "03/19/2016"
      )
    end
    it do is_expected.to have_valid(
      :next_due_date).when(
        "2016/09/01",
        "2017/08/03",
        "01/05/2019"
      )
    end
    it do is_expected.to_not have_valid(
      :next_due_date).when(
        "apple",
        2016,
        "2015/01/04",
        "03/19/2016"
      )
    end
  end
end
