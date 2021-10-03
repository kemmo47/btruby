class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:destroy]

  # GET /todos or /todos.json
  def index
    @todos =  if params[:info_id]
                  if params[:info_id] === '0'
                    Todo.all                       
                  else
                    Todo.where( user_id: params[:info_id] )
                  end
              else
                Todo.all
              end       
    # @todos = Todo.where(user_id: current_user.id)
    # @todo = Todo.new
    @todo = current_user.todos.build
    @users = User.all
        
  end

  # def show
  #   @todos = Todo.find(params[:id])
  # end

  # POST /todos or /todos.json
  def create
    # @todo = Todo.new(todo_params)
    @todo = current_user.todos.build(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: "Todo was successfully created." }
        format.js {}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  def correct_user
    @todo = current_user.todos.find_by(id: params[:id])
    redirect_to todos_path, notice: "Not Authorized To Edit This Todo" if @todo.nil?
  end
  
  def infouser_params
    params.require().permit(:info_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:todos_content, :user_id)
    end
end
