extends Control

signal purchase_gain
signal purchase_extra
signal purchase_grate
signal purchase_ghosts
signal purchase_powerups

var disabled_text: Color = Color("b8b8b8")
var enabled_text: Color = Color("ffffff")


func _process(_delta):
	check_upgrade(%GhostsButton, %GhostsPrice, Globals.GhostsPrice, Globals.GhostsUpgCount, 5)
	check_upgrade(%GrateButton, %GratePrice, Globals.GratePrice, Globals.GrateUpgCount, 15)
	check_upgrade(%ExtraButton, %ExtraPrice, Globals.ExtraPrice, Globals.ExtraUpgCount, 4)
	check_upgrade(%GainButton, %GainPrice, Globals.GainPrice, Globals.GainUpgCount, 10)
	check_upgrade(%PowerupsButton, %PowerupsPrice, Globals.PowerupsPrice, Globals.PowerupsUpgCount, 4)
	
	%GainTitle.text = "GAIN (" + str(Globals.GainUpgCount) + "/10)"
	%ExtraTitle.text = "EXTRA SPAWNS (" + str(Globals.ExtraUpgCount) + "/4)"
	%GrateTitle.text = "SPAWN RATE (" + str(Globals.GrateUpgCount) + "/15)"
	%GhostsTitle.text = "AUTO COLLECT (" + str(Globals.GhostsUpgCount) + "/5)"
	%PowerupsTitle.text = "POWER-UPS (" + str(Globals.PowerupsUpgCount) + "/4)"


func _ready():
	%GratePrice.text = Globals.fix_nums(Globals.GratePrice)
	%ExtraPrice.text = Globals.fix_nums(Globals.ExtraPrice)
	%GhostsPrice.text = Globals.fix_nums(Globals.GhostsPrice)
	%GainPrice.text = Globals.fix_nums(Globals.GainPrice)
	%PowerupsPrice.text = Globals.fix_nums(Globals.PowerupsPrice)

func check_upgrade(button, price_label, price, upg_count, max_upg_count):
	var is_disabled = Globals.Grapes < price or upg_count >= max_upg_count
	button.get_child(0).disabled = is_disabled
	price_label.modulate = disabled_text if is_disabled else enabled_text
	price_label.text = "DONE" if upg_count >= max_upg_count else Globals.fix_nums(price)

func _on_gain_button_button_pressed():
	Globals.GainUpgCount += 1
	purchase_gain.emit()

func _on_extra_button_button_pressed():
	Globals.ExtraUpgCount += 1
	purchase_extra.emit()

func _on_grate_button_button_pressed():
	Globals.GrateUpgCount += 1
	purchase_grate.emit()

func _on_ghosts_button_button_pressed():
	Globals.GhostsUpgCount += 1
	purchase_ghosts.emit()

func _on_powerups_button_button_pressed():
	Globals.PowerupsUpgCount += 1
	purchase_powerups.emit()
