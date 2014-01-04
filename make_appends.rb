# This script gernates the 4x6 pictures which are the final product
require_relative 'picture'
require_relative 'mega_picture'
require 'pp'

Dir.chdir(ENV['INSTAUSER'] + '_instagram_photos') do
  pictures = (0..200).map do |number|
    picture = Picture.new(sprintf("%04d", number))
    next unless picture.jpeg_file.exist?
    picture
  end.compact
  pictures.each_slice(4).each_with_index do |pics, index|
    MegaPicture.new(pics, index).make
    pics.each(&:make_bottom_file)
    pics.each(&:make_top_file)
  end
end
