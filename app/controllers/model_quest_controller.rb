class ModelQuestController < ApplicationController

def step1
end

def step2
  @students = Student.all
  @courses = Course.all
end

def step3
  #@enrollments = Enrollment.all
  @enrollments = Enrollment.includes(:student, :course).all
  #Почему нужен .includes?
  # - Потому что с помощью includes мы не к БД каждый раз обращаемся, а берём предзагружаем данные в хэш, и данном случае всего 3 запросами обходимся
end

def step4
  #@students = Student.all
  @students = Student.includes(:grades).all
end

=begin
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
=end

  def step5
    sql = <<-SQL
    SELECT 
      courses.title,
      -- COUNT считает только НЕ NULL значения enrollments.id
      -- Если запись удовлетворяет условиям в LEFT JOIN, она учитывается
      COUNT(enrollments.id) as cnt
    FROM courses
    --LEFT JOIN означает: "взять ВСЕ курсы, даже если у них нет записей в enrollments"
    --JOIN (INNER JOIN) показал бы только курсы с записями    
    LEFT JOIN enrollments ON enrollments.course_id = courses.id
    --Берутся только записи enrollments, у которых:
    --status IS NULL (никогда не менялся, значит активный)
    --ИЛИ status = 'active' (явно указан как активный)
      AND (enrollments.status IS NULL OR enrollments.status = 'active')
    --Группировка по курсам - обязательна при использовании агрегатных функций (COUNT)
    --Нужно указать ВСЕ неагрегированные поля из SELECT
    GROUP BY courses.id, courses.title
    ORDER BY cnt ASC, courses.title
  SQL

    # Выполнение "сырого" SQL запроса через ActiveRecord
    result = ActiveRecord::Base.connection.execute(sql)

    # Преобразование результата SQL запроса в удобный для Rails формат
    @courses_groups = result.map do |row|
      # Для каждой строки создаем хэш с ключами:
      # :title - название курса (уже в правильном регистре из БД)
      # :cnt - количество активных записей, преобразованное в целое число
      # .to_i нужно потому что из БД значение приходит как строка
      { title: row['title'], cnt: row['cnt'].to_i }
    end
  end

 def final
 
  end 
end