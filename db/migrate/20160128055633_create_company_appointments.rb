class CreateCompanyAppointments < ActiveRecord::Migration
  def change
    create_table :company_appointments do |t|
    	t.integer "company_id"
    	t.integer "branch_id"
    	t.integer "professional_id"
    	t.integer "client_id"
        t.integer "professional_appointment_id"

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
    add_index("company_appointments", "company_id")
    add_index("company_appointments", "branch_id")
    add_index("company_appointments", "professional_id")
    add_index("company_appointments", "client_id")
    add_index("company_appointments", "date_time")

    add_index("company_appointments", "professional_appointment_id")
  end
end
