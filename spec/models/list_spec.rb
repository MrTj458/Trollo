require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'attributes' do
    [:name].each do |attr|
      it {should respond_to attr}
    end

    it {should validate_presence_of :name}
  end
end
