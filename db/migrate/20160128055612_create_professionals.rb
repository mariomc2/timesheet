class CreateProfessionals < ActiveRecord::Migration
  def change
    create_table :professionals do |t|
			t.string "id_code", :limit => 25
    	t.string "first_name", :limit => 50, :null => false
    	t.string "last_name", :limit => 50, :null => false
    	t.date "dob", :null => false
    	t.string "email", :default => "@", :null => false

    	t.string "speciality", :limit => 25
    	
    	t.boolean "pass_active", :default => false
    	t.boolean "acc_active", :default => false

    	t.string "password_digest"
        t.datetime "last_in"

      t.timestamps null: false
    end
    add_index("professionals", "dob")
    add_index("professionals", "email")
  end
end
