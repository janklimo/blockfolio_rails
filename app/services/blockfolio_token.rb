class BlockfolioToken
  def initialize(token)
    @token = token
  end

  # Blockfolio v0 API returns valid JSON for invalid tokens
  # We conclude that the token is invalid if the account has no positions
  def valid?
    resp = RestClient.get("https://api-v0.blockfolio.com/rest/get_all_positions/#{@token}")
    data = JSON.parse(resp.body)
    data['positionList'].size > 0
  rescue
    false
  end
end
