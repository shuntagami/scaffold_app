class Task < ApplicationRecord
  # before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validates :deadline, presence: true
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }
  scope :priority, -> { order(deadline: :asc) }
  scope :to_do, -> { where(completed: 0) }
  scope :in_progress, -> { where(completed: 1) }
  scope :done, -> { where(completed: 2) }


  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  # def set_nameless_name
  #   self.name = '名前なし' if name.blank?
  # end
end