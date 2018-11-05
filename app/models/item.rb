# == Schema Information
#
# Table name: items
#
#  id          :bigint(8)        not null, primary key
#  parent_id   :bigint(8)
#  name        :string
#  description :string
#  type        :string
#  format      :string
#  fields      :jsonb
#  released_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ApplicationRecord
  TYPES = %w[album ep bootleg].freeze  
  FORMATS = %w[cd cd-r vinyl cassette].freeze

  belongs_to :parent, class_name: 'Item'

  has_many   :items, foreign_key: 'parent_id'
  has_many   :songs

  scope :root_items, -> { where(parent_id: nil) }
  # Type scopes
  scope :albums,     -> { where(type: 'album') }
  scope :eps,        -> { where(type: 'ep') }
  scope :bootlegs,   -> { where(type: 'bootleg') }
  # Format scopes
  scope :cds,        -> { where(format: 'cd') }
  scope :cdrs,       -> { where(format: 'cd-r') }
  scope :vinyls,     -> { where(format: 'vinyl') }
  scope :cassettes,  -> { where(format: 'cassette') }

  validates :format, inclusion: { in: FORMATS }
  validates :type,   inclusion: { in: TYPES }

  attribute :name,        :string
  attribute :description, :string
  attribute :type,        :string
  attribute :format,      :string
  attribute :released_at, :datetime
  attribute :duration,    :integer

  def duration
    songs.inject(0) do |duration, song|
      duration += song.duration
      duration
    end
  end

  def parent?
    items.present?
  end

  def root?
    parent_id.nil?
  end

  def released?
    released_at <= DateTime.now
  end

  def allowed_types
    TYPES
  end

  def allowed_formats
    FORMATS
  end
end
