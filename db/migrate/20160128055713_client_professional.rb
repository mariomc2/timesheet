class ClientProfessional < ActiveRecord::Migration
  def change
  	create_table :clients_professionals, :id => false do |t|
    	t.integer "client_id"
    	t.integer "professional_id"
    end
    add_index :clients_professionals, ["client_id", "professional_id"]
  end
end
