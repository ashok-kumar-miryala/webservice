class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :description
      t.string :title
      t.string :name
      t.string :phone
      t.text :fax
      t.string :email
      t.string :created_by

      t.timestamps
    end
  end
end
