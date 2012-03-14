module QuizzesHelper
  def quizzify(quiz_content)
    quiz_content.gsub('####', '<div class="blank">&nbsp;</div>').html_safe
  end
end

