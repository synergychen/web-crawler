class CreateImageTasks < ActiveRecord::Migration
  def change
    create_table :image_tasks do |t|
      t.string :uri
      t.string :state
      t.integer :priority
      t.datetime :available_time
      t.timestamps
    end
  end
end
