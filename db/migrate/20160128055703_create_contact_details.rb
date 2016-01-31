class CreateContactDetails < ActiveRecord::Migration
  def change
  	create_table :contact_details do |t|
      t.integer "company_id"
      t.integer "branch_id"
      t.integer "professional_id"
      t.integer "client_id"
      
      t.string "address_type"
    	t.string "address"
    	t.string "city"
    	t.string "state"
    	t.string "country"

    	t.string "tel"

    	t.boolean "validated", :default => false

      t.timestamps null: false
    end
    add_index("contact_details", "company_id")
    add_index("contact_details", "branch_id")
    add_index("contact_details", "professional_id")
    add_index("contact_details", "client_id")
  end
end
