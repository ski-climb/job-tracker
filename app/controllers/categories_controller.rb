class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def show
    @category = find_category(params[:id])
    @jobs = @category.jobs
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

  def destroy
    category = find_category(params[:id])
    category.jobs.destroy_all
    category.delete
    flash[:success] = "#{category.title} and all associated jobs for #{category.title} were successfully deleted!"
    redirect_to categories_path
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

    def find_category(id)
      Category.find(id)
    end
end
