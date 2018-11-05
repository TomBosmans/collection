# == Schema Information
#
# Table name: songs
#
#  id         :bigint(8)        not null, primary key
#  item_id    :bigint(8)
#  name       :string
#  duration   :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Song < ApplicationRecord
  belongs_to :item

  attribute :name,     :string
  attribute :duration, :integer, default: 0
end
