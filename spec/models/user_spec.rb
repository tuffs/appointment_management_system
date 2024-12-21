require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil, email: 'john@doe.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(user).to_not be_valid
  end

  it 'is invalid wihout an email' do
    user = User.new(name: 'John Doe', email: nil, password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(user).to_not be_valid
  end

  it 'is invalid with a duplicate email address' do
    User.create!(name: 'Jane Doe', email: 'jane@example.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    duplicate_user = User.new(name: 'John Doe', email: 'jane@example.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(duplicate_user).to_not be_valid
  end

  it 'requires a password' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: nil, password_confirmation: nil)
    expect(user).to_not be_valid
  end

  it 'encrypts the password when saving' do
    user = User.create!(name: 'John Doe', email: 'john@doe.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(user.password_digest).to_not eq('p@ssword1')
    expect(user.password_confirmation).to eq('p@ssword1')
  end

  it 'authenticates with the correct password' do
    user = User.create!(name: 'John Doe', email: 'john@doe.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(user.authenticate('p@ssword1')).to be_truthy
  end

  it 'does not authenticate with an incorrect password' do
    user = User.create!(name: 'John Doe', email: 'john@doe.com', password: 'p@ssword1', password_confirmation: 'p@ssword1')
    expect(user.authenticate('password')).to be_falsey
  end

  it 'requires a password to be at least 8 characters long, include at least one number, and one special character' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: 'short@1', password_confirmation: 'short@1')
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include('must be at least 8 characters long, include at least one number, and one special character.')
  end

  it 'requires a password_confirmation attribute to be present for creation' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: 'p@ssword1', password_confirmation: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid with a mismatched password and password_confirmation' do
    user = User.new(name: 'John Doe', email: 'john@doe.com', password: 'p@ssword1', password_confirmation: 'password')
    expect(user).to_not be_valid
  end
end
