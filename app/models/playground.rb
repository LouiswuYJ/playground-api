class Playground < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true

  scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }
  scope :search_by_address, ->(query) { where("address ILIKE ?", "%#{query}%") }
  scope :search_by_age_group, ->(age_group) { where("age_group ILIKE ?", "%#{age_group}%") }
  scope :near_location, ->(lat, lng, radius_km = 5) {
    where("ST_DWithin(ST_MakePoint(longitude, latitude), ST_MakePoint(?, ?), ?)", lng, lat, radius_km * 1000)
  }

  def self.search(query = nil, age_group = nil, lat = nil, lng = nil, radius_km = 5)
    playgrounds = all

    if query.present?
      playgrounds = playgrounds.search_by_name(query).or(playgrounds.search_by_address(query))
    end

    if age_group.present?
      playgrounds = playgrounds.search_by_age_group(age_group)
    end

    if lat.present? && lng.present?
      playgrounds = playgrounds.near_location(lat, lng, radius_km)
    end

    playgrounds
  end

  def coordinates
    [latitude, longitude] if latitude.present? && longitude.present?
  end

  def amenities_list
    amenities.present? ? JSON.parse(amenities) : []
  rescue JSON::ParserError
    []
  end
end
