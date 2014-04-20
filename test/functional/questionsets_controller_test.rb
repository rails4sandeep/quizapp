require 'test_helper'

class QuestionsetsControllerTest < ActionController::TestCase
  setup do
    @questionset = questionsets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questionsets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create questionset" do
    assert_difference('Questionset.count') do
      post :create, questionset: { answer1: @questionset.answer1, answer2: @questionset.answer2, answer3: @questionset.answer3, answer4: @questionset.answer4, correct: @questionset.correct, question: @questionset.question, weight: @questionset.weight }
    end

    assert_redirected_to questionset_path(assigns(:questionset))
  end

  test "should show questionset" do
    get :show, id: @questionset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @questionset
    assert_response :success
  end

  test "should update questionset" do
    put :update, id: @questionset, questionset: { answer1: @questionset.answer1, answer2: @questionset.answer2, answer3: @questionset.answer3, answer4: @questionset.answer4, correct: @questionset.correct, question: @questionset.question, weight: @questionset.weight }
    assert_redirected_to questionset_path(assigns(:questionset))
  end

  test "should destroy questionset" do
    assert_difference('Questionset.count', -1) do
      delete :destroy, id: @questionset
    end

    assert_redirected_to questionsets_path
  end
end
