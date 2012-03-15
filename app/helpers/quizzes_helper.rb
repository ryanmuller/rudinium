module QuizzesHelper
  def quizzify(quiz_content)
    quiz_content.gsub('####', '<div class="blank">&nbsp;</div>').gsub(/##(.+?)##/, '<span class="blank">\1</span>').html_safe
  end
end

