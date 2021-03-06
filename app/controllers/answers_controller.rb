class AnswersController < ApplicationController
  def vote
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.upvote()
    @firstContent = @question.answers.order("id asc")[0].content
    @secondContent = @question.answers.order("id asc")[1].content
    @firstVal = @question.answers.order("id asc")[1].votes
    @secondVal = @question.answers.order("id asc")[0].votes
    respond_to do |format|
      format.html {redirect_to questions_path}
      format.js
    end
  end
  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end
  def edit
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
  end
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      flash[:notice] = "Answer saved successfully"
      respond_to do |format|
        format.html {redirect_to question_path(@question)}
        format.js
      end
    else
      flash[:alert] = "Answer failed to save"
      render :new
    end
  end
  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.update(answer_params)
    flash[:notice] = "answer updated successfully"
    redirect_to question_path(@question)
  end
  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if @answer.delete
      flash[:notice] = "Answer deleted"
      redirect_to question_path(@question)
    else
      flash[:alert] = "Answer failed to delete"
    end
  end
  private
  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end
end
