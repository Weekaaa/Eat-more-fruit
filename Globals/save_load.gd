extends Node

const SAVE_PATH := "user://player_data.tres"
var player_data = PlayerData.new()

func save_game():
	player_data.ExtraPrice = Globals.ExtraPrice
	player_data.GainPrice = Globals.GainPrice
	player_data.GhostsPrice = Globals.GhostsPrice
	player_data.GrapesPrice = Globals.GrapesPrice
	player_data.GratePrice = Globals.GratePrice
	player_data.PowerupsPrice = Globals.PowerupsPrice
	player_data.RangePrice = Globals.RangePrice
	player_data.RatePrice = Globals.RatePrice
	player_data.SizePrice = Globals.SizePrice
	player_data.SpeedPrice = Globals.SpeedPrice
	
	player_data.ExtraUpgCount = Globals.ExtraUpgCount
	player_data.GainUpgCount = Globals.GainUpgCount
	player_data.GhostsUpgCount = Globals.GhostsUpgCount
	player_data.GrapesUpgCount = Globals.GrapesUpgCount
	player_data.GrateUpgCount = Globals.GrateUpgCount
	player_data.PowerupsUpgCount = Globals.PowerupsUpgCount
	player_data.RangeUpgCount = Globals.RangeUpgCount
	player_data.RateUpgCount = Globals.RateUpgCount
	player_data.SizeUpgCount = Globals.SizeUpgCount
	player_data.SpeedUpgCount = Globals.SpeedUpgCount
	
	player_data.strawberries = Globals.Strawberries
	player_data.grapes = Globals.Grapes
	
	player_data.locked_powerups = Globals.locked_power_ups
	player_data.unlocked_powerups = Globals.power_ups
	
	ResourceSaver.save(player_data, SAVE_PATH)

func load_game():
	if ResourceLoader.exists(SAVE_PATH):
		var loaded_data : PlayerData = ResourceLoader.load(SAVE_PATH)
		if loaded_data:
			Globals.ExtraUpgCount = loaded_data.ExtraUpgCount
			Globals.GainUpgCount = loaded_data.GainUpgCount
			Globals.GhostsUpgCount = loaded_data.GhostsUpgCount
			Globals.GrapesUpgCount = loaded_data.GrapesUpgCount
			Globals.GrateUpgCount = loaded_data.GrateUpgCount
			Globals.PowerupsUpgCount = loaded_data.PowerupsUpgCount
			Globals.RangeUpgCount = loaded_data.RangeUpgCount
			Globals.RateUpgCount = loaded_data.RateUpgCount
			Globals.SizeUpgCount = loaded_data.SizeUpgCount
			Globals.SpeedUpgCount = loaded_data.SpeedUpgCount
			
			Globals.GainPrice = loaded_data.GainPrice
			Globals.RatePrice = loaded_data.RatePrice
			Globals.SizePrice = loaded_data.SizePrice
			Globals.ExtraPrice = loaded_data.ExtraPrice
			Globals.GratePrice = loaded_data.GratePrice
			Globals.RangePrice = loaded_data.RangePrice
			Globals.SpeedPrice = loaded_data.SpeedPrice
			Globals.GhostsPrice = loaded_data.GhostsPrice
			Globals.GrapesPrice = loaded_data.GrapesPrice
			Globals.PowerupsPrice = loaded_data.PowerupsPrice
			
			Globals.Strawberries = loaded_data.strawberries
			Globals.Grapes = loaded_data.grapes
			
			Globals.locked_power_ups = player_data.locked_powerups
			Globals.power_ups = player_data.unlocked_powerups
