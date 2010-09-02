class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|

      t.integer :type, :limit => 3, :default => 0, :null => false
      t.text    :content

      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :actions
  end
end
