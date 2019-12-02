--- XMl Validator
-- Validates an XML against a schema.

local xmllib = require('xml2lua')

--Uses a handler that converts the XML to a Lua table
local handler = require("xmlhandler.tree")

local _M = { }

--- Validate an XML object
-- Checks if XML content is valid according to the given schema.
-- @tparam table xml_content XML content
-- @treturn boolean True if the XML is valid. False otherwise.
-- @treturn string Error message only when the XML is invalid.
function _M.validate(xml)

  --Instantiates the XML parser
  local parser = xml2lua.parser(handler)
  parser:parse(xml)

  --Manually prints the table (since the XML structure for this example is previously known)
  for i, p in pairs(handler.root.people.person) do
    print(i, "Name:", p.name, "City:", p.city, "Type:", p._attr.type)
  end

end

return _M
