class Casa < ApplicationRecord
    has_many :fotos, dependent: :destroy
    belongs_to :fotodestaque, class_name: 'Foto', optional: true
  end
  