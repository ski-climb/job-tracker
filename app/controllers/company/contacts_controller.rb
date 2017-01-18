class Company::ContactsController < ApplicationController

  def create
    @company = find_company(params[:company_id]) if params[:company_id]
    contact = @company.contacts.new(contacts_params)
    if contact.save
      flash[:success] = "#{contact.name} was added as a contact to #{@company.name}"
      redirect_to company_path(@company)
    else
      flash[:danger] = "Contact must have a Name and Email to be valid."
      redirect_to company_path(@company)
    end
  end

  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :position)
  end

end
