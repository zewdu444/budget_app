require 'rails_helper'

RSpec.describe 'Expenses', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Group.create(name: 'Test group', icon: 'http://example.com', author_id: @user.id)
    @expense = Expense.create(name: 'Test expense', amount: 100, author_id: @user.id)
    @expense_group = ExpenseGroup.create(expense_id: @expense.id, group_id: @group.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'LOG IN'
  end
  describe 'Expense detail page' do
    scenario 'should have a expense detail page' do
      visit user_group_expenses_path(@user, @group)
      expect(page).to have_content(@group.name)
    end
    scenario 'should have a expense total' do
      visit user_group_expenses_path(@user, @group)
      expect(page).to have_content(@group.expenses.sum(:amount))
    end
    scenario 'should have add new expense link' do
      visit user_group_expenses_path(@user, @group)
      expect(page).to have_content('Add a new transaction')
    end
    scenario 'When user click add a new transaction button will redirect to transaction new page' do
      visit user_group_expenses_path(@user, @group)
      click_link 'Add a new transaction'
      expect(page).to have_content('ADD NEW TRANSACTIONS')
    end
  end
  describe 'Expense new page' do
    scenario 'should have a expense new page' do
      visit new_user_group_expense_path(@user, @group)
      expect(page).to have_content('ADD NEW TRANSACTIONS')
    end
    scenario 'when user click save button with valid data it will redirect to expense detail page' do
      visit new_user_group_expense_path(@user, @group)
      fill_in 'Name', with: 'Test expense'
      fill_in 'Amount', with: 100
      select 'Test group', from: 'expense[group_id]'
      click_button 'Save'
      expect(page).to have_content('Add a new transaction')
    end
  end
end
