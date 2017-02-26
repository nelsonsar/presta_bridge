module StoreFactory
  def self.create(user_id)
    Store.create(
      name: 'Foo',
      url: 'http://foosstore.com',
      user_id: user_id,
      api_key: '9' * 32
    )
  end
end
