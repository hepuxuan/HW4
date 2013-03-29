require 'spec_helper'
describe Movie do
describe 'find_movie_by_director' do
  it 'should call the model method that performs where search' do
    Movie.should_receive(:where)
    fake_result= Movie.new
    fake_result.director='fake_director'
    Movie.stub(:find).and_return(fake_result)
    Movie.find_movie_by_director ('name')
  end
  it 'should return an err message if no record found' do
    fake_result= Movie.new
    fake_result.director=nil
    fake_result.title='fake_title'
    Movie.stub(:find).and_return(fake_result)
    result=Movie.find_movie_by_director (1)
    result.should =='fake_title has no director'
  end
  it 'should return movie list if the director maches' do
    fake_result= Movie.new
    fake_result.director='fake_director'
    fake_result.title='fake_title'
    Movie.stub(:find).and_return(fake_result)
    fake_results=[mock('Movie'), mock('Movie')]
    Movie.stub(:where).and_return(fake_results)
    result=Movie.find_movie_by_director (1)
    result.should ==fake_results
  end
end
end
