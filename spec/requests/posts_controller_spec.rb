require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'when GET /index' do
    before(:example) { get user_posts_path(1) }
    it 'is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render the index template' do
      expect(response).to render_template(:index)
    end

    it 'should display correct content in the views' do
      expect(response.body).to include('List of posts')
    end
  end

  context 'when GET /show' do
    before(:example) { get user_post_path(1, 1) }

    it 'is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render show template' do
      expect(response).to render_template(:show)
    end

    it 'should display correct content inthe views' do
      expect(response.body).to include(' A post based on post id')
    end
  end
end
