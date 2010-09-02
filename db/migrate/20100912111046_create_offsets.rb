class CreateOffsets < ActiveRecord::Migration
  def self.up
    create_table :offsets do |t|

      t.integer :lat,       :limit => 6, :null => false
      t.integer :lng,       :limit => 6, :null => false
      t.integer :x,         :limit => 6, :null => false
      t.integer :y,         :limit => 6, :null => false

    end
  end

  def self.down
    drop_table :offsets
  end
end
