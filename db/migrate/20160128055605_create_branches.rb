class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      # Token to identify a register, not unique as it links instance for different users
      t.string "id_token", :null => false
      
    	t.integer "company_id"

			t.string "id_code", :limit => 25
    	t.string "name", :limit => 50, :null => false
    	t.string "email", :default => "@", :null => false
    	
    	t.boolean "pass_active", :default => false
    	t.boolean "acc_active", :default => false

    	t.string "password_digest"
      t.datetime "last_in"

      #t.boolean "is_default", :default => false

      t.string "time_zone"
      t.timestamps null: false
    end
    add_index("branches", "company_id")
    add_index("branches", ["id_token","email"])
  end
end

