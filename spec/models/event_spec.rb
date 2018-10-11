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

  describe '#web_source' do
    it { should validate_inclusion_of(:web_source).in_array(Event::WEB_SOURCE_POSSIBLE_VALUES) }
  end

  describe '#start_date' do
    it { should validate_presence_of(:start_date) }
  end
end
