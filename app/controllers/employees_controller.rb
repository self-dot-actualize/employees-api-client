class EmployeesController < ApplicationController
  HEADERS = {'X-User-Email' => ENV['API_EMAIL'], 'Authorization' => "Token token=#{ENV['API_KEY']}"}

  def index
    @employees = Unirest.get(
      "#{ENV['API_BASE_URL']}/employees",
      headers: HEADERS
    ).body
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @employee = Unirest.post(
      "#{ENV['API_BASE_URL']}/employees",
      headers: HEADERS,
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
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS
    ).body
    render "show.html.erb"
  end

  def edit
    @employee = Unirest.get(
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS
    ).body
    render "edit.html.erb"
  end

  def update
    @employee = Unirest.patch(
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS,
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
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS
    )
    redirect_to "/employees"
  end
end
