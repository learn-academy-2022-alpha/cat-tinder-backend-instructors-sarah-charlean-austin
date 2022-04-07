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

in db/seeds.rb

```ruby
cats = [
  {
    name: 'Felix',
    age: 2,
    enjoys: 'Long naps on the couch, and a warm fire.',
    image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
  },
  {
    name: 'Homer',
    age: 12,
    enjoys: 'Food mostly, really just food.',
    image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
  },
  {
    name: 'Jack',
    age: 5,
    enjoys: 'Furrrrociously hunting bugs.',
    image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
  }
]

cats.each do |each_cat|
  Cat.create each_cat
  puts "creating cat #{each_cat}"
end
```

$ rails db:seed

app/controllers/application_controller.rb
`skip_before_action :verify_authenticity_token`

/Gemfile
`gem 'rack-cors', :require => 'rack/cors'`
