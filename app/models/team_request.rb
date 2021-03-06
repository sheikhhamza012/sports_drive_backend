class TeamRequest < ApplicationRecord
    belongs_to :team
    belongs_to :user
    enum status: [ :pending,:accepted,:rejected]
    after_create do
        body = "#{self.user.first_name} #{self.user.last_name} requested to joined your team"
        if status == "accepted"
            body =  "#{self.user.first_name} #{self.user.last_name} joined your team"
        end
        NotificationHelper.send(
            team.captain.devices.pluck(:fcm_token),
            { title: "Team Join Request",body: body, data: {}},
            NotificationHelper.types[:BOOKING_REQUEST_RECIEVED]
        )
    end
end
