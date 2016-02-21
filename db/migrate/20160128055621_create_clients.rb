class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
        # Token to identify a register, not unique as it links instance for different users
        t.string "id_token", :null => false

    	t.integer "company_id"
    	t.integer "branch_id"

    	t.string "id_code", :limit => 25
    	t.string "first_name", :limit => 50, :null => false
    	t.string "last_name", :limit => 50, :null => false
    	t.date "dob", :null => false
    	t.string "email", :default => "@"

    	t.string "photo"

        t.boolean "default", :default => false

      t.timestamps null: false
    end
    add_index("clients", "company_id")
    add_index("clients", "branch_id")
    add_index("clients", "dob")
    add_index("clients", ["id_token","email"])
    add_index("clients", "first_name")
    add_index("clients", "last_name")
  end
end
