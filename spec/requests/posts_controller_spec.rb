require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
  let!(:post) do
    Post.create(author: user, title: 'Title-1', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
  end
  context 'when GET /index' do
    before(:example) { get user_posts_path(user.id) }
    it 'is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render the index template' do
      expect(response).to render_template(:index)
    end
  end

  context 'when GET /show' do
    before(:example) { get user_post_path(user, post) }

    it 'is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render show template' do
      expect(response).to render_template(:show)
    end
  end
end
