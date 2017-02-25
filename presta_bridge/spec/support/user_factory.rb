module UserFactory
  def self.create
    User.create!(name: 'Foo', email: 'foo@foo.com', password: '12345')
  end
end
