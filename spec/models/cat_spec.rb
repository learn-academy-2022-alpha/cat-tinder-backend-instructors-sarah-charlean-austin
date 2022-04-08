require 'rails_helper'

RSpec.describe Cat, type: :model do
 describe 'Create cat' do
   it 'wont create a cat in the database without a name' do
    # make a cat without the paramter being tested for
     cat = Cat.create age: 999, enjoys: 'playing with yarn (the package manager not the thread)', image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    #  expect the model to throw an error
    p cat.errors[:name]
    expect(cat.errors[:name]).to_not be_empty
   end
   it 'wont create a cat in the database without an age' do
    # make a cat without the paramter being tested for
     cat = Cat.create name: 'Monster Truck', enjoys: 'playing with yarn (the package manager not the thread)', image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    #  expect the model to throw an error
    p cat.errors[:age]
    expect(cat.errors[:age]).to_not be_empty
   end
   it 'wont create a cat in the database without an enjoys' do
    # make a cat without the paramter being tested for

#        This is the point of issue 
#                V
     cat = Cat.create name: 'Monster Truck', age: 999,  image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'

    #  expect the model to throw an error
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
   end
   it 'wont create a cat in the database without an enjoys that is ten characters long' do
    # make a cat without the paramter being tested for

     cat = Cat.create name: 'Monster Truck', age: 999, enjoys: 'yup', image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'

    #  expect the model to throw an error
    p cat.errors[:enjoys]

    expect(cat.errors[:enjoys]).to_not be_empty
   end
   it 'wont create a cat in the database without an image' do
    # make a cat without the paramter being tested for
     cat = Cat.create name: 'Monster Truck', age: 999, enjoys: 'playing with yarn (the package manager not the thread)'

    #  expect the model to throw an error
    p cat.errors[:image]
    expect(cat.errors[:image]).to_not be_empty
   end
   it 'wont create a cat in the database with an image that is a duplicate' do
    # make a cat without the paramter being tested for
    cat1 = Cat.create name: 'Monster Truck', age: 999, enjoys: 'playing with yarn (the package manager not the thread)', image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    cat = Cat.create name: 'Monster Truck', age: 999, enjoys: 'playing with yarn (the package manager not the thread)',  image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    #  expect the model to throw an error
    p cat.errors[:image]
    expect(cat.errors[:image]).to_not be_empty
   end
 end
end
