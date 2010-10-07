class CreateCoordinates < ActiveRecord::Migration
  def self.up
    create_table :coordinates do |t|

      #calcuted lat/lng
      t.decimal :latitude,  :precision => 14, :scale => 10, :null => false
      t.decimal :longitude, :precision => 14, :scale => 10, :null => false

      #origin lat/lng send by user's device
      t.decimal :lat,       :precision => 14, :scale => 10, :null => false
      t.decimal :lng,       :precision => 14, :scale => 10, :null => false

      t.integer   :sensor,  :limit => 3, :default => 0, :null => false


      t.references :user, :null => false
      t.references :device, :null => false
      t.references :action, :null => true
      t.references :path, :null => true

      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :coordinates
  end
end
