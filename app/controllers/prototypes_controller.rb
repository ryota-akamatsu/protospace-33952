class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!,except:[:index,:show]
  def index

    @prototypes = Prototype.all
    
    
  end

  def new 
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
    
  end
  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
     render :edit
    end
  end

  def destroy
    prototype= Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless  current_user.id == @prototype.user_id
      redirect_to action: :index
      
    end
  end
    def create 
      #binding.pry
      #Prototype.create(prototype_params)
      @prototype = Prototype.new(prototype_params)
      if @prototype.save
        redirect_to  root_path

        else
          render :new
          
        end
    end

    private
    
    def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  
    end
end
