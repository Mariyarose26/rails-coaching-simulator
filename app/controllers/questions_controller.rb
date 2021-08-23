class QuestionsController < ApplicationController
  def home
  end
  def ask
  end

  def answer
    @your_message = params[:question]
    case
    when @your_message == "I am going to work right now!" then @coach_answer = "Great!"
    when @your_message.end_with?("?") == true then @coach_answer = "Silly question, get dressed and go to work!"
    else @coach_answer = "I don't care, get dressed and go to work!"
    end
  end
end
