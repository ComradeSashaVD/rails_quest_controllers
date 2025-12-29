class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :grades, through: :enrollments

  def add_grade(course, score)
    enrollment = enrollments.find_or_create_by(course: course)
    Grade.create(enrollment: enrollment, score: score)
  end

  def average_grade
    grades = self.grades

    if grades.any?
      grades.average(:score).to_f.round(2)
    else
      0.0
    end
  end

  def finish_course(course)
    enrollment = enrollments.find_by(course: course)
    # Меняем статус вместо удаления
    enrollment&.update(status: 'completed')
  end

end
