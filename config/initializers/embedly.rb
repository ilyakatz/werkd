@@embedly_api = 
  if Figleaf::Settings.embedly.enabled?
    Embedly::API.new(
      key: Figleaf::Settings.embedly.api_key,
      user_agent: 'Mozilla/5.0 (compatible; werkd/1.0; my@email.com)'
    )
  else
    #url = "http://www.youtube.com/watch?v=cAbunRuOQfo"
    #obj = @embedly_api.preview :url => url
    #obj[0].marshal_dump[:object][:html]
    #obj[0].marshal_dump[:embeds][0]["html"]
  end



