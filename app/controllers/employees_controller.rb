class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get("http://localhost:3000/api/v1/employees").body
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @employee = Unirest.post(
      "http://localhost:3000/api/v1/employees",
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
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render "show.html.erb"
  end

  def edit
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render "edit.html.erb"
  end

  def update
    @employee = Unirest.patch(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
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
end
