--- JSON Validator
-- Validates a JSON against a schema.

-- local jsonschema = require('jsonschema')
local jsonvalidator = require('validators.validJson')
local setmetatable = setmetatable
local _M = { }
local mt = { __index = _M }

function _M.new()
  local self = setmetatable({}, mt)
  ngx.log(ngx.WARN, "=========>>>>>NEW JSON VALIDATOR")  
  return self
end

--- Validate a JSON object
-- Checks if JSON content is valid according to the given schema.
-- @tparam table json_content JSON content
-- @tparam table config_schema JSON schema
-- @treturn boolean True if the JSON is valid. False otherwise.
-- @treturn string Error message only when the JSON is invalid.
function _M.validate(json_content)
      ngx.log(ngx.WARN, "=========>>>>> WELCOME INTO JSON VALIDATOR")
      ngx.log(ngx.WARN, "json_content: ", json_content)

  -- local validator = jsonschema.generate_validator(config_schema or {})
  return jsonvalidator.isValid(json_content) --validator(json_content or {})
end

function _M.validateschema(json_content, config_schema)
      ngx.log(ngx.WARN, "=========>>>>> WELCOME INTO JSON VALIDATOR")

  -- local validator = jsonschema.generate_validator(config_schema or {})
  -- return validator(json_content or {})
end

return _M
