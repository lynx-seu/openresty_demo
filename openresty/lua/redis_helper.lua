
local redis = require 'resty.redis'
local redis_config = require 'redis_config'
local kHashTinyUrl = 'tinyurl:tiny'

local M = {}
M.__index = M

local function new(config)
    local host = config.host or '127.0.0.1'
    local port = config.port or 6379
    local passwd = config.passwd or 'foobared'
    local redis_conn = redis:new()

    redis_conn:set_timeout(1000)
    local ok, err = redis_conn:connect(host, port)
    if not ok then
        ngx.log(ngx.ERR, "failed to connect to redis:", err)
        return nil, err
    end

    local ok, err = redis_conn:auth(passwd)
    if not ok then
        ngx.log(ngx.ERR, "failed to auth redis:", err)
        return nil, err
    end

    return setmetatable({conn = redis_conn}, M)
end

function M:get_origin_url(tiny_url)
    local conn = self.conn

    local origin, err = conn:hget(kHashTinyUrl, tiny_url)
    if not origin then
        ngx.log(ngx.ERR, "failed to get origin:", err, "tinyurl:", tiny_url)
        return nil, err
    end
    return origin
end

return setmetatable({new = new},
    {__call = function(_, ...) return new(...) end}
)
