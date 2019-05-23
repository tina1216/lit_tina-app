class CreateAllTables < ActiveRecord::Migration[5.2]
	def change



		create_table :users do |t|
			t.string :mail
			t.string :password_digest
			t.string :user_name
			t.string :profile_img
			t.timestamps null: false
		end


    create_table :contributions do |t|
      t.integer :coffee_taste
      t.integer :food_variation
      t.integer :for_working
      t.string :text
      t.string :image
      t.integer :wifi
      t.integer :charger
      t.string :shopname
      t.integer :user_id
      t.boolean :laidback
      t.boolean :dark
      t.boolean :light
      t.boolean :lively
      t.boolean :quiet
      t.boolean :station
      t.boolean :bitwalk
      t.boolean :farsta
      t.boolean :hidden
      t.boolean :town
      t.timestamps null: false
		end


		create_table :goods do |t|
			t.integer :user_id
			t.integer :contribution_id
			t.timestamps null: false
		end

  end
end
