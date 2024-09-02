class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.string :description
      t.string :start_address
      t.string :destination_name
      t.string :destination_address

      t.timestamps
    end
  end
end
