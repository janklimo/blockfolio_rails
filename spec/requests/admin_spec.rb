describe "Admin area", :type => :request do
  before do
    @me = create(:user, blockfolio_token: 'mytoken')
    @not_me = create(:user, blockfolio_token: 'notmytoken')
    allow(BlockfolioToken).to receive(:new).and_return(double(valid?: true))
  end

  it "allows access to me only" do
    sign_in_with(@me.blockfolio_token)
    get "/oauth/applications/"
    expect(response).to_not redirect_to(root_url)
  end

  it 'but nobody else' do
    sign_in_with(@not_me.blockfolio_token)
    get "/oauth/applications/"
    expect(response).to redirect_to(root_url)
  end

  def sign_in_with(token)
    post users_url, params: { user: { blockfolio_token: token } }
  end
end
