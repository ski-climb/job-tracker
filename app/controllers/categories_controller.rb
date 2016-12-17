class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category, #{@category.title}, was successfully created!"
      redirect_to category_path(@category)
    else
      @errors = @category.errors
      render :new
    end
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end
end
