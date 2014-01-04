require_relative 'label_maker'
require_relative 'json_cleaner'
require_relative 'caption'

# Represents a single, 2x3 image
class Picture
  LABELDIR = Pathname.new('labels')
  TOPDIR = Pathname.new('top')
  BOTTOMDIR = Pathname.new('bottom')
  attr :jpeg_file, :json_file, :tag_file, :top_file, :comment_file, :bottom_file, :month_file, :number
  def initialize(basename)
    @number = basename.to_i
    [TOPDIR, BOTTOMDIR, LABELDIR].each do |dir|
      dir.mkdir unless dir.exist?
    end
    @jpeg_file = Pathname.new(basename + '.jpg')
    @json_file = Pathname.new(basename + '.json')
    @tag_file = LABELDIR + (basename + '_tags.jpg')
    @comment_file = LABELDIR + (basename + '_caption.jpg')
    @month_file = LABELDIR + (basename + '_month.jpg')
    @top_file = TOPDIR + (basename + '_top.jpg')
    @bottom_file = BOTTOMDIR + (basename + '_bottom.jpg')
  end

  def make_top_file
    build_if_needed(top_file) do
      append_images(top_file, jpeg_file, make_comment_file, make_month_file, make_tag_file)
    end
  end

  def make_bottom_file
    build_if_needed(bottom_file) do
      append_images(bottom_file, make_comment_file, make_month_file, make_tag_file, jpeg_file)
    end
  end

  def append_images(result_file, *images)
    command = %Q{convert -colorspace sRGB #{images.map(&:to_s).join(' ')} -append #{result_file.to_s}}
    puts command
    `#{command}`
  end

  def make_month_file
    build_if_needed(month_file) do
      label_maker.make_month(self)
    end
  end

  def make_tag_file
    build_if_needed(tag_file) do
      label_maker.make_tag(self)
    end
  end

  def make_comment_file
    build_if_needed(comment_file) do
      label_maker.make_comment(self)
    end
  end

  def build_if_needed(file, &block)
    return file if file.exist?
    block.call
    file
  end

  def label_maker
    @label_maker ||= LabelMaker.new(json['created_time'])
  end

  def json
    @json ||= JsonCleaner.clean(json_file)
  end

  def caption
    @caption ||= Caption.new(json['caption'])
  end
end
