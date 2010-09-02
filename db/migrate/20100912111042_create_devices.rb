class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.integer   :sensor,  :limit => 3, :default => 0, :null => false
      t.integer   :status,  :limit => 3, :default => 0, :null => false

      t.string    :type,    :null => true
      t.string    :mobile,  :null => true, :limit => 20
      t.string    :brand,   :null => true, :limit => 20
      t.string    :name,    :null => true, :limit => 20

      t.references :user,   :null => false

      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :devices
  end
end
