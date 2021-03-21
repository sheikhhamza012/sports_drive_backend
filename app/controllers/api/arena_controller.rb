class Api::ArenaController < ApplicationController 
    before_action :set_arena, except: [:create,:search,:search_by_availability,:my_arenas]
    def create 

    end
    def show
        render 'show'
    end
    def my_arenas
        @arena = current_user.arena
        render 'show'
    end
    def update
        if @arena.update(arena_params)
            if params[:arena][:images]
                if @arena.update(images: params[:arena][:images])
                    render json: {error:false, images: @arena.images.map(&:url)}
                    return
                end
                render json: {error:true, msg: "Images Not Updated"}
            end
            render json: {error:false}
            return
        end
        render json: {error:true, msg: "Something went wrong"}
        return
    rescue Exception=>e
        
        render json:{error:true, msg:e.message}

    end
    def search
        @arenas = Arena.joins("left join groups on arenas.id = groups.arena_id where groups.name = '#{params[:group_name]}' and (arenas.name ILIKE '%#{params[:keyword]}%' or arenas.location ->> 'address' ILIKE '%#{params[:keyword]}%')")
        render 'index'
    end
    def search_by_availability
        @arenas = Arena.get_available_arenas(params[:location], params[:from_time], params[:to_time], params[:group_name])
        render 'index' 
    
    rescue Exception=>e
        
        render json:{error:true, msg:e.message}

    end
    def availibility
        render 'show'
    rescue Exception=>e    
        render json:{error:true, msg:e.message}
    end
    private

    def set_arena
        @arena = Arena.find(params[:id])
        authorize @arena
    rescue Exception => e      
        msg = "Error occured, Try again later"
        if e.class == Pundit::NotAuthorizedError
            msg = "You are not allowed this action"
        end
        puts e
        render json: {error:true, msg: msg}
    end


    def arena_booking_request_params
        params.require(:arena_booking_request).permit(:from_time,:to_time)
    end
    def arena_params
        params.require(:arena).permit()
    end
end
