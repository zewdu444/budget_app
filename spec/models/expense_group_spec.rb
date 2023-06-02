require 'rails_helper'

RSpec.describe ExpenseGroup, type: :model do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Group.create(name: 'Test group', icon: 'http://example.com', author_id: @user.id)
    @expense = Expense.create(name: 'Test expense', amount: 100, author_id: @user.id)
    @expense_group = ExpenseGroup.create(expense_id: @expense.id, group_id: @group.id)
  end
  it 'is valid with valid attributes' do
    expect(@expense_group).to be_valid
  end
  it 'is not valid without an expense_id' do
    @expense_group.expense_id = nil
    expect(@expense_group).to_not be_valid
  end
  it 'is not valid without a group_id' do
    @expense_group.group_id = nil
    expect(@expense_group).to_not be_valid
  end
end
