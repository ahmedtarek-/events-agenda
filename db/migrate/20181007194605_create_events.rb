class CreateEvents < ActiveRecord::Migration[5.2]
  def up
    create_table :events do |t|
      
      t.string    :title, null: false
      t.string    :category
      t.text      :description
      t.text      :event_info
      t.string    :url, null: false
      t.string    :img_url
      t.datetime  :start_date, null: false
      t.datetime  :end_date
      t.string    :web_source, null: false

      t.timestamps null: false
    end
  end

  def down
    drop_table :events
  end
end
