# Given a set of 4 pictures, creates a 4x6 image by tiling the pictures
class MegaPicture
  BIGDIR = Pathname.new('big')
  TALLDIR = Pathname.new('tall')
  attr :pictures, :number

  def initialize(pictures, number)
    @pictures = pictures
    @number = number
  end

  def make
    BIGDIR.mkdir unless BIGDIR.exist?
    TALLDIR.mkdir unless TALLDIR.exist?

    assemble('/tmp/t1.jpg', true, pictures[0..1].map(&:make_top_file))
    assemble('/tmp/t2.jpg', true, pictures[2..3].map(&:make_bottom_file))
    assemble(result_file, false, '/tmp/t1.jpg', '/tmp/t2.jpg')
  end

  def assemble(file, verticle, *pictures)
    switch = verticle ? '-' : '+'
    switch += 'append'
    command = %Q{convert -colorspace sRGB #{pictures.flatten.map(&:to_s).join(' ')} #{switch} #{file}}
    puts command
    `#{command}`
  end

  def result_file
    BIGDIR + sprintf('%02d.jpg', number)
  end
end
