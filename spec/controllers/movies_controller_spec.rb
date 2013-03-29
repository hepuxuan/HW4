require 'spec_helper'
describe MoviesController do

describe 'director' do
it 'should call the model method that performs find_same_director search' do
  Movie.should_receive(:find_movie_by_director).with('Star Wars')
  get :director, {:id=> 'Star Wars'}
end
it 'should select the Search Results template for rendering' do
  fake_results= [mock('Movie'), mock('Movie')]
  Movie.stub(:find_movie_by_director).and_return(fake_results)
  get :director, {:id=> 'Star Wars'}
  response.should render_template('director') 
  Movie.stub(:find_movie_by_director).and_return('Alien has no director')
  get :director, {:id=> 'Alien'}
  response.should redirect_to('/movies')
end
it 'should make the find_same_director search results available to that template' do
  fake_results= [mock('Movie'), mock('Movie')]
  Movie.stub(:find_movie_by_director).and_return(fake_results)
  get :director, {:id=> 'Star Wars'}
  assigns(:movies).should ==fake_results
  Movie.stub(:find_movie_by_director).and_return('Alien has no director')
  get :director, {:id=> 'Alien'}
  assigns(:err).should =='Alien has no director'
end
end 
end
