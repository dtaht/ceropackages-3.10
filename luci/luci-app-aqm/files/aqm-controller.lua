--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.aqm", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/aqm") then
		return
	end
	
	local page

	page = entry({"admin", "network", "aqm"}, cbi("aqm"), _("AQM"))
	page.dependent = true
end
