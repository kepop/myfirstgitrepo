class SectionsController < ApplicationController
  #layout false
  layout "admin"
  before_action :confirm_logged_in  


  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:name => 'default', :content_type => 'text'})
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice]="Section Created Successfully"
      redirect_to({:action=>'index'})
    else
      @section_count = Section.count
      @pages = Page.sorted
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def update
    @section = Section.find(params[:id])    
    if @section.update_attributes(section_params)
      flash[:notice]="Section Updated Successfully"
      redirect_to({:action=>'show', :id => @section.id})
    else
      @section_count = Section.count
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice]="Section Destroyed Successfully"
    redirect_to({:action=>'index'})
  end

  private
    def section_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end
end
