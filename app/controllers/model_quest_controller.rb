class ModelQuestController < ApplicationController

def step1
end

def step2
  @students = Student.all
  @courses = Course.all
end

def step3
  @enrollments = Enrollment.all
end

def step4
   @students = Student.all 
end

def step5
  @courses_groups = Course.all.map do |course|
    {
      title: course.title,
      # Учитываем только записи со статусом 'active', если поле статус заполнялось корректно, и nil, если человека записывали на курс, а статус не трогали, при записи
      cnt: course.enrollments.where(status: ['active', nil]).count
    }
  end

  @courses_groups.sort_by! { |cg| [cg[:cnt], cg[:title]] }

end
  
 def final
 
  end 
end