json.error false
json.teams @my_teams do |team|
    json.merge! team.attributes.except(:user_id)
    json.invite_tokens do
        team.users.each do |user| 
            json.child! do
                json.assigned true
                json.username "#{user.first_name} #{user.last_name}"
            end
        end
        (1..(team.no_of_players - team.users.count)).to_a.each do |token| 
            json.child! do
                json.assigned false
                json.token encode_to_jwt({team_id:team.id})
            end 
        end
    end

    json.captain do   
        json.merge! team.captain.attributes.slice("id", "first_name", "last_name", "player_of")
    end  
end