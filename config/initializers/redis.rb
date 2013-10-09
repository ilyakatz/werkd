uri = if (ENV["REDISCLOUD_URL"])
        URI.parse(ENV["REDISCLOUD_URL"])
      else
        Figleaf::Settings.redis.url
      end

$redis = if uri
           Redis.new(
             hos: ( uri.host if uri.try(:host)),
             port: ( uri.port if uri.try(:port)),
             password: (uri.password if uri.try(:password))
           )
         end
