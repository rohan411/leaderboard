class Redis
class ConnectionManager

 def self.connect
   self.disconnect
   $redis = Redis.new(:host => 'localhost', :port => 6379)
   $redis_leader_board = Redis::Namespace.new(:leader_board, :redis => $redis)
 end


 def self.disconnect
   if $redis
     $redis.client.disconnect
   end
 end

end
end

