class TopicsController < ApplicationController
  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)# equals Topic.all - call paginate on collection of topics and dictate how pagination will render
    authorize @topics
  end
  
  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page:params[:page], per_page: 10)
    authorize @topic
  end

  def new
    @topic = Topic.new
    authorize @topic
  end
  
  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end
  
  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Topic was saved." #why not use flash[:notice]
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(topic_params)
      redirect_to @topic  
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    
    if @topic.destroy
      flash[:notice] = "The topic - #{@topic.name} -  was successfully deleted ."
      redirect_to @topic
    else
      flash[:error] = "There was a error deleting the topic. Please try again."
      render:show
    end
  end
  
  
  private
  
  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end
