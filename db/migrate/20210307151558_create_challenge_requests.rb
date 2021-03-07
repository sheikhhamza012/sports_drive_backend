class CreateChallengeRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :challenge_requests do |t|
      t.integer :request_from
      t.integer :request_to
      t.belongs_to :arena_booking_request
      t.integer :status, default:0
      t.timestamps
    end
  end
end
