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

# API Endpoints
 $ rails routes
 ```
  Prefix Verb   URI Pattern                                                                                       Controller#Action
                                    cats GET    /cats(.:format)                                                                                   cats#index
                                        POST   /cats(.:format)                                                                                   cats#create
                                new_cat GET    /cats/new(.:format)                                                                               cats#new
                                edit_cat GET    /cats/:id/edit(.:format)                                                                          cats#edit
                                    cat GET    /cats/:id(.:format)                                                                               cats#show
                                        PATCH  /cats/:id(.:format)                                                                               cats#update
                                        PUT    /cats/:id(.:format)                                                                               cats#update
                                        DELETE /cats/:id(.:format)                                                                               cats#destroy

```

# Validations
- Creating Data Validations and associated tests to ensure the effectiveness of our application.
- As a developer, I can add the appropriate model specs that will ensure an incomplete cat throws an error.
- As a developer, I can add the appropriate request validations to ensure the API is sending useful information to the frontend developer if a new cat is not valid.

```ruby
class Cat < ApplicationRecord
  # Validations go here
  validates :name, :age, :enjoys, presence: true
  validates :enjoys, length: { minimum: 10 }
end
```

spec/models/cat_spec.rb - Example
```ruby
describe 'Create cat' do
   it 'wont create a cat in the database without a name' do
    # make a cat without the paramter being tested for
     cat = Cat.create age: 999, enjoys: 'playing with yarn (the package manager not the thread)', image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    #  expect the model to throw an error
    p cat.errors[:name]
    expect(cat.errors[:name]).to_not be_empty
   end
  end
```
spec/requests/cats_spec.rb - Example 
```ruby
describe 'cannot create a cat without valid attributes' do
    it 'cannot create a cat without a name' do
      cat_params = {
        cat: {
          age: 6,
          enjoys: 'Showing up in odd places randomly',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }

      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['name']).to include "can't be blank"
    end
  end
```