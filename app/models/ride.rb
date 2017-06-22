class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :attraction
  belongs_to :user

  def take_ride
    ticket_flag = enough_tickets?
    height_flag = tall_enough?
    message_start = "Sorry. "

    if !enough_tickets? && !tall_enough?
      message_start + not_enough_tickets_message + " " + not_tall_enough_message
    elsif !enough_tickets?
      message_start + not_enough_tickets_message
    elsif !tall_enough?
      message_start + not_tall_enough_message
    else
      update_user_attributes
    end
  end

  private
    def update_user_attributes
      self.user.tickets -= self.attraction.tickets
      self.user.happiness += self.attraction.happiness_rating
      self.user.nausea += self.attraction.nausea_rating
      self.user.save

      thank_you_for_riding_message
    end

    def enough_tickets?
      self.user.tickets >= self.attraction.tickets
    end

    def tall_enough?
      self.user.height >= self.attraction.min_height
    end

    def not_tall_enough_message
      "You are not tall enough to ride the #{attraction.name}."
    end

    def not_enough_tickets_message
      "You do not have enough tickets to ride the #{attraction.name}."
    end

    def thank_you_for_riding_message
      "Thanks for riding the #{self.attraction.name}!"
    end
end
