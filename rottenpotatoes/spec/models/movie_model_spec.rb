require 'rails_helper'


describe Movie do
  describe 'finding movies with same director' do
    context "it should find movies by the same director" do
      let(:movies) { instance_double(Movie, :id => 1, :title => '2', :director => 'abc', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
        it 'shows movies with same director' do
          expect(Movie).to receive(:where).with(director: movies.director).and_return(movies)
          Movie.find_movie_same_director(movies.director)
      end 
    end
    
    context "it should not find movies by different directors" do
      let(:movies) { instance_double(Movie, :id => 1, :title => '2', :director => 'abc', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
      let(:movies_diff_dir) { instance_double(Movie, :id => 2, :title => '2', :director => 'abcdef', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
        it 'shows movies with same directo' do
          expect(Movie.find_movie_same_director(movies.director)).not_to include(movies_diff_dir)
          Movie.find_movie_same_director(movies.director)
      end 
    end
    
  end
end