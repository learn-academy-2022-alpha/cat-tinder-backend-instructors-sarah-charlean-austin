# Commands Already Run
$ rails new cat-tinder-backend -d postgresql -T
$ cd cat-tinder-backend
$ rails db:create
$ git remote add origin https://github.com/learn-academy-2022-alpha/cat-tinder-backend-instructors-sarah-charlean-austin.git
$ git checkout -b main
$ git add .
$ git commit -m "initial rails commit"
$ git push origin main
$ bundle add rspec-rails
$ rails generate rspec:install
$ rails generate resource Cat name:string age:integer enjoys:text image:text
