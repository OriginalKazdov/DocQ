class Chunk < ApplicationRecord
  belongs_to :document

  validates :position, presence: true
  validates :content, presence: true
end
