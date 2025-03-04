extends Control

signal purchase_gain
signal purchase_extra
signal purchase_grate
signal purchase_ghosts
signal purchase_powerups

var disabled_text: Color = Color("b8b8b8")
var enabled_text: Color = Color("ffffff")


func _process(_delta):
	if Globals.Grapes < Globals.GhostsPrice or Globals.GhostsUpgCount >= 5:
		%GhostsButton.get_child(0).disabled = true
		%GhostsPrice.modulate = disabled_text
		if Globals.GhostsUpgCount >= 5:
			%GhostsPrice.text = "DONE"
		else:
			%GhostsPrice.text = Globals.fix_nums(Globals.GhostsPrice)
	else:
		%GhostsButton.get_child(0).disabled = false
		%GhostsPrice.modulate = enabled_text
		%GhostsPrice.text = Globals.fix_nums(Globals.GhostsPrice)
		
	if Globals.Grapes < Globals.GratePrice or Globals.GrateUpgCount >= 15:
		%GrateButton.get_child(0).disabled = true
		%GratePrice.modulate = disabled_text
		if Globals.GrateUpgCount >= 15:
			%GratePrice.text = "DONE"
		else:
			%GratePrice.text = Globals.fix_nums(Globals.GratePrice)
	else:
		%GrateButton.get_child(0).disabled = false
		%GratePrice.modulate = enabled_text
		%GratePrice.text = Globals.fix_nums(Globals.GratePrice)
		
	if Globals.Grapes < Globals.ExtraPrice or Globals.ExtraUpgCount >= 4:
		%ExtraButton.get_child(0).disabled = true
		%ExtraPrice.modulate = disabled_text
		if Globals.ExtraUpgCount >= 4:
			%ExtraPrice.text = "DONE"
		else:
			%ExtraPrice.text = Globals.fix_nums(Globals.ExtraPrice)
	else:
		%ExtraButton.get_child(0).disabled = false
		%ExtraPrice.modulate = enabled_text
		%ExtraPrice.text = Globals.fix_nums(Globals.ExtraPrice)
		
	if Globals.Grapes < Globals.GainPrice or Globals.GainUpgCount >= 10:
		%GainButton.get_child(0).disabled = true
		%GainPrice.modulate = disabled_text
		if Globals.GainUpgCount >= 10:
			%GainPrice.text = "DONE"
		else:
			%GainPrice.text = Globals.fix_nums(Globals.GainPrice)
	else:
		%GainButton.get_child(0).disabled = false
		%GainPrice.modulate = enabled_text
		%GainPrice.text = Globals.fix_nums(Globals.GainPrice)
		
	if Globals.Grapes < Globals.PowerupsPrice or Globals.PowerupsUpgCount >= 4:
		%PowerupsButton.get_child(0).disabled = true
		%PowerupsPrice.modulate = disabled_text
		if Globals.PowerupsUpgCount >= 4:
			%PowerupsPrice.text = "DONE"
		else:
			%PowerupsPrice.text = Globals.fix_nums(Globals.PowerupsPrice)
	else:
		%PowerupsButton.get_child(0).disabled = false
		%PowerupsPrice.modulate = enabled_text
		%PowerupsPrice.text = Globals.fix_nums(Globals.PowerupsPrice)
	
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

func _on_gain_button_button_pressed():
	Globals.GainUpgCount += 1
	purchase_gain.emit()
	if Globals.GainUpgCount < 10:
		%GainPrice.text = Globals.fix_nums(Globals.GainPrice)
	else:
		%GainPrice.text = "DONE"

func _on_extra_button_button_pressed():
	Globals.ExtraUpgCount += 1
	purchase_extra.emit()
	if Globals.ExtraUpgCount < 4:
		%ExtraPrice.text = Globals.fix_nums(Globals.ExtraPrice)
	else:
		%ExtraPrice.text = "DONE"

func _on_grate_button_button_pressed():
	Globals.GrateUpgCount += 1
	purchase_grate.emit()
	if Globals.GrateUpgCount < 15:
		%GratePrice.text = Globals.fix_nums(Globals.GratePrice)
	else:
		%GratePrice.text = "DONE"

func _on_ghosts_button_button_pressed():
	Globals.GhostsUpgCount += 1
	purchase_ghosts.emit()
	if Globals.GhostsUpgCount < 5:
		%GhostsPrice.text = Globals.fix_nums(Globals.GhostsPrice)
	else:
		%GhostsPrice.text = "DONE"

func _on_powerups_button_button_pressed():
	Globals.PowerupsUpgCount += 1
	purchase_powerups.emit()
	if Globals.PowerupsUpgCount < 4:
		%PowerupsPrice.text = Globals.fix_nums(Globals.PowerupsPrice)
	else:
		%PowerupsPrice.text = "DONE"
