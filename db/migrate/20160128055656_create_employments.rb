class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
    	t.integer "company_id"
    	t.integer "professional_id"

    	t.boolean "validated", :default => false

      t.timestamps null: false
    end
    add_index :employments, ["company_id", "professional_id"]
  end
end
