class AddFotoDestaqueToCasas < ActiveRecord::Migration[7.1]
  def change
    add_column :casas, :foto_destaque, :string
  end
end
