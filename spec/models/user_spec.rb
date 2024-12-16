require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil, email: 'john@doe.com', password: 'password')
    expect(user).to_not be_valid
  end

  it 'is invalid wihout an email' do
    user = User.new(name: 'John Doe', email: nil, password: 'password')
    expect(user).to_not be_valid
  end

  it 'is invalid with a duplicate email address' do
    User.create!(name: 'Jane Doe', email: 'jane@example.com', password: 'password')
    duplicate_user = User.new(name: 'John Doe', email: 'jane@example.com', password: 'password')
    expect(duplicate_user).to_not be_valid
  end

  it 'requires a password' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: nil)
    expect(user).to_not be_valid
  end
end
