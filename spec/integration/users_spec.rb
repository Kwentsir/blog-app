require 'rails_helper'
# User index page:

# When I click on a user, I am redirected to that user's show page.

describe 'the signin process', type: :feature do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', posts_counter: 0)
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Poland.', posts_counter: 0)

    Post.create(author: @first_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: @first_user, title: 'software developer', text: 'This is a post about software development',
                comments_counter: 0, likes_counter: 0)
    Post.create(author: @second_user, title: 'Rails', text: 'This a post' * 20, comments_counter: 0, likes_counter: 0)
    Post.create(author: @second_user, title: 'Javascript', text: 'This is my post about javascript' * 20,
                comments_counter: 0, likes_counter: 0)
  end

  context 'user index page' do
    it 'should display the number of posts for each user' do
      visit root_path
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 2')
    end

    it 'should display profile pic for each user' do
      visit root_path
      users = User.all.order(:id)
      profile_pic = page.all('img')
      expect(profile_pic[0][:src]).not_to be('')
      expect(profile_pic.length).to eq(users.length)
    end
  end

  # user show page:

  context 'User show page' do
    before(:each) do
      visit user_path(@first_user.id)
    end
    it 'should show the user profile picture' do
      visit user_path(@first_user.id)
      users = User.all.order(:id)
      profile_pic = page.all('img')
      expect(profile_pic[0][:src]).not_to be('')
      expect(profile_pic.length).to eq(users.length - 1)
    end
  end

  it 'should display the number of posts the user has written' do
    visit user_path(@first_user.id)
    expect(page).to have_content('Number of posts: 2')
  end

  it 'should display users bio' do
    visit user_path(@first_user.id)
    expect(page).to have_content('Teacher from Mexico.')
  end

  it 'should display the user/s first 3 posts.' do
    visit user_path(@first_user)
    expect(page).to have_content('Hello')
    expect(page).to have_content('software developer')
    expect(page).to have_content('Hello')
  end

  context 'User post show page' do
    it 'Should display post text' do
      visit user_posts_path(@first_user.id)
      expect(page).to have_content('This is my first post')
    end

    it 'Should display comments counter' do
      visit user_post_path(@first_user.id, @first_user.posts.first.id)
      expect(page).to have_content('Comments: 0')
    end

    it 'Should display first comment' do
      @first_user.comments.create(post_id: @first_user.posts.first.id, text: 'Comment1')
      visit user_posts_path(@first_user.id)
      expect(page).to have_content('Comments: 1')
    end

    it 'Should redirect to post s page' do
      visit user_posts_path(@first_user.id)
      click_link 'Hello'
      expect(current_path).to eq(user_post_path(@first_user.id, @first_user.posts.first.id))
    end
  end
end
