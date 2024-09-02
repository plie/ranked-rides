require 'rails_helper'

RSpec.describe Driver, type: :model do

  describe 'validations' do
    # verbose
    it 'is valid with valid attributes' do
      driver = Driver.new(name: "Sandy Brown", home_address: "1105 W 39th St, Austin, TX 78756")
      expect(driver).to be_valid
    end

    it 'is not valid without a home_address' do
      driver = Driver.new(name: "Bill Bones")
      expect(driver).not_to be_valid
      expect(driver.errors[:home_address]).to include("can't be blank")
    end

    # succinct
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:home_address) }
  end
end
