require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { build(:user) }

    context "when user does not have a first and last name" do
        it "is not valid" do
            user.first_name = nil
            user.last_name = nil

            expect(user).to_not be_valid
        end
    end

    context "when user has all params present" do
        it "is valid" do
            expect(user).to be_valid
        end
    end
end