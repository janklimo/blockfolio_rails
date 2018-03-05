describe Api::V1::CredentialsController do
  describe 'GET #me', :type => :request do
    before do
      application = Doorkeeper::Application.create!(name: 'MyApp',
                                                    redirect_uri: 'https://app.com')
      @user = create(:user)
      @token = Doorkeeper::AccessToken.create!(application_id: application.id,
                                               resource_owner_id: @user.id, scopes: 'public')
      @expected_response = {
        "data" => {
          "id" => @user.id.to_s,
          "type" => "user",
          "attributes" => {
            "blockfolio_token" => @user.blockfolio_token
          }
        }
      }
    end

    it 'responds with 200' do
      get api_v1_credentials_me_url,
        headers: { 'Authorization' => "Bearer #{ @token.token }" }
      expect(response.status).to eq(200)
    end

    it 'returns the user as json' do
      get api_v1_credentials_me_url,
        headers: { 'Authorization' => "Bearer #{ @token.token }" }
      resp = JSON.parse(response.body)
      expect(resp).to eq(@expected_response)
    end

    it 'returns unautorized if token is missing/wrong' do
      get api_v1_credentials_me_url,
        headers: { 'Authorization' => "Bearer #{ @token.token }ble" }
      expect(response.status).to eq(401)
    end
  end
end
