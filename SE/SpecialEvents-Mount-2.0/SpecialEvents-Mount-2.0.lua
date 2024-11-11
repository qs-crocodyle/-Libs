--[[
	Name: SpecialEvents-Mount-2.0
	Revision: $Rev: 15360 $
	Author: Tekkub Stoutwrithe (tekkub@gmail.com)
	Website: http://www.wowace.com/
	Description: Special events for mounting
	Dependencies: AceLibrary, AceEvent-2.0, Gratuity-2.0
]]


local vmajor, vminor = "SpecialEvents-Mount-2.0", "$Revision: 15360 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end

local lib = {}
AceLibrary("AceEvent-2.0"):embed(lib)


-- Activate a new instance of this library
function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.vars = oldLib.vars
		oldLib:UnregisterAllEvents()
	else
		self.vars = {}
	end
	self:RegisterEvent("PLAYER_AURAS_CHANGED")
	
	if oldDeactivate then oldDeactivate(oldLib) end
end

local Mount_List = {
	"_mount_",						--常规坐骑
	"spell_nature_swiftness",		--骸骨军马、机械陆行鸟、科多兽、地狱战马、迅猛龙等
	"_qirajicrystal_",				--其拉共鸣水晶
	
	--------特殊坐骑请玩家自行往下添加--------
	"hunter_pet_turtle", 			--乌龟坐骑 
	"warstomp", 					--斑马坐骑 
	"bullrush", 					--幽灵狮鹫
	"_branch_", 						--驯鹿
	"hunter_pet_hippogryph", --角鹰兽
	"hunter_pet_tallstrider", --爱情鸟
	"hunter_pet_bear",     --熊
	"spell_nature_sentinal", --乌鸦
	"inv_misc_key_06",     -- 工程坐骑
	"inv_misc_key_12",     -- 工程坐骑
	"spell_magic_polymorphchicken", -- 魔法公鸡
	"hunter_pet_stag1", -- 暗角雄鹿
	"inv_valentinescard01", -- 粉色虎
	"inv_valentinesboxofchocolates02", -- 粉色马
	'ability_hunter_pet_dragonhawk', -- 龙鹰
	"ability_racial_bearform",
	"ability_druid_catform",
	"ability_druid_travelform",
	"ability_druid_aquaticform",
	"spell_nature_spiritwolf",
	"inv_pet_speedy",
}

function lib:PLAYER_AURAS_CHANGED()
	for i = 0, 31, 1 do
		Mount_Texture = GetPlayerBuffTexture(i)
		if Mount_Texture then
			for _, Mount_BuffType in pairs(Mount_List) do
				if string.find(string.lower(Mount_Texture), Mount_BuffType) then
					self.vars.mounted = true
					break
				else
					self.vars.mounted = false
					break
				end
			end
		end
	end
end

--返回玩家是否在坐骑上
function lib:PlayerOnMount()
	if self.vars.mounted then
		return true
	else
		return false
	end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
AceLibrary:Register(lib, vmajor, vminor, activate)