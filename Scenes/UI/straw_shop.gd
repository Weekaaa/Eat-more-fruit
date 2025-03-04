extends Control

signal purchase_speed
signal purchase_rate
signal purchase_range
signal purchase_size
signal purchase_grapes

var disabled_text: Color = Color("b8b8b8")
var enabled_text: Color = Color("ffffff")


func _process(_delta):
	if Globals.Strawberries < Globals.SpeedPrice or Globals.SpeedUpgCount >= 10:
		%SpeedButton.get_child(0).disabled = true
		%SpeedPrice.modulate = disabled_text
		if Globals.SpeedUpgCount >= 10:
			%SpeedPrice.text = "DONE"
		else:
			%SpeedPrice.text = Globals.fix_nums(Globals.SpeedPrice)
	else:
		%SpeedButton.get_child(0).disabled = false
		%SpeedPrice.modulate = enabled_text
		%SpeedPrice.text = Globals.fix_nums(Globals.SpeedPrice)
	
	if Globals.Strawberries < Globals.RatePrice or Globals.RateUpgCount >= 15:
		%RateButton.get_child(0).disabled = true
		%RatePrice.modulate = disabled_text
		if Globals.RateUpgCount >= 15:
			%RatePrice.text = "DONE"
		else:
			%RatePrice.text = Globals.fix_nums(Globals.RatePrice)
	else:
		%RateButton.get_child(0).disabled = false
		%RatePrice.modulate = enabled_text
		%RatePrice.text = Globals.fix_nums(Globals.RatePrice)
	
	if Globals.Strawberries < Globals.RangePrice or Globals.RangeUpgCount >= 15:
		%RangeButton.get_child(0).disabled = true
		%RangePrice.modulate = disabled_text
		if Globals.RangeUpgCount >= 15:
			%RangePrice.text = "DONE"
		else:
			%RangePrice.text = Globals.fix_nums(Globals.RangePrice)
	else:
		%RangeButton.get_child(0).disabled = false
		%RangePrice.modulate = enabled_text
		%RangePrice.text = Globals.fix_nums(Globals.RangePrice)
	
	if Globals.Strawberries < Globals.SizePrice or Globals.SizeUpgCount >= 2:
		%SizeButton.get_child(0).disabled = true
		%SizePrice.modulate = disabled_text
		if Globals.SizeUpgCount >= 2:
			%SizePrice.text = "DONE"
		else:
			%SizePrice.text = Globals.fix_nums(Globals.SizePrice)
	else:
		%SizeButton.get_child(0).disabled = false
		%SizePrice.modulate = enabled_text
		%SizePrice.text = Globals.fix_nums(Globals.SizePrice)
	
	if Globals.Strawberries < Globals.GrapesPrice or Globals.GrapesUpgCount >= 1:
		%GrapesButton.get_child(0).disabled = true
		%GrapesPrice.modulate = disabled_text
		if Globals.GrapesUpgCount >= 1:
			%GrapesPrice.text = "DONE"
		else:
			%GrapesPrice.text = Globals.fix_nums(Globals.GrapesPrice)
	else:
		%GrapesButton.get_child(0).disabled = false
		%GrapesPrice.modulate = enabled_text
		%GrapesPrice.text = Globals.fix_nums(Globals.GrapesPrice)
	
	%SpeedTitle.text = "SPEED (" + str(Globals.SpeedUpgCount) + "/10)"
	%RateTitle.text = "SPAWN RATE (" + str(Globals.RateUpgCount) + "/15)"
	%RangeTitle.text = "GRAB RANGE (" + str(Globals.RangeUpgCount) + "/15)"
	%SizeTitle.text = "FRUIT SIZE (" + str(Globals.SizeUpgCount) + "/2)"
	%GrapesTitle.text = "UNLOCK GRAPES (" + str(Globals.GrapesUpgCount) + "/1)"


func _ready():
	%SpeedPrice.text = Globals.fix_nums(Globals.SpeedPrice)
	%RatePrice.text = Globals.fix_nums(Globals.RatePrice)
	%RangePrice.text = Globals.fix_nums(Globals.RangePrice)
	%SizePrice.text = Globals.fix_nums(Globals.SizePrice)
	%GrapesPrice.text = Globals.fix_nums(Globals.GrapesPrice)

func _on_speed_button_button_pressed():
	Globals.SpeedUpgCount += 1
	purchase_speed.emit()
	if Globals.SpeedUpgCount < 10:
		%SpeedPrice.text = Globals.fix_nums(Globals.SpeedPrice)
	else:
		%SpeedPrice.text = "DONE"

func _on_rate_button_button_pressed():
	Globals.RateUpgCount += 1
	purchase_rate.emit()
	if Globals.RateUpgCount < 15:
		%RatePrice.text = Globals.fix_nums(Globals.RatePrice)
	else:
		%RatePrice.text = 'DONE'

func _on_range_button_button_pressed():
	Globals.RangeUpgCount += 1
	purchase_range.emit()
	if Globals.RangeUpgCount < 15:
		%RangePrice.text = Globals.fix_nums(Globals.RangePrice)
	else:
		%RangePrice.text = 'DONE'

func _on_size_button_button_pressed():
	Globals.SizeUpgCount += 1
	purchase_size.emit()
	if Globals.SizeUpgCount < 2:
		%SizePrice.text = Globals.fix_nums(Globals.SizePrice)
	else:
		%SizePrice.text = 'DONE'

func _on_grapes_button_button_pressed():
	Globals.GrapesUpgCount += 1
	purchase_grapes.emit()
