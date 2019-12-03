local setmetatable = setmetatable

local _M = require('apicast.policy').new('Validate Input Object type', '0.1')
local mt = { __index = _M }

local xml_validator = require('validators.xml_validator')
local json_validator = require('validators.json_validator')

--local xml_validator = { validate = function(xml) { ngx.log(ngx.ERR, xml) } }
--local json_validator = { validate = function(xml) { ngx.log(ngx.ERR, xml) } }
    
function _M.new(config)
  local self = setmetatable({}, mt)
  self.mode = config.dropdown_input
  ngx.log(ngx.WARN, "function _M.new =========>>>>> INPUT VALIDATOR config = ", self.mode)  
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
  ngx.log(ngx.WARN, "function _M:rewrite=========>>>>> INPUT VALIDATOR config = ", self.mode)


local t_json = [[
 {"menu": {   "id": "file",   "value": "File",   "popup": {    "menuitem": [      {"value": "New", "onclick": "CreateNewDoc()"},      {"value": "Open", "onclick": "OpenDoc()"},      {"value": "Close", "onclick": "CloseDoc()"}    ]  }}}
    ]]
local t_body = ngx.req.read_body()
ngx.log(ngx.WARN, "=========>>>>> INPUT BODY:", t_body)    
local validator
  if self.mode == 'xml' then
    validator = xml_validator
        if validator.validate(t_body) then
            ngx.log(ngx.WARN, "=========>>>>> INPUT XML is valid", t_body)
        else
            ngx.log(ngx.ERR, "=========>>>>> INPUT XML is NOT valid", t_body)
        end	        
        
  elseif self.mode == 'json' then
    validator = json_validator
    ngx.log(ngx.WARN, "IF =========>>>>> INPUT JSON VALIDATOR config = ", self.mode)
            ngx.log(ngx.WARN, "=========>>>>> INPUT JSON to check", t_body)
        if json_validator.validate(t_body) then
            ngx.log(ngx.WARN, "=========>>>>> INPUT JSON is valid", t_body)
        else
            ngx.log(ngx.ERR, "=========>>>>> INPUT JSON is NOT valid", t_body)
        end				
    end
--    if validator.validate(t_body) then
--            ngx.log(ngx.WARN, "VALIDATOR AGREE TO LET YOU PASS", self.mode)
--    end
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


