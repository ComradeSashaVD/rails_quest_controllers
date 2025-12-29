class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :grades, dependent: :destroy
  validates :student_id, uniqueness: { scope: :course_id }
end

