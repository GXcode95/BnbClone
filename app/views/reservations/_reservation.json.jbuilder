json.extract! reservation, :id, :checkin, :checkout, :real_estate_id, :guest_id, :validated, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
