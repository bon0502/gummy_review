module GummiesHelper
  def display_star_rating(rating)
    "⭐️" * rating + "☆" * (5 - rating)
  end
end
