class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # We expect to retrieve all the microposts associated with a given user id in reverse order of creation.
    # This adds an index
    # Rails then creates a multiple key index, which means that Active Record uses both keys at the same time.
    
    add_index :microposts, [ :user_id, :created_at ]
  end
end
