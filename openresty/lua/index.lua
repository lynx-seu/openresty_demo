
local args = ngx.req.get_uri_args()
ngx.say('a = ', args.a, ', b = ', args.c)
