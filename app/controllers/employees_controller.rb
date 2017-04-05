class EmployeesController < ApplicationController
  def show
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render "show.html.erb"
  end
end
