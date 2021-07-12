
local frame = CreateFrame('Frame');
frame:RegisterEvent('ADDON_LOADED');
frame:RegisterEvent('PLAYER_ENTERING_WORLD');
frame:Hide();

local TRACKING_LOW_LEVEL_QUESTS = 'Quêtes de bas niveau'
local TRACKING_FLY_MASTER = 'Maître de vol'
local TRACKING_ARCHAEOLOGY_SITES = 'Suivi des sites de fouille'
local TRACKING_MINE_SPOTS = 'Découverte de gisements'
local TRACKING_HERB_SPOTS = 'Découverte d\'herbes'
local TRACKING_FISH_SPOTS = 'Découverte de poissons'
local TRACKING_TREASURE_SPOTS = 'Découverte de trésors'
local TRACKING_QUESTS_SPOTS = 'Suivi des points d’intérêts de quêtes'

local DEBUG = false;

local function Log(message)
	if (DEBUG) then
		DEFAULT_CHAT_FRAME:AddMessage(message);
	end
end

local function OnTrackingInfo(i, value, name)
	SetTracking(i, value);
	Log('Defined tracking ' .. name .. ' : ' .. tostring(value));
end

local function ConfigureTracking()
	local count = GetNumTrackingTypes();
	for i=1, count do
		local name = GetTrackingInfo(i);
		if (name == TRACKING_LOW_LEVEL_QUESTS) then
			OnTrackingInfo(i, HeroConfiguration.trackLowLevelQuests, TRACKING_LOW_LEVEL_QUESTS);
		elseif (name == TRACKING_FLY_MASTER) then
			OnTrackingInfo(i, HeroConfiguration.trackLowLevelQuests, TRACKING_FLY_MASTER);
		elseif (name == TRACKING_ARCHAEOLOGY_SITES) then
			OnTrackingInfo(i, HeroConfiguration.trackArchaeologySites, TRACKING_ARCHAEOLOGY_SITES);
		elseif (name == TRACKING_MINE_SPOTS) then
			OnTrackingInfo(i, HeroConfiguration.trackMineSpots, TRACKING_MINE_SPOTS);
		elseif (name == TRACKING_HERB_SPOTS) then
			OnTrackingInfo(i, HeroConfiguration.trackHerbSpots, TRACKING_HERB_SPOTS);
		elseif (name == TRACKING_FISH_SPOTS) then
			OnTrackingInfo(i, HeroConfiguration.trackFishSpots, TRACKING_FISH_SPOTS);
		elseif (name == TRACKING_TREASURE_SPOTS) then
			OnTrackingInfo(i, HeroConfiguration.trackTreasureSpots, TRACKING_TREASURE_SPOTS);
		elseif (name == TRACKING_QUESTS_SPOTS) then
			OnTrackingInfo(i, HeroConfiguration.trackQuestsSpots, TRACKING_QUESTS_SPOTS);
		else
			SetTracking(i, false);
			Log('Defined tracking ' .. name .. ' : false (default)');
		end
	end
end

local function ConfigureScreenshots()
	SetCVar('screenshotFormat', 'tga');
	SetCVar('screenshotQuality', 10);
end

local function ConfigureUnitNames()
	SetCVar('UnitNameNPC', 1);
	SetCVar('UnitNameOwn', 0);
	SetCVar('UnitNamePlayerGuild', 0);
	SetCVar('UnitNamePlayerPVPTitle', 0);
	SetCVar('UnitNameEnemyGuardianName', 1);
	SetCVar('UnitNameEnemyPetName', 0);
	SetCVar('UnitNameEnemyMinionName', 0);
	SetCVar('UnitNameEnemyPlayerName', 1);
	SetCVar('UnitNameEnemyTotemName', 0);
	SetCVar('UnitNameFriendlyGuardianName', 1);
	SetCVar('UnitNameFriendlyPetName', 0);
	SetCVar('UnitNameFriendlyMinionName', 0);
	SetCVar('UnitNameFriendlyPlayerName', 1);
	SetCVar('UnitNameFriendlyTotemName', 0);
end

local function ConfigureNameplates()
	SetCVar('nameplateShowSelf', 1);
	SetCVar('NameplatePersonalShowAlways', 0);
	SetCVar('NameplatePersonalShowInCombat', 1);
	SetCVar('NameplatePersonalShowWithTarget', 1);
end

local function ConfigureChat()
	SetCVar('chatBubbles', 0);
	SetCVar('chatBubblesParty', 0);
	SetCVar('chatMouseScroll', 1);
	SetCVar('chatStyle', 'classic');
	SetCVar('removeChatDelay', 1);
	SetCVar('showTimestamps', '%H:%M:%S');
end

local function ConfigureSound()
	SetCVar('Sound_EnableErrorSpeech', '0');
	SetCVar('Sound_EnableMusic', '0');
	SetCVar('Sound_EnableSoundWhenGameIsInBG', '1');
	SetCVar('Sound_MasterVolume', '0.29100000858307');
end

local function ConfigureUI()
	SetCVar('uiScale', '0.64999997615814');
	SetCVar('useUiScale', '1');
end

local function ConfigureMisc()
	SetCVar('autoLootDefault', 1);
	SetCVar('buffDurations', 1);
	SetCVar('consolidateBuffs', 0);
	SetCVar('instantQuestText', 1);
	SetCVar('showDungeonEntrancesOnMap', 1);
	SetCVar('showTutorials', 0);
	SetCVar('violenceLevel', 5);
end

frame:SetScript('OnEvent', function(self, event, ...)
	local arg = {...}

	if (event == 'ADDON_LOADED' and arg[1] == 'HeroConfiguration') then
		if (HeroConfiguration == nil) then
			HeroConfiguration = {};
		end
		if (HeroConfiguration.trackLowLevelQuests == nil) then
			HeroConfiguration.trackLowLevelQuests = false;
		end
		if (HeroConfiguration.trackFlyMaster == nil) then
			HeroConfiguration.trackFlyMaster = false;
		end
		if (HeroConfiguration.trackArchaeologySites == nil) then
			HeroConfiguration.trackArchaeologySites = false;
		end
		if (HeroConfiguration.trackMineSpots == nil) then
			HeroConfiguration.trackMineSpots = true;
		end
		if (HeroConfiguration.trackHerbSpots == nil) then
			HeroConfiguration.trackHerbSpots = true;
		end
		if (HeroConfiguration.trackFishSpots == nil) then
			HeroConfiguration.trackFishSpots = false;
		end
		if (HeroConfiguration.trackTreasureSpots == nil) then
			HeroConfiguration.trackTreasureSpots = true;
		end
		if (HeroConfiguration.trackQuestsSpots == nil) then
			HeroConfiguration.trackQuestsSpots = true;
		end
	end

	if (event == 'PLAYER_ENTERING_WORLD') then
		ConfigureTracking();
		ConfigureScreenshots();
		ConfigureUnitNames();
		ConfigureNameplates();
		ConfigureChat();
		ConfigureSound();
		ConfigureUI();
		ConfigureMisc();
	end

end)
