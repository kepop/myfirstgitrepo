class SubjectsController < ApplicationController
  #layout false
  layout "admin"
  before_action :confirm_logged_in  

  def index
    @subjects = Subject.sorted  ## using custom scope defined in model Subject
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'default'})
    @subject_count = Subject.count + 1
  end

  def create
    ## Instantiate a new object using form parameters
    # @subject = Subject.new(params[:subject])
    # @subject = Subject.new(params.require(:subject).permit(:name, :position, :visible))
    @subject = Subject.new(subject_params)
    ## Save the object
    if @subject.save == true
      ## If save succeeds, redirect to index page
      flash[:notice] = "New Subject Created Successfully"
      redirect_to({:controller => 'subjects', :action => 'index'})
    else
      ## if save fails, redisplay the form so that users can correct their mistakes.
      ## @subject_count will have to reinitilzed before the page is rendered again.
      ## Question KP : why is that we dont have to initilize @subject again???
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    ## Find existing object using form parameter ID
    @subject = Subject.find(params[:id])
    
    ## Update the object
    if @subject.update_attributes(subject_params) == true
      ## If save succeeds, redirect to index page
      flash[:notice] = "Subject Updated Successfully"
      redirect_to({:controller => 'subjects', :action => 'show', :id => @subject.id})
    else
      ## if update fails, redisplay the form so that users can correct their mistakes.

      ## @subject_count will have to reinitilzed before the page is rendered again.
      ## Question KP : why is that we dont have to initilize @subject again???
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    ## Find existing object using form parameter ID
    subject = Subject.find(params[:id])
    subject.destroy
    
    flash[:notice] = "Subject '#{subject.name}' Destroyed Successfully"
    redirect_to({:controller => 'subjects', :action => 'index'})
  end

  private
    def subject_params
      # Same as using "params[:subject]", except that it:
      #   - It raises an error if :subject is not available
      #   - Allows only listed parameters to be mass assigned
      params.require(:subject).permit(:name, :position, :visible, :created_at  )
    end
end
