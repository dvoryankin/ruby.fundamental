# Unlike to_s, which is supported by almost all classes,
# to_str is normally implemented only by those classes that act like strings.

class ArticleTitle
  def initialize(text)
    @text = text
  end

  def slug
    @text.strip.tr_s("^A-Za-z0-9","-").downcase
  end

  def to_str
    puts 'to_str called'
    @text
  end
end

title = ArticleTitle.new("A Modest Proposal")
# By defining #to_str, ArticleTitle can be used in places Ruby expects
# a String:
puts "Today’s Feature: " + title
# => "to_str called"
# => "Today’s Feature: A Modest Proposal"