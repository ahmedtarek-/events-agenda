class CreateEvents < ActiveRecord::Migration[5.2]
  def up
    create_table :events do |t|
      
      t.string    :title
      t.string    :category
      t.text      :description
      t.text      :event_info
      t.string    :url  
      t.string    :img_url
      t.datetime  :start_date
      t.datetime  :end_date
      t.string    :web_source

      t.timestamps null: false
    end
  end

  def down
    drop_table :jobs
  end
end
