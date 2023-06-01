require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  include Devise::Test::IntegrationHelpers # Include Devise test helpers
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Group.create(name: 'Test group', icon: 'http://example.com', author_id: @user.id)
    @expense = Expense.create(name: 'Test expense', amount: 100, author_id: @user.id)
    @expense_group = ExpenseGroup.create(expense_id: @expense.id, group_id: @group.id)
    sign_in @user
  end
  describe 'GET /expenses' do
    it 'returns http success' do
      get user_group_expenses_path(user_id: @user.id, group_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the index template' do
      get user_group_expenses_path(user_id: @user.id, group_id: @group.id)
      expect(response).to render_template('index')
    end
    it 'displays the expense name' do
      get user_group_expenses_path(user_id: @user.id, group_id: @group.id)
      expect(response.body).to include('Transaction')
    end
  end
  describe 'GET /expenses/new' do
    it 'returns http success' do
      get new_user_group_expense_path(user_id: @user.id, group_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_group_expense_path(user_id: @user.id, group_id: @group.id)
      expect(response).to render_template('new')
    end
    it 'displays the new expense form' do
      get new_user_group_expense_path(user_id: @user.id, group_id: @group.id)
      expect(response.body).to include('NEW TRANSACTION')
    end
  end
end
