class CreateFotos < ActiveRecord::Migration[7.1]
  def change
    create_table :fotos do |t|
      t.references :casa, null: false, foreign_key: true
      t.string :imagem

      t.timestamps
    end
  end
end
