class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    #check if is a valid category
    valid_categories = ["flags","places","maps","color","location"]
    if valid_categories.include? params[:category]
      @question = Question.new(question_params)
      if @question.save
        render json: @question, status: :created, location: @question and return
      else
        render json: @question.errors, status: :unprocessable_entity and return
      end
    else
      render json: {Error: "Invalid category", sended: params[:category]}
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:statement, :image, :optionA, :optionB, :optionC, :optionD, :ans, :creator, :category, :continent)
    end
end
