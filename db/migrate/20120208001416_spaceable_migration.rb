class SpaceableMigration < ActiveRecord::Migration
  def self.up
    create_table :memories do |t|
      t.references :learner, :polymorphic => true
      t.references :component, :polymorphic => true

      t.decimal :ease,     :default => 2.5
      t.decimal :interval, :default => 1.0
      t.integer :views,    :default => 0
      t.integer :streak,   :default => 0
      t.datetime :last_viewed
      t.datetime :due

      t.timestamps
    end

    add_index :memories, :learner_id
    add_index :memories, :component_id
    add_index :memories, [:learner_id, :component_id], :unique => true

    create_table :memory_ratings do |t|
      t.references :memory
      t.integer :quality
      t.integer :streak
      t.decimal :ease
      t.integer :interval

      t.timestamps
    end

    add_index :memory_ratings, :memory_id
  end

  def self.down
    drop_table :memories
    drop_table :memory_ratings
  end
end
