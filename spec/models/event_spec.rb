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

  describe '#equals? method' do
    it 'should return true if given object has equivelant core fields' do
      # creates json object
      json_object = { title: 'title1', url: 'url1',
        web_source: 'Gorki', start_date: Date.today }
      
      # creates event with some extra date
      event = create(:event, json_object.merge({description: "desc"}))
      

      expect(event.equals?(json_object)).to equal true
    end

    it 'should return false if given object has different core fields' do
      # creates json object
      json_object = { title: 'title1', url: 'url1',
        web_source: 'Gorki', start_date: Date.today }
      
      # creates event with slightly different fields
      event = create(:event, json_object.merge({url: "url2"}))

      expect(event.equals?(json_object)).to equal false
    end
  end
end
