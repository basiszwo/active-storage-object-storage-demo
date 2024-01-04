class User < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize: '250x250'
  end
end
