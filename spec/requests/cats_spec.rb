require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it 'gets a list of the cats' do
      #  step 1 create a cat in the DB
      Cat.create name: 'Mosey', age: 6, enjoys: 'Showing up in odd places randomly', image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
      # Step two make a request to the testing Database and asign that response to a variable
      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end
  describe 'POST /create' do
    it 'creates a cat' do
      cat_params = {
        cat: {
          name: 'Mosey',
          age: 6,
          enjoys: 'Showing up in odd places randomly',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }

      post '/cats', params: cat_params
      expect(response).to have_http_status(200)

      cat = Cat.first

      expect(cat.name).to eq 'Mosey'
      expect(cat.age).to eq 6
      expect(cat.enjoys).to eq 'Showing up in odd places randomly'
      expect(cat.image).to eq 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
    end
  end
  describe 'PATCH /update' do
    it 'updates a cat' do
    #  create a cat in the database to test the update on
      Cat.create name: 'Mosey', age: 6, enjoys: 'Showing up in odd places randomly', image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
      
      cat_mosey = Cat.first

      # cat obj that we will send over with a patch request
      cat_params = {
        cat: {
          name: 'Jerald',
          age: 6,
          enjoys: 'Showing up in odd places randomly',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }
      # send patch request with the id of the instance from the data base
      patch "/cats/#{cat_mosey.id}", params: cat_params
      # create a new variable with the id we used to send the patch request
      cat_mystery = Cat.find(cat_mosey.id)
      
      expect(response).to have_http_status(200)
      expect(cat_mystery.name).to eq 'Jerald'
    end
  end
  describe 'DELETE /destroy' do
    it 'deletes a cat from the DB' do
      # Database starts empty
      # put a cat in the Database
      Cat.create name: 'Mosey', age: 6, enjoys: 'Showing up in odd places randomly', image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'

      # Grab the cat out of the database and make a copy of it as a variable
      cat_mosey = Cat.first
      # use the ID in the variable to send a request back to the application 
      delete "/cats/#{cat_mosey.id}"
      expect(response).to have_http_status(200)

      cats = Cat.all
      expect(cats).to be_empty
    end
  end
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
    it 'cannot create a cat without an age' do
      cat_params = {
        cat: {
          name: 'Mosey',
          enjoys: 'Showing up in odd places randomly',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }

      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['age']).to include "can't be blank"
    end
    it 'cannot create a cat without an enjoys' do
      cat_params = {
        cat: {
          name: 'Mosey',
          age: 6,
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }

      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['enjoys']).to include "can't be blank"
    end
    it 'cannot create a cat without an enjoys that is less than 10 characters' do
      cat_params = {
        cat: {
          name: 'Mosey',
          age: 6,
          enjoys: 'Showing',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }

      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['enjoys']).to include "is too short (minimum is 10 characters)"
    end
    it 'cannot create a cat without an image' do
      cat_params = {
        cat: {
          name: 'Mosey',
          age: 6,
          enjoys: 'Showing up in odd places randomly'
        }
      }

      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['image']).to include "can't be blank"
    end
    it 'cannot create a cat with an image that is already assigned to another cat' do
      cat_params = {
        cat: {
          name: 'Mosey',
          age: 6,
          enjoys: 'Showing up in odd places randomly',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }
      # first post to DB
      post '/cats', params: cat_params

      # second post to DB
      post '/cats', params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['image']).to include "has already been taken"
    end
  end
 end
