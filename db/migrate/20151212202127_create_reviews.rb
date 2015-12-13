class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :chef_id, :recipe_id
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
