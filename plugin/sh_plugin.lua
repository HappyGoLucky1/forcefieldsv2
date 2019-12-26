local PLUGIN = PLUGIN

if (!netstream) then
	include("libraries/sh_netstream.lua")
	AddCSLuaFile("libraries/sh_netstream.lua")
end

Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sh_hooks.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_hooks.lua")