require "test_helper"

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get loans_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_url
    assert_response :success
  end

  test "should create loan" do
    assert_difference("Loan.count") do
      post loans_url, params: { loan: { action: @loan.action, collaborator_id: @loan.collaborator_id, discard_date: @loan.discard_date, discard_reason: @loan.discard_reason, equipment_id: @loan.equipment_id, loan_date: @loan.loan_date, return_date: @loan.return_date, return_reason: @loan.return_reason } }
    end

    assert_redirected_to loan_url(Loan.last)
  end

  test "should show loan" do
    get loan_url(@loan)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_url(@loan)
    assert_response :success
  end

  test "should update loan" do
    patch loan_url(@loan), params: { loan: { action: @loan.action, collaborator_id: @loan.collaborator_id, discard_date: @loan.discard_date, discard_reason: @loan.discard_reason, equipment_id: @loan.equipment_id, loan_date: @loan.loan_date, return_date: @loan.return_date, return_reason: @loan.return_reason } }
    assert_redirected_to loan_url(@loan)
  end

  test "should destroy loan" do
    assert_difference("Loan.count", -1) do
      delete loan_url(@loan)
    end

    assert_redirected_to loans_url
  end
end
