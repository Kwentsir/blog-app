require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)

    Post.create(title: 'First title', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
                author: user)
    Post.create(title: 'Second title', text: 'This is my second post', comments_counter: 0, likes_counter: 0,
                author: user)
    Post.new(title: 'Third title', text: 'This is my third post', comments_counter: 0, likes_counter: 0,
             author: user)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comments counter should be greater or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should update posts counter' do
    expect(subject.author.posts_counter).to eq 3
  end

  it 'should get last 5 comments' do
    Comment.create(post: subject, author: subject.author, text: 'This is my first comment')
    Comment.create(post: subject, author: subject.author, text: 'This is my second comment')
    Comment.create(post: subject, author: subject.author, text: 'This is my third comment')
    Comment.create(post: subject, author: subject.author, text: 'This is my fourth comment')
    Comment.create(post: subject, author: subject.author, text: 'This is my fifth comment')
    Comment.create(post: subject, author: subject.author, text: 'This is my sixth comment')
    Comment.create(post: subject, author: subject.author, text: 'This is my seventh comment')
    expect(subject.last_five_comments.length).to eq 5
    expect(subject.last_five_comments[0].text).to eq 'This is my first comment'
  end
end
