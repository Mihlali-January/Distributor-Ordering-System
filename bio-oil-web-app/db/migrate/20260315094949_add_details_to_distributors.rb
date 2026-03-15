class AddDetailsToDistributors < ActiveRecord::Migration[8.0]
  def change
    add_column :distributors, :distributor_code, :string
    add_index :distributors, :distributor_code
    add_column :distributors, :contact_name, :string
    add_column :distributors, :contact_email, :string
    add_column :distributors, :contact_phone, :string
    add_column :distributors, :address, :text
    add_column :distributors, :tax_number, :string
    add_column :distributors, :active, :boolean
  end
end
