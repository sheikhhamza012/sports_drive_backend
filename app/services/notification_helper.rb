require 'fcm'

class NotificationHelper
    @notification_type ={ 
        BOOKING_REQUEST_RECIEVED: 0,
        BOOKING_REQUEST_ACCEPTED: 1
    }
    def self.types
        @notification_type
    end
    def self.send(recipients , msg, type)
        fcm_client = FCM.new(ENV['fcm_server_key']) # set your FCM_SERVER_KEY
        options = { 
            priority: 'high',
            # data: { 
            #     sound: "default",
            #     body:  msg[:data].to_json,
            #     title: msg[:title],
            #     content_available: true,
            #     priority: "high"
            # },
            data: {
                booking_request: msg[:data].as_json,
                type: type
            },
            notification: {
                sound: "default",
                body:  msg[:body],
                title: msg[:title],
                content_available: true,
                priority: "high"
            }
        }
        responses = []
        recipients.each do |to|
            response = fcm_client.send(to, options)
            responses << JSON.parse(response[:body])
            puts "***************"
            puts responses
            puts "***************"
        end
        return responses
    end

end