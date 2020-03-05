require 'rails_helper'

describe MoviesController, type: 'controller' do
    before :each do
       @movie_argus = {:title => '1', :director => 'abc', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04'}
    end
    describe 'create' do
        let(:new_movie) { instance_double(Movie, @movie_argus) } 
        it 'create a movie' do
            expect(Movie).to receive(:create!).with(@movie_argus).and_return(new_movie)
            post :create, {:movie => @movie_argus}
        end
    end
    describe 'edit' do
        let(:movies) { instance_double(Movie, :id => 1, :title => '2', :director => 'abcde', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
        it 'edit a movie' do
            allow(Movie).to receive(:find).with('1').and_return(movies)
            expect(movies).to receive(:update_attributes!).with(@movie_argus)
            put :update, {:id => 1, :movie => @movie_argus}
        end
    end
    
    describe 'destroy' do
        let(:movies) { instance_double(Movie, :id => 1, :title => '2', :director => '2', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
        it 'destroy a movie' do
            allow(Movie).to receive(:find).with('1').and_return(movies)
            expect(movies).to receive(:destroy)
            delete :destroy, {:id => 1}
        end
    end
    
    
    describe 'find same director movies' do
        context "When movie has a director" do
            let(:movies) { instance_double(Movie, :id => 1, :title => '2', :director => 'abc', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
            it "should find movies with same director" do
            expect(Movie).to receive(:find).with('1').and_return(movies)
            expect(movies).to receive(:director).and_return('abc')
            expect(Movie).to receive(:find_movie_same_director).with('abc')
            get :find_same_director, :id => 1
            expect(response).to render_template(:find_same_director)
            end
        end
        context "When movie has no director" do
            let(:movies_no_dir) { instance_double(Movie, :id => 2, :title => '2', :rating => 'PG', :description => 'xxxxxxx', :release_date => '2020-03-04') }
            it "should redirect to home page" do
                expect(Movie).to receive(:find).with('2').and_return(movies_no_dir)
                expect(movies_no_dir).to receive(:director).and_return(nil)
                get :find_same_director, :id => 2
                expect(response).to redirect_to(movies_path)
            end
        end
    end
end