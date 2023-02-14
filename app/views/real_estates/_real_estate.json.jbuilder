json.extract! real_estate, :id, :title, :description, :address, :estate_type, :price, :host_id, :city_id, :created_at, :updated_at
json.url real_estate_url(real_estate, format: :json)
