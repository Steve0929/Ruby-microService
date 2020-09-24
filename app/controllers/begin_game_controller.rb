class BeginGameController < ApplicationController
  before_action  only: [:show]
  # GET /begin_game
  def index
    question_number = 10 #pick 3 questions from db
    category = params[:category]
    continent = params[:continent]
    valid_categories = ["flags","places","maps","color","location","mixed"]
    filter_continent = false

    if valid_categories.include? category
      if params[:continent].present? # Filter questions by continent
         filter_continent = true
      end

      if(category == "mixed")
        mixed_total_number = 15
        if filter_continent == true
          mixed_questions = Question.all.where(continent: continent).sample(mixed_total_number)
          render json: {categoria: "mixed", preguntas: mixed_questions} and return
        else
          mixed_questions = Question.all.sample(mixed_total_number)
          render json: {categoria: "mixed", preguntas: mixed_questions} and return
        end
      end

      if filter_continent == true
        questions = Question.all.where(category: category, continent: continent).sample(question_number)
        render json: {categoria: category, preguntas: questions} and return
      else
        questions = Question.all.where(category: category).sample(question_number)
        render json: {categoria: category, preguntas: questions} and return
      end
    end

    render json: {ERROR: "Ninguna categoria coincide",params: params}
  end

  # GET /begin_game/:category
  def show
    question_number = 10 #pick 3 questions from db

    @category = params[:id]
    if(@category == "bandera")
      flag_questions = Question.all.where(category: 'flags').sample(question_number)
      render json: {categoria: "flags", preguntas: flag_questions, params: params} and return
    end

    if(@category == "lugar")
      place_questions = Question.all.where(category: 'places').sample(question_number)
      render json: {categoria: "places", preguntas: place_questions} and return
    end

    if(@category == "mapa")
       map_questions = Question.all.where(category: 'maps').sample(question_number)
       render json: {categoria: "maps", preguntas: map_questions} and return
    end

    if(@category == "ubicar")
       map_questions = Question.all.where(category: 'location').sample(question_number)
       render json: {categoria: "location", preguntas: map_questions} and return
    end

    if(@category == "colorear")
       render json: {categoria: "color"} and return
    end

    if(@category == "mixed")
      mixed_total_number = 15
      mixed_questions = Question.all.sample(mixed_total_number)
      ##
      #mixed_category_number = mixed_total_number / 3
      #mixed_category_number = mixed_category_number.floor()
      #map_questions = Question.all.sample(question_number)
      #place_questions = Question.all.sample(question_number)
      #flag_questions = Question.all.sample(question_number)
      #mixed_questions = map_questions + place_questions + flag_questions
      ##
      render json: {categoria: "mixed", preguntas: mixed_questions} and return
    end

    render json: {ERROR: "Ninguna categoria coincide",params: params}
  end

end
