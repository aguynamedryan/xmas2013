# downstagram is awesome, but it uses the long, obscure hexnames that instagram gives
# each photo.  This script simply renames those photos to a 0-padded, 4 digit number starting
# at 1 so that my eyes didn't bleed as I looked over photos being generated
require 'pathname'
require_relative 'json_cleaner'

Dir.chdir(ENV['INSTAUSER'] + '_instagram_photos') do
  Dir.glob("*.json").sort_by do |json|
    JsonCleaner.clean(Pathname.new(json))['created_time'].to_i
  end.each_with_index do |json, index|
    next unless json.length > 10
    json = Pathname.new(json)
    new_json = sprintf("%04d.json", index)
    new_jpeg = sprintf("%04d.jpg", index)
    old_json = json.basename('.*').to_s + '.json'
    old_jpeg = json.basename('.*').to_s + '.jpg'
    puts "#{old_json} => #{new_json}"
    Pathname.new(old_json).rename(new_json)
    puts "#{old_jpeg} => #{new_jpeg}"
    Pathname.new(old_jpeg).rename(new_jpeg)
  end
end
