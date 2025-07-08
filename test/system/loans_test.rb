require "application_system_test_case"

class LoansTest < ApplicationSystemTestCase
  setup do
    @loan = loans(:one)
  end

  test "visiting the index" do
    visit loans_url
    assert_selector "h1", text: "Loans"
  end

  test "should create loan" do
    visit loans_url
    click_on "New loan"

    fill_in "Action", with: @loan.action
    fill_in "Collaborator", with: @loan.collaborator_id
    fill_in "Discard date", with: @loan.discard_date
    fill_in "Discard reason", with: @loan.discard_reason
    fill_in "Equipment", with: @loan.equipment_id
    fill_in "Loan date", with: @loan.loan_date
    fill_in "Return date", with: @loan.return_date
    fill_in "Return reason", with: @loan.return_reason
    click_on "Create Loan"

    assert_text "Loan was successfully created"
    click_on "Back"
  end

  test "should update Loan" do
    visit loan_url(@loan)
    click_on "Edit this loan", match: :first

    fill_in "Action", with: @loan.action
    fill_in "Collaborator", with: @loan.collaborator_id
    fill_in "Discard date", with: @loan.discard_date
    fill_in "Discard reason", with: @loan.discard_reason
    fill_in "Equipment", with: @loan.equipment_id
    fill_in "Loan date", with: @loan.loan_date
    fill_in "Return date", with: @loan.return_date
    fill_in "Return reason", with: @loan.return_reason
    click_on "Update Loan"

    assert_text "Loan was successfully updated"
    click_on "Back"
  end

  test "should destroy Loan" do
    visit loan_url(@loan)
    click_on "Destroy this loan", match: :first

    assert_text "Loan was successfully destroyed"
  end
end
