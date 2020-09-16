class Movie < ApplicationRecord

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, inclusion: { in: RATINGS }

  has_many :reviews, dependent: :destroy

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

  def self.released
    where("released_on < ?", Time.now).order("released_on desc")
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end


end
