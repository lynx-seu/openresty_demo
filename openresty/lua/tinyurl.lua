local tinyurl_url = ngx.var.tinyurl_url
local redis_helper = require 'redis_helper'
local redis_config = require 'redis_config'

-- get origin url from redis
local redis_conn = redis_helper.new(redis_config)
local origin_url, err = redis_conn:get_origin_url(tinyurl_url)
--ngx.say(origin_url, err)
if err then
    ngx.log(ngx.ERR, "failed to get origin url:", err)
    return ngx.exit(500)
end

--local scheme, uri = origin_url:match '^(https?://)?[^/]+(.+)$'
--ngx.say(scheme, " ", uri)

-- match origin request uri
local regex = [[^(https?://)?[^/]+(.+)$]]
local m = ngx.re.match(origin_url, regex, 'jo')
if not m then
    ngx.log(ngx.ERR, "origin url dismatched error:", err)
    return ngx.exit(500)
end

-- rewrite request uri
--local unpack = unpack or table.unpack
--ngx.say(unpack(m))
ngx.exec(m[2])




