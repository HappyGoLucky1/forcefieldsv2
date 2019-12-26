local projectiles = {};

projectiles["crossbow_bolt"]		 	= true;
projectiles["grenade_ar2"]			 	= true;
projectiles["hunter_flechette"]	 		= true;
projectiles["npc_clawscanner"]		 	= true;
projectiles["npc_combine_camera"]	 	= true;
projectiles["npc_combine_s"]		 	= true;
projectiles["npc_combinedropship"]	 	= true;
projectiles["npc_combinegunship"]	 	= true;
projectiles["npc_cscanner"]		 		= true;
projectiles["npc_grenade_frag"]			= true;
projectiles["npc_helicopter"]		 	= true;
projectiles["npc_hunter"]			 	= true;
projectiles["npc_manhack"]			 	= true;
projectiles["npc_metropolice"]		 	= true;
projectiles["npc_rollermine"]		 	= true;
projectiles["npc_stalker"]			 	= true;
projectiles["npc_strider"]			 	= true;
projectiles["npc_tripmine"]		 		= true;
projectiles["npc_turret_ceiling"]	 	= true;
projectiles["npc_turret_floor"] 	 	= true;
projectiles["prop_combine_ball"]		= true;
projectiles["prop_physics"]		 		= true;
projectiles["prop_vehicle_zapc"]	 	= true;
projectiles["rpg_missile"]			 	= true;

function PLUGIN:ShouldCollide(ent1, ent2)
	local player;
	local entity;

	if (ent1:IsPlayer()) then
		player = ent1;
		entity = ent2;
	elseif (ent2:IsPlayer()) then
		player = ent2;
		entity = ent1;
	elseif (projectiles[ent1:GetClass()] and ent2:GetClass() == "z_forcefield") then
		return false;
	elseif (projectiles[ent2:GetClass()] and ent1:GetClass() == "z_forcefield") then
		return false;
	end;


	if (IsValid(entity) and entity:GetClass() == "z_forcefield") then
		if (IsValid(player)) then
			if (!entity:GetDTBool(0)) then
				return false;
			end;

			if (entity.AllowedClasses and entity.AllowedClasses[Clockwork.class:FindByID(player:Team())["name"]]) then
				return false;
			elseif (entity:GetDTBool(1)) then
				if SERVER then
					if player:HasItemByID("union_card") then
						return false;
					end
				end
			else
				return true;
			end;
		else
			return entity:GetDTBool(0);
		end;
	end;
end

function PLUGIN:EntityFireBullets(ent, bullet)
	if (ent.FiredBullet) then return; end;

	local tr = util.QuickTrace(bullet.Src, bullet.Dir * 10000, ent);

	if (IsValid(tr.Entity) and tr.Entity:GetClass() == "z_forcefield") then
		for i = 1, (bullet.Num or 1) do
			local newbullet = table.Copy(bullet);
			newbullet.Src = tr.HitPos + tr.Normal * 1;

			ent.FiredBullet = true;
			ent:FireBullets(newbullet);
			ent.FiredBullet = false;
		end;

		return false;
	end;
end