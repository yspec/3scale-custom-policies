local setmetatable = setmetatable

local _M = require('apicast.policy').new('Validate Input Object type', '0.1')
local mt = { __index = _M }

local xml_validator = require('validators.xml_validator')
local json_validator = require('validators.json_validator')
    
function _M.new(config)
  local self = setmetatable({}, mt)
  self.mode = config.dropdown_input
  ngx.log(ngx.WARN, "===new===>>>>> INPUT VALIDATOR type = ", self.mode)  
  return self
end

function _M:init()
  -- do work when nginx master process starts
end

function _M:init_worker()
  -- do work when nginx worker process is forked from master
end

function _M:rewrite()
  -- change the request before it reaches upstream
ngx.req.read_body()
local t_body = ngx.req.get_body_data()
ngx.log(ngx.WARN, "=========>>>>> INPUT BODY:", t_body)    
local validator
  if not (t_body == nil or self.mode == nil or self.mode == 'any') then
    if self.mode == 'xml' then
    validator = xml_validator
    elseif self.mode == 'json' then
    validator = json_validator
    end
    if validator.validate(t_body) then
      ngx.log(ngx.WARN, "=========>>>>> INPUT BODY is valid", t_body)
    else
      ngx.log(ngx.ERR, "=========>>>>> INPUT BODY is NOT valid", t_body)
    end	        
  end
end

function _M:access()
  -- ability to deny the request before it is sent upstream
end

function _M:content()
  -- can create content instead of connecting to upstream
end

function _M:post_action()
  -- do something after the response was sent to the client
end

function _M:header_filter()
  -- can change response headers
end

function _M:body_filter()
  -- can read and change response body
  -- https://github.com/openresty/lua-nginx-module/blob/master/README.markdown#body_filter_by_lua
end

function _M:log()
  -- can do extra logging
end

function _M:balancer()
  -- use for example require('resty.balancer.round_robin').call to do load balancing
end

return _M


