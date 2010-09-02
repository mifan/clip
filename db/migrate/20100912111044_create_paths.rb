class CreatePaths < ActiveRecord::Migration
  def self.up
    create_table :paths do |t|

      t.string    :description, :null => false, :limit => 48
      t.string    :comment,     :null => true,  :limit => 256

      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :paths
  end
end
