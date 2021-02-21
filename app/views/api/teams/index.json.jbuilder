json.error false
json.teams @my_teams do |team|
    json.merge! team.attributes.except(:user_id)
    json.captain do   
        json.merge! team.captain.attributes.slice("id", "first_name", "last_name", "player_of")
    end  
end