require 'json'

# Strip out unneeded metadata
# The metadata came with a lot of extra attributes which I wanted to ignore
# so I could focus on the format of the data I was interested in
module JsonCleaner
  BAD_ATTRIBUTES = %w(
    attribution
    type
    location
    comments
    likes
    filter
    link
    images
    users_in_photo
    from
    user_has_liked
    user
    id
  )

  def self.clean(json_file)
    json = JSON.parse(json_file.read)
    json.delete_if { |k,v| BAD_ATTRIBUTES.include?(k) }
  end
end
