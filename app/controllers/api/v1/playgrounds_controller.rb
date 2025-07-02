class Api::V1::PlaygroundsController < ApplicationController
  def index
    playgrounds = Playground.all
    render json: {
      status: 'success',
      data: playgrounds.map { |playground| playground_json(playground) }
    }
  end

  def show
    playground = Playground.find(params[:id])
    render json: {
      status: 'success',
      data: playground_json(playground)
    }
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: 'error',
      message: 'Playground not found'
    }, status: :not_found
  end

  def search
    query = params[:q]
    age_group = params[:age_group]
    lat = params[:lat]&.to_f
    lng = params[:lng]&.to_f
    radius_km = params[:radius_km]&.to_f || 5

    playgrounds = Playground.search(query, age_group, lat, lng, radius_km)

    render json: {
      status: 'success',
      data: playgrounds.map { |playground| playground_json(playground) },
      meta: {
        total_count: playgrounds.count,
        query: query,
        age_group: age_group,
        location: lat && lng ? { lat: lat, lng: lng, radius_km: radius_km } : nil
      }
    }
  end

  private

  def playground_json(playground)
    {
      id: playground.id,
      name: playground.name,
      address: playground.address,
      description: playground.description,
      coordinates: playground.coordinates,
      amenities: playground.amenities_list,
      age_group: playground.age_group,
      opening_hours: playground.opening_hours,
      contact_info: playground.contact_info,
      created_at: playground.created_at,
      updated_at: playground.updated_at
    }
  end
end
