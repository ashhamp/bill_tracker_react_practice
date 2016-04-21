require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "validations" do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    let!(:bill1) { FactoryGirl.create(:bill, user: user1) }

    let!(:payment) { FactoryGirl.create(:payment, user: user1, bill: bill1) }


    it { is_expected.to validate_presence_of(:pmt_date) }
    it do
      is_expected.to have_valid(:pmt_date).when(
        "2016/04/12",
        "2015/07/17",
        "2016/06/04"
      )
    end
    it do
      is_expected.to_not have_valid(:pmt_date).when(
        nil,
        "",
        2016,
        "apple",
        "2016",
        "08/16"
      )
    end
    it { is_expected.to validate_presence_of(:pmt_amt) }
    it { is_expected.to have_valid(:pmt_amt).when(90, "807.76", "0.76") }
    it do
      is_expected.to_not have_valid(:pmt_amt).when(
        nil,
        "",
        "apple"
      )
    end
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:bill) }
  end
end
