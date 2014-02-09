# $ ruby app.rb

require 'sinatra'
require 'mongoid'

Mongoid.load!("mongoid.yml")

# mongo db O/R mapper class
class Book
  include Mongoid::Document

  field :name, type: String
  field :price, type: Integer
end

# Add initial data
unless Book.all.empty?
  book =  Book.new
  book.name = "Start-up Ruby"
  book.price = 2500
  book.save
end

get '/books/array' do
  Book.all.map{ |b| [b.name, b.price] }.inspect
end

require 'json'
get '/books/json' do
  Book.all.to_json
end
