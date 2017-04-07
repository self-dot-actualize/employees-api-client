class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get(
      "http://localhost:3000/api/v1/employees",
      headers: {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"}
    ).body
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @employee = Unirest.post(
      "http://localhost:3000/api/v1/employees",
      headers: {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"},
      parameters: {
        first_name: params["form_first_name"],
        last_name: params["form_last_name"],
        birthdate: params["form_birthdate"],
        email: params["form_email"],
        ssn: params["form_ssn"]
      }
    ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def show
    @employee = Unirest.get(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"}
    ).body
    render "show.html.erb"
  end

  def edit
    @employee = Unirest.get(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"}
    ).body
    render "edit.html.erb"
  end

  def update
    @employee = Unirest.patch(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"},
      parameters: {
        first_name: params["form_first_name"],
        last_name: params["form_last_name"],
        birthdate: params["form_birthdate"],
        email: params["form_email"],
        ssn: params["form_ssn"]
      }
    ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    @message = Unirest.delete(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"}
    )
    redirect_to "/employees"
  end
end
