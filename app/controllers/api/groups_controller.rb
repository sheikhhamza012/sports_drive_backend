class Api::GroupsController < ApplicationController 
    before_action :set_group, except: [:create,:search,:search_by_availability]
    def create 

    end
    def show
        render 'show'
    end
    def update
        if @group.update(group_params)
            return render json:{error:false,msg:"Group Updated"}
            
        end
        render json:{error:true,msg:"Could not update the group"}
    rescue Exception=>e
        
        render json:{error:true, msg:e.message}

    end
    
    def search
        @arenas = Arena.where("name ILIKE ? or location ILIKE ?","%#{params[:keyword]}%","%#{params[:keyword]}%")
        render 'index'
    end
    def search_by_availability
        @arenas = Arena.get_available_arenas(params[:location],params[:from_time],params[:to_time])
        render 'index'
    
    rescue Exception=>e
        
        render json:{error:true, msg:e.message}

    end
    

    private

    def set_group
        if params[:id].present?
            @group = Group.find(params[:id])
            authorize @group
        end
    rescue Exception => e
        msg = "Error occured, Try again later"
        if e.class == Pundit::NotAuthorizedError
            msg = "You are not allowed this action"
        end
        puts e
        render json: {error:true, msg: msg}
    end


    def group_params
        params.require(:group).permit(:allow_instant_booking)
    end
end
