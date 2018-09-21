json.extract! post, :id, :tags, :text, :created_at, :updated_at
json.url post_url(post, format: :json)
