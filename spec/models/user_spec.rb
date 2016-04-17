require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { FactoryGirl.build(:user) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to have_valid(:username).when("mcuser", "ash") }
    it { is_expected.to_not have_valid(:username).when(nil, "") }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it do
      is_expected.to have_valid(:email).when(
        'test@test.com',
        'test+spam@gmail.com',
        'hello@hello.net'
      )
    end

    it do
      is_expected.to_not have_valid(:email).when(
        'fail',
        123,
        'five.com',
        "hello@"
      )
    end

    it { is_expected.to have_valid(:password).when('IamaPAssword') }

    it do
      is_expected.to_not have_valid(:password).when(
        nil,
        "",
        "small"
      )
    end
  end
end
