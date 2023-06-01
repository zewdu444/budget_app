class ExpensesController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @group = Group.find(params[:group_id])
    @expenses = @group.expenses.order(created_at: :desc)
  end

  def new
    @expense = current_user.expenses.new
    @group = Group.find(params[:group_id])
  end

  def create
    @expense = current_user.expenses.new(name: expense_params[:name], amount: expense_params[:amount])

    if @expense.save
      @expense_group = ExpenseGroup.new(expense_id: @expense.id, group_id: params[:expense][:group_id])

      if @expense_group.save
        redirect_to user_group_expenses_path(current_user, params[:expense][:group_id]),
                    notice: 'Expense created successfully'
      end
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit!
  end
end
