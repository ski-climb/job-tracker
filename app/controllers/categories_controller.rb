class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def show
    @category = find_category(params[:id])
  end

  def edit
    @category = find_category(params[:id])
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

  def update
    @category = find_category(params[:id])
    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      @errors = @category.errors
      render :edit
    end
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

    def find_category(id)
      Category.find(id)
    end
end
