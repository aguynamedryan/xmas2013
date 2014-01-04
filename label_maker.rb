require 'time_diff'
require 'rumoji'

# Creates the block of text that can be placed above or below a photo
class LabelMaker
  REF_TIME = Time.parse(ENV['REFDATE'])

  BAD_COMMENTS = %w(
    2
    48
    66
    69
  ).map(&:to_i)

  BAD_TAGS = %w(
    10
    78
    122
    128
  ).map(&:to_i)

  SCRUB_COMMENTS = %w(
    105
    124
  ).map(&:to_i)

  attr :num_months
  def initialize(create_time)
    @num_months  = Time.diff(REF_TIME, Time.at(create_time.to_i), '%M')[:diff].split.first
  end

  def make_comment(picture)
    comment = picture.caption.text || ' '
    comment = break_lines(comment) if BAD_COMMENTS.include?(picture.number)
    comment = scrub_comment(comment) if SCRUB_COMMENTS.include?(picture.number)
    `#{label_command(comment, picture.comment_file)}`
  end

  def make_tag(picture)
    tags = picture.caption.tags
    tag_line = ' '
    tag_line = tags.map{ |w| "##{w}" }.join(' ') unless tags.empty?
    tag_line = break_lines(tag_line) if BAD_TAGS.include?(picture.number)
    `#{label_command(tag_line, picture.tag_file)}`
  end

  def make_month(picture)
    `#{label_command("@#{num_months}m", picture.month_file)}`
  end

  def label_command(words, file)
    words_file = Pathname.new('/tmp/words.txt')
    File.write(words_file.to_s, words)
    height = 306 / 3
    command = %Q{convert -background white -family Verdana -gravity center -size 612x#{height} caption:@#{words_file} #{file.to_s}}
    puts command
    command
  end

  def break_lines(line)
    num_words = line.split.length
    splice = num_words / 3
    line.split.each_slice(splice).map { |s| s.join(' ') }.join("\n")
  end

  def scrub_comment(comment)
    comment = Rumoji.encode(comment)
    puts comment
    comment.gsub(/:heart.+/, '<3').gsub(':blush:', ':-)')
  end
end
