class PagesController < ApplicationController
  #layout false
  layout "admin"
  before_action :confirm_logged_in
  
  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:name => "default"})
    @page_count = Page.count
    @subjects = Subject.sorted
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "New Page Created Successfully"
      redirect_to({:action => 'index'})
    else
      @page_count = Page.count
      @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subjects = Subject.sorted
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page Updated Successfully"
      redirect_to({:action => 'show', :id => @page.id})
    else
      @page_count = Page.count
      @subjects = Subject.sorted
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page Destroyed Successfully"
    redirect_to({:action => "index"})
  end

  private
    def page_params
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
    end
end
