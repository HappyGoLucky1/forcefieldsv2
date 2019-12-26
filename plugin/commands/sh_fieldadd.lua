local COMMAND = Clockwork.command:New("FieldAdd");

COMMAND.tip = "Add a Combine field at your cursor.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.text = "";
COMMAND.arguments = 0;

-- Called when the command has been run.
-- Thanks mucker ;)
function COMMAND:OnRun(player, arguments)
	local trace = player:GetEyeTraceNoCursor();
	if (!trace.Hit) then return end


	local field = ents.Create("z_forcefield");
	field:SpawnFunction(player, trace)
	field:Remove()
end;

COMMAND:Register()