class Foto < ApplicationRecord
  belongs_to :casa

  # Se quiser validar a presença da imagem:
  validates :imagem, presence: true
end