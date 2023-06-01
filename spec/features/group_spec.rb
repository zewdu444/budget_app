require 'rails_helper'

RSpec.describe 'Groups', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
      password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Group.create(name: 'Test group', icon:'http://example.com', author_id: @user.id)
     @expense = Expense.create(name: 'Test expense', amount: 100, author_id: @user.id)
      @expense_group = ExpenseGroup.create(expense_id: @expense.id, group_id: @group.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'LOG IN'
  end
  describe 'group page' do
    scenario 'should have a group page' do
        visit  user_groups_path(@user)
        expect(page).to have_content('Add a new category')
      end
    scenario 'should have a name of group' do
        visit  user_groups_path(@user)
        expect(page).to have_content('Test group')
    end
    scenario 'should have a  total amount' do
        visit  user_groups_path(@user)
        expect(page).to have_content(@user.expenses.sum(:amount))
    end
    scenario "when user clicks on add a new category link it will redirect to new group page" do
         visit  user_groups_path(@user)
          click_link 'Add a new category'
          expect(page).to have_content('Choose icon')
    end
  end
  describe 'new group page' do
     scenario  "should have a new group page" do
        visit new_user_group_path(@user)
        expect(page).to have_content('Choose icon')
     end
      scenario "when a user click save button with valid data it will redirect to group page" do
        visit new_user_group_path(@user)
        fill_in 'Name', with: 'Test group'
        click_button 'Save'
        expect(page).to have_content('Choose icon')
      end
  end

end
