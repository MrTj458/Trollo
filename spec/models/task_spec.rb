require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'attributes' do
    [:task].each do |attr|
      it {should respond_to attr}
    end

    it {should validate_presence_of :task}
  end
end
