class Questionset < ActiveRecord::Base
  attr_accessible :answer1, :answer2, :answer3, :answer4, :correct, :question, :weight
end
