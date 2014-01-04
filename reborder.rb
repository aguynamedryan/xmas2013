# CVS and Target both failed to properly print the 4x6 images I generated
# They all came out cropped in various ways
#
# Wrote this in the parking lot of CVS to add a 1/4" border around each image
# to avoid the cropping
#
# Run as INSTAUSER=<instagram_user_name_here> bundle exec ruby reborder.rb
Dir.chdir(ENV['INSTAUSER'] + '_instagram_photos') do
  new_dir = Pathname.new('resized')
  new_dir.mkdir unless new_dir.exist?
  Dir.glob('*.jpg') do |file|
    new_file = new_dir + file
    command = "cp #{file} #{new_file}"
    puts command
    `#{command}`
    {northeast: '76x114', southwest: '76x114'}.each do |direction, border|
      command = %Q{mogrify -splice #{border} -gravity #{direction} #{new_file}}
      puts command
      `#{command}`
    end
  end
end
