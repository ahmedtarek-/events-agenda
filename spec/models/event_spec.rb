require 'rails_helper'

RSpec.describe Event do

  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe '#url' do
    it { should validate_presence_of(:url) }
    
    it 'should have a unique #url' do
      create(:event)
      should validate_uniqueness_of(:url)
    end
  end

end