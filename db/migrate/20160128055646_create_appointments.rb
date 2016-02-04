class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|

    	t.integer "company_id"
    	t.integer "branch_id"
    	t.integer "professional_id"
    	t.integer "client_id"

      t.boolean "shared", :default => false

    	t.datetime "date_time", :null => false

       t.string "status"
       t.string "photo"

       t.string "task_type", :limit => 50
       t.text "task_note"

    	t.float "total_project_price"
      t.float "task_payment"
    	t.float "professional_fee"
      t.float "remaining_project_payment"

    	t.boolean "needs_folloup", :default => false

      t.timestamps null: false
    end
    add_index("appointments", "company_id")
    add_index("appointments", "branch_id")
    add_index("appointments", "professional_id")
    add_index("appointments", "client_id")
    add_index("appointments", "date_time")
  end
end
