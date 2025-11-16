class CreateCasas < ActiveRecord::Migration[7.1]
  def change
    create_table :casas do |t|
      t.string :titulo
      t.text :descricao
      t.float :rating
      t.string :localizacao

      t.timestamps
    end
  end
end
