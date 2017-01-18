class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "#{@contact.name} was successfully added as a contact."
      redirect_to contacts_path
    else
      @errors = @contact.errors
      render :new
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :position, :company_id)
    end
end
