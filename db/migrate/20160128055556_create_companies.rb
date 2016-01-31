class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string "id_code", :limit => 25
    	t.string "name", :limit => 50, :null => false
    	t.string "email", :default => "@", :null => false
    	
    	t.boolean "pass_active", :default => false
    	t.boolean "acc_active", :default => false

    	t.string "password_digest"
      t.datetime "last_in"

      t.timestamps null: false
    end
    add_index("companies", "email")
  end
end
