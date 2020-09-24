class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  field :statement, type: String
  field :image, type: String
  field :optionA, type: String
  field :optionB, type: String
  field :optionC, type: String
  field :optionD, type: String
  field :ans, type: String
  field :creator, type: String
  field :category, type: String
  field :continent, type: String
end
