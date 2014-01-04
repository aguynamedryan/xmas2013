# Stores the text of the caption and the hashtags that are stripped out
class Caption
  # Found this at http://stackoverflow.com/questions/12102746/regex-to-match-hashtags-in-a-sentence-using-ruby
  HASHTAG_REGEXP = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i

  attr :text, :tags
  def initialize(caption)
    @text, @tags = nil, []
    if caption
      @text, @tags = parse_caption(caption['text'])
    end
  end

  def parse_caption(caption)
    text = caption.gsub(HASHTAG_REGEXP, '')
    hashtags = caption.scan(HASHTAG_REGEXP).flatten
    return text, hashtags
  end
end
