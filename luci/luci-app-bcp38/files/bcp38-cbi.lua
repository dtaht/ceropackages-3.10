--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

local wa = require "luci.tools.webadmin"
local fs = require "nixio.fs"
local net = require "luci.model.network".init()
local ifaces = net:get_interfaces()
local path = "/usr/lib/sqm"

m = Map("bcp38", translate("BCP38"),
	translate("This function blocks packets with private address destinations " ..
		"from going out onto the internet as per " ..
		"<abbr title=\"Best Current Practice\">BCP</abbr> 38."))

s = m:section(TypedSection, "bcp38", translate("BCP38 config"))
s.anonymous = true
-- BASIC
e = s:option(Flag, "enabled", translate("Enable"))
e.rmempty = false

ma = s:option(DynamicList, "match",
	translate("Blocked IP ranges"))

ma.datatype = "ip4addr"

nm = s:option(DynamicList, "nomatch",
	translate("Allowed IP ranges"), translate("Takes precedence over blocked ranges. "..
						  "Use to whitelist your upstream network if you're behind a double NAT."))

nm.datatype = "ip4addr"


return m
