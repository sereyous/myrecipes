class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :summary, :description
      t.integer :chef_id
      t.timestamps
    end
  end
end
