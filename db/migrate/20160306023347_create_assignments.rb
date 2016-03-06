class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
    	t.integer "appointment_id"
    	t.integer "professional_id"

    	t.float "professional_fee"

    	t.text "note"

      t.timestamps null: false
    end
    add_index :assignments, ["appointment_id", "professional_id"]
  end
end
