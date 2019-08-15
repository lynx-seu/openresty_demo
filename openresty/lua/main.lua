
local redis = require "resty.redis"
local redis_conn = redis:new()

redis_conn:set_timeout(1000)
local ok, err = redis_conn:connect("redis", 6379)
if not ok then
    ngx.log(ngx.ERR, "failed to connect to redis:", err)
    return ngx.exit(500)
end

ok, err = redis_conn:set("hello", "lua from openresty")
if not ok then
    ngx.say("failed to set hello: ",  err)
    return ngx.exit(500)
end

local val, err = redis_conn:get("hello")
if not val then
    ngx.say("failed to get hello: ",  err)
    return ngx.exit(500)
end

local str = string.format("<p>hello, %s</p>", val)
ngx.say(str)

