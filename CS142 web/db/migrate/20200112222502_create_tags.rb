class CreateTags < ActiveRecord::Migration[6.0]
  def self.up
    create_table :tags do |t|
      t.integer :photo_id, :null => false, :options =>
      "CONSTRAINT fk_tags_photos REFERENCES photos(id)"
      t.integer :user_id, :null => false, :options =>
      "CONSTRAINT fk_tags_users REFERENCES users(id)"
      t.integer :x_coord
      t.integer :y_coord
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end 
end
