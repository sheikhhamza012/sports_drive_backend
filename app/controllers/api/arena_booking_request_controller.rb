
class Api::ArenaBookingRequestController < ApplicationController 
    before_action :set_field, only:[:index]
    before_action :set_arena_booking_request,only:[:destroy,:order_detail,:update]
    def index
        if params[:field_id].present?
            @requests = @field.arena_booking_requests.where(from_time:Date.parse(params[:date]).all_day).where('status = 1 or status = 3')
            @active_request=nil
        else
            @requests = current_user.arena_booking_requests.where('status < 3')
            @active_request = @requests.where('(from_time >= ? or to_time > ?)', Time.now, Time.now).order(:from_time).first
        end
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end

    def update
        if @arena_booking_request.update(arena_booking_request_params)
            render json:{error: false, msg: "Request Accepted"}
            return
        end
        render json:{error: true, msg: "Error occured"}
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end

    def order_detail
        
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end



    def my_orders
        @requests = []
        current_user.arena.groups.map do |group|
            group.fields.map do |field|
                field.arena_booking_requests.where(status: 1).map do |request|
                    @requests << {request:request, user: request.user, field:field}
                end
            end 
        end
        render json:{error:false,requests:@requests}
    end
    
    def pending_requests
        @requests = []
        current_user.arena.groups.map do |group|
            group.fields.map do |field|
                field.arena_booking_requests.where(status: 0).where('to_time > ?', Time.now).map do |request|
                    @requests << {request:request, user: request.user, field:field}
                end
            end 
        end
        render json:{error:false,requests:@requests}
    end
   
    def my_earning
        field_ids = []
        current_user.arena.groups.map do |group|
            field_ids |= group.fields.pluck(:id)
        end
        requests1 = ArenaBookingRequest.where('field_id in (?) and status in (?)', field_ids,[1,3]).where(from_time:6.months.ago.beginning_of_month..6.months.ago.end_of_month)
        requests2 = ArenaBookingRequest.where('field_id in (?) and status in (?)', field_ids,[1,3]).where(from_time:5.months.ago.beginning_of_month..5.months.ago.end_of_month)
        requests3 = ArenaBookingRequest.where('field_id in (?) and status in (?)', field_ids,[1,3]).where(from_time:4.months.ago.beginning_of_month..4.months.ago.end_of_month)
        requests4 = ArenaBookingRequest.where('field_id in (?) and status in (?)', field_ids,[1,3]).where(from_time:3.months.ago.beginning_of_month..3.months.ago.end_of_month)
        requests5 = ArenaBookingRequest.where('field_id in (?) and status in (?)', field_ids,[1,3]).where(from_time:2.months.ago.beginning_of_month..2.months.ago.end_of_month)
        requests6 = ArenaBookingRequest.where('field_id in (?) and status in (?)', field_ids,[1,3]).where(from_time:1.months.ago.beginning_of_month..1.months.ago.end_of_month)
        render json:{
            error:false, data:[
                {total: requests1.sum(:price), commission: current_user.vendor_detail.commission.to_f, month:6.months.ago.beginning_of_month.month,year:6.months.ago.beginning_of_month.year },
                {total: requests2.sum(:price), commission: current_user.vendor_detail.commission.to_f, month:5.months.ago.beginning_of_month.month,year:6.months.ago.beginning_of_month.year },
                {total: requests3.sum(:price), commission: current_user.vendor_detail.commission.to_f, month:4.months.ago.beginning_of_month.month,year:6.months.ago.beginning_of_month.year },
                {total: requests4.sum(:price), commission: current_user.vendor_detail.commission.to_f, month:3.months.ago.beginning_of_month.month,year:6.months.ago.beginning_of_month.year },
                {total: requests5.sum(:price), commission: current_user.vendor_detail.commission.to_f, month:2.months.ago.beginning_of_month.month,year:6.months.ago.beginning_of_month.year },
                {total: requests6.sum(:price), commission: current_user.vendor_detail.commission.to_f, month:1.months.ago.beginning_of_month.month,year:6.months.ago.beginning_of_month.year }
            ]
        }
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end
    def destroy
        if @arena_booking_request.delete
            render json:{error: false, msg: "Deleted successfully"}
        end
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end
    def get_active_request
        @request = current_user.arena_booking_requests.where('status < 2 ').where('from_time >= ? or to_time > ?', Time.now, Time.now).order(:from_time).first
        render 'show'
    rescue Exception=>e
        render json:{error: true, msg: e.message}
    end
    private
    def set_field 
        if params[:field_id].present?
            @field=Field.find(params[:field_id])
        end
    end
    def set_arena_booking_request
        if params[:id].present?
            @arena_booking_request=ArenaBookingRequest.find(params[:id])
        end
    end
    def arena_booking_request_params
        params.require(:arena_booking_request).permit(:from_time,:to_time,:status)
    end
end
