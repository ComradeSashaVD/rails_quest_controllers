# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

a = Student.create(name: 'Anthony')
b = Student.create(name: 'Bob')
c = Student.create(name: 'Cris')
d = Student.create(name: 'Daria')
e = Student.create(name: 'Eugene')
f = Student.create(name: 'Frank')
g = Student.create(name: 'Grisha')


math = Course.create(title: 'Math 101')
cs   =   Course.create(title:   'CS 101')
ptp = Course.create(title: 'PTP 212')
rdb = Course.create(title: 'RDB 251')
Course.create(title: 'Hidden course 999')
math.enrollments.create([{student: b}, {student: c}])

cs.enrollments.create([{student: e}, {student: g}])

ptp.enrollments.create([{student: a}, {student: c}, {student: e}])

rdb.enrollments.create([{student: d}, {student: e}, {student: g}])

a.add_grade(math, 5)
a.add_grade(math, 4)
a.add_grade(math, 5)
a.finish_course(math)
a.add_grade(ptp, 5)


b.add_grade(math, 5)
b.add_grade(math, 3)
b.add_grade(math, 3)

d.add_grade(cs, 4)
d.add_grade(cs, 5)
d.add_grade(cs, 4)
d.finish_course(cs)

e.add_grade(ptp, 4)
e.add_grade(ptp, 2)
e.add_grade(ptp, 1)

g.add_grade(rdb, 3)
g.add_grade(rdb, 2)
g.add_grade(rdb, 5)