class Farm < ApplicationRecord
    has_many :farmers, dependent: :destroy

    accepts_nested_attributes_for :farmers, allow_destroy: true
end
