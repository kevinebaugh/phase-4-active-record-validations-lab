class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: ['Fiction', 'Non-Fiction'] }
  validate :ensure_click_bait

  private

  def ensure_click_bait
    patterns = [
      /Won't Believe/i,
      /Secret/i,
      /Top \d/i,
      /Guess/i
    ]
    
    if patterns.any?{ |pattern| pattern.match(title) }
      true
    else
      errors.add(:title, "needs to be clickbait")
    end
  end
end
