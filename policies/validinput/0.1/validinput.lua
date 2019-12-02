local setmetatable = setmetatable

local _M = require('apicast.policy').new('Validate Input Object type', '0.1')
local mt = { __index = _M }

-- local xml_validator = require('xml_validator')
-- local json_validator = require('json_validator')

local xml_validator = { validate = function(xml) { ngx.log(ngx.ERR, xml) } }
local json_validator = { validate = function(xml) { ngx.log(ngx.ERR, xml) } }

function _M.new(config)
  local self = setmetatable({}, mt)
  self.mode = config.dropdown_input
  return self
end

function _M:init()
  -- do work when nginx master process starts
end

function _M:init_worker()
  -- do work when nginx worker process is forked from master
end

function _M:rewrite()
  ngx.log(ngx.INFO, "=========>>>>> INPUT VALIDATOR config = ", self.mode)

  local validator
  if self.mode = 'xml' then
    validator = xml_validator
    ngx.log(ngx.INFO, "IF =========>>>>> INPUT XML VALIDATOR config = ", self.mode)
  else if self.mode = 'json' then
    validator = json_validator
    ngx.log(ngx.INFO, "IF =========>>>>> INPUT JSON VALIDATOR config = ", self.mode)
  else
    ngx.log(ngx.INFO, "NO VALIDATOR config = ", self.mode)
  end

  local xml = [[
    <people>
      <person type="natural">
        <name>Manoel</name>
        <city>Palmas-TO</city>
      </person>
      <person type="legal">
        <name>University of Brasília</name>
        <city>Brasília-DF</city>
      </person>
    </people>
    ]]

    
  validator.validate(xml)

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
