class ChallengeRequest < ApplicationRecord
    enum status: [ :pending,:accepted,:rejected]
    belongs_to :requested_to, class_name: 'User', foreign_key: 'request_to'
    belongs_to :requested_from, class_name: 'User', foreign_key: 'request_from'
    after_create do
        body = "#{requested_from.first_name} #{requested_from.last_name} requested to challenge"
        # if status == "accepted"
        #     body =  "#{self.user.first_name} #{self.user.last_name} joined your team"
        # end
        NotificationHelper.send(
            requested_to.devices.pluck(:fcm_token),
            { title: "Challenge Request",body: body, data: {}},
            NotificationHelper.types[:BOOKING_REQUEST_RECIEVED]
        )
    end
end
