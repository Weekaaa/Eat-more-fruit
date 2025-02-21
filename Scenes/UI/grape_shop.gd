extends Control

signal purchase_gain
signal purchase_extra
signal purchase_grate
signal purchase_ghosts
signal purchase_powerups

var disabled_text: Color = Color("b8b8b8")
var enabled_text: Color = Color("ffffff")


func _process(_delta):
	if Globals.Grapes < Globals.GhostsPrice or Globals.GhostsUpgCount >= 10:
		%GhostsButton.get_child(0).disabled = true
		%GhostsPrice.modulate = disabled_text
	else:
		%GhostsButton.get_child(0).disabled = false
		%GhostsPrice.modulate = enabled_text
		
	if Globals.Grapes < Globals.GratePrice or Globals.GrateUpgCount >= 15:
		%GrateButton.get_child(0).disabled = true
		%GratePrice.modulate = disabled_text
	else:
		%GrateButton.get_child(0).disabled = false
		%GratePrice.modulate = enabled_text
		
	if Globals.Grapes < Globals.ExtraPrice or Globals.ExtraUpgCount >= 4:
		%ExtraButton.get_child(0).disabled = true
		%ExtraPrice.modulate = disabled_text
	else:
		%ExtraButton.get_child(0).disabled = false
		%ExtraPrice.modulate = enabled_text
		
	if Globals.Grapes < Globals.GainPrice or Globals.GainUpgCount >= 10:
		%GainButton.get_child(0).disabled = true
		%GainPrice.modulate = disabled_text
	else:
		%GainButton.get_child(0).disabled = false
		%GainPrice.modulate = enabled_text
		
	if Globals.Grapes < Globals.PowerupsPrice or Globals.PowerupsUpgCount >= 4:
		%PowerupsButton.get_child(0).disabled = true
		%PowerupsPrice.modulate = disabled_text
	else:
		%PowerupsButton.get_child(0).disabled = false
		%PowerupsPrice.modulate = enabled_text



func _ready():
	%GratePrice.text = Globals.fix_nums(Globals.GratePrice)
	%ExtraPrice.text = Globals.fix_nums(Globals.ExtraPrice)
	%GhostsPrice.text = Globals.fix_nums(Globals.GhostsPrice)
	%GainPrice.text = Globals.fix_nums(Globals.GainPrice)
	%PowerupsPrice.text = Globals.fix_nums(Globals.PowerupsPrice)

func _on_gain_button_button_pressed():
	Globals.GainUpgCount += 1
	purchase_gain.emit()
	%GainTitle.text = "GAIN (" + str(Globals.GainUpgCount) + "/10)"
	%GainPrice.text = Globals.fix_nums(Globals.GainPrice)

func _on_extra_button_button_pressed():
	Globals.ExtraUpgCount += 1
	purchase_extra.emit()
	%ExtraTitle.text = "EXTRA SPAWNS (" + str(Globals.ExtraUpgCount) + "/4)"
	%ExtraPrice.text = Globals.fix_nums(Globals.ExtraPrice)

func _on_grate_button_button_pressed():
	Globals.GrateUpgCount += 1
	purchase_grate.emit()
	%GrateTitle.text = "SPAWN RATE (" + str(Globals.GrateUpgCount) + "/15)"
	%GratePrice.text = Globals.fix_nums(Globals.GratePrice)

func _on_ghosts_button_button_pressed():
	Globals.GhostsUpgCount += 1
	purchase_ghosts.emit()
	%GhostsTitle.text = "AUTO COLLECT (" + str(Globals.GhostsUpgCount) + "/10)"
	%GhostsPrice.text = Globals.fix_nums(Globals.GhostsPrice)

func _on_powerups_button_button_pressed():
	Globals.PowerupsUpgCount += 1
	purchase_powerups.emit()
	%PowerupsTitle.text = "POWER-UPS (" + str(Globals.PowerupsUpgCount) + "/4)"
	%PowerupsPrice.text = Globals.fix_nums(Globals.PowerupsPrice)
