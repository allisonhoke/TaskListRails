require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  test "If a user is not logged in they cannot see their task." do
      session[:user_id] = nil  # ensure no one is logged in

      get :show, id: tasks(:sample_task).id
      # if they are not logged in they cannot see the resource and are redirected to login.
      assert_redirected_to root_path
      assert_equal "You must be logged in to view this section", flash[:error]
  end

  test "a user cannot edit/update a task that does not belong to them" do
    task = tasks(:task_two) #this task belongs to user with id of 2
    login_a_user

    patch :update, id: task.id
    assert_redirected_to root_path
  end

  test "a logged in user will see exactly their tasks" do
    session[:user_id] = users(:user_one).id

    get :index
    assert_response :success
    assert_template :index

    tasks = assigns(:all_the_tasks)
    assert_equal tasks.length, users(:user_one).tasks.length
    tasks.each do |task|
      assert_include users(:user_one).tasks, task
    end
  end
  
# REVIEW: how to test that a task belongs to the current user
  # test "a new task will belong to the current user" do
  #   login_a_user
  #   session[:user_id] = users(:user_one).id
  #   task = Task.create(title: "Clean", description: "Do it")
  #
  #   assert_difference(Task.where(user_id: session[:user_id]), 1) do
  #     post :create, task
  #     assert_redirected_to tasks_path
  #   end
  # end
end
