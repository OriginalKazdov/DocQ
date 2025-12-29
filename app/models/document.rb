class Document < ApplicationRecord
  has_one_attached :file

  enum status: {
    uploaded: 0,
    processing: 1,
    ready: 2,
    failed: 3
  }

  validates :title, presence: true
end
