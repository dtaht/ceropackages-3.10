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
local path = "/usr/lib/aqm"

m = Map("aqm", translate("Active Queue Management"),
	translate("With <abbr title=\"Active Queue Management\">AQM</abbr> you " ..
		"can enable traffic shaping and prioritisation on one " ..
		"network interface."))

s = m:section(TypedSection, "queue", translate("Queues"))
s:tab("tab_basic", translate("Basic Settings"))
s:tab("tab_qdisc", translate("Queueing Discipline"))
s:tab("tab_linklayer", translate("Link Layer Adaptation"))
s.addremove = false
s.anonymous = true

-- BASIC
e = s:taboption("tab_basic", Flag, "enabled", translate("Enable"))
e.rmempty = false

n = s:taboption("tab_basic", ListValue, "interface", translate("Interface name"))
for _, iface in ipairs(ifaces) do
     if iface:is_up() then
	n:value(iface:name())
     end
end
n.rmempty = false

dl = s:taboption("tab_basic", Value, "download", translate("Download speed (kbit/s)"))
dl.datatype = "and(uinteger,min(0))"
dl.rmempty = false

ul = s:taboption("tab_basic", Value, "upload", translate("Upload speed (kbit/s)"))
ul.datatype = "and(uinteger,min(0))"
ul.rmempty = false

-- QDISC
ad = s:taboption("tab_qdisc", Flag, "advanced", translate("Show Advanced Configuration"))
ad.rmempty = true

c = s:taboption("tab_qdisc", ListValue, "qdisc", translate("Queueing discipline"))
c:value("fq_codel", "fq_codel ("..translate("default")..")")
c:value("efq_codel")
c:value("nfq_codel")
c:value("sfq")
c:value("codel")
c:value("ns2_codel")
c:value("pie")
c:value("sfq")
c.default = "fq_codel"
c.rmempty = true
c:depends("advanced", "1")

local qos_desc = ""
sc = s:taboption("tab_qdisc", ListValue, "script", translate("Queue setup script"))
for file in fs.dir(path) do
  if string.find(file, ".qos$") then
    sc:value(file)
  end
  if string.find(file, ".qos.help$") then
    fh = io.open(path .. "/" .. file, "r")
    qos_desc = qos_desc .. "<p><b>" .. file:gsub(".help$", "") .. ":</b><br />" .. fh:read("*a") .. "</p>"
  end
end
sc.default = "simple.qos"
sc.rmempty = true
sc.description = qos_desc
sc:depends("advanced", "1")

-- LINKLAYER
lla = s:taboption("tab_linklayer", ListValue, "linklayer_adaptation_mechanism", translate("Which linklayer adaptation mechanism to use; especially useful for DSL/ATM links:")) -- Creates an element list (select box)
lla:value("none")
-- lla:value("htb_private")
lla:value("tc_stab")
lla.default = "none"

ll = s:taboption("tab_linklayer", ListValue, "linklayer", translate("Which linklayer to account for:")) -- Creates an element list (select box)
ll:value("ethernet")
ll:value("adsl")
-- ll:value("atm")	-- reduce the options
ll.default = "adsl"
ll:depends("linklayer_adaptation_mechanism", "htb_private")
ll:depends("linklayer_adaptation_mechanism", "tc_stab")

po = s:taboption("tab_linklayer", Value, "overhead", translate("Per Packet Overhead (byte):"))
po.datatype = "and(integer,min(-1500))"
po.default = 0
po.isnumber = true
po.rmempty = false
po:depends("linklayer_adaptation_mechanism", "htb_private")
po:depends("linklayer_adaptation_mechanism", "tc_stab")

adll = s:taboption("tab_linklayer", Flag, "linklayer_advanced", translate("Show Advanced Linklayer Options, (only needed if MTU > 1500)"))
adll.rmempty = true

smtu = s:taboption("tab_linklayer", Value, "MTU", translate("Maximal Size for size and rate calculations, tcMTU (byte); needs to be >= interface MTU + overhead:"))
smtu.datatype = "and(uinteger,min(0))"
smtu.default = 2047
smtu.isnumber = true
smtu.rmempty = true
-- smtu:depends("linklayer_adaptation_mechanism", "htb_private")
-- smtu:depends("linklayer_adaptation_mechanism", "tc_stab")
smtu:depends("linklayer_advanced", "1")

stsize = s:taboption("tab_linklayer", Value, "TSIZE", translate("Number of entries in size/rate tables, TSIZE; for ATM choose TSIZE = (tcMTU + 1) / 16:"))
stsize.datatype = "and(uinteger,min(0))"
stsize.default = 128
stsize.isnumber = true
stsize.rmempty = true
-- stsize:depends("linklayer_adaptation_mechanism", "htb_private")
-- stsize:depends("linklayer_adaptation_mechanism", "tc_stab")
stsize:depends("linklayer_advanced", "1")

smpu = s:taboption("tab_linklayer", Value, "MPU", translate("Minimal packet size, MPU (byte); needs to be > 0 for ethernet size tables:"))
smpu.datatype = "and(uinteger,min(0))"
smpu.default = 0
smpu.isnumber = true
smpu.rmempty = true
-- smpu:depends("linklayer_adaptation_mechanism", "htb_private")
-- smpu:depends("linklayer_adaptation_mechanism", "tc_stab")
smpu:depends("linklayer_advanced", "1")

-- PRORITIES?

return m
