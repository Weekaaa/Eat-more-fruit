extends Control

signal purchase_speed
signal purchase_rate
signal purchase_range

var upgrade_prices = [Globals.SpeedPrice, Globals.RatePrice, Globals.RangePrice]
var disabled_text: Color = Color("b8b8b8")
var enabled_text: Color = Color("ffffff")

func _process(_delta):
	if Globals.Strawberries < Globals.SpeedPrice:
		%SpeedButton.get_child(0).disabled = true
		%SpeedPrice.modulate = disabled_text
	else:
		%SpeedButton.get_child(0).disabled = false
		%SpeedPrice.modulate = enabled_text
		
	if Globals.Strawberries < Globals.RatePrice:
		%RateButton.get_child(0).disabled = true
		%RatePrice.modulate = disabled_text
	else:
		%RateButton.get_child(0).disabled = false
		%RatePrice.modulate = enabled_text
		
	if Globals.Strawberries < Globals.RangePrice:
		%RangeButton.get_child(0).disabled = true
		%RangePrice.modulate = disabled_text
	else:
		%RangeButton.get_child(0).disabled = false
		%RangePrice.modulate = enabled_text


func _ready():
	%SpeedPrice.text = str(Globals.SpeedPrice)
	%RatePrice.text = str(Globals.RatePrice)
	%RangePrice.text = str(Globals.RangePrice)

func _on_speed_button_button_pressed():
	purchase_speed.emit()
	Globals.SpeedUpgCount += 1
	%SpeedTitle.text = "SPEED (" + str(Globals.SpeedUpgCount) + "/30)"
	%SpeedPrice.text = Globals.fix_nums(Globals.SpeedPrice)

func _on_rate_button_button_pressed():
	purchase_rate.emit()
	Globals.RateUpgCount += 1
	%RateTitle.text = "SPAWN RATE (" + str(Globals.RateUpgCount) + "/15)"
	%RatePrice.text = Globals.fix_nums(Globals.RatePrice)

func _on_range_button_button_pressed():
	purchase_range.emit()
	Globals.RangeUpgCount += 1
	%RangePrice.text = Globals.fix_nums(Globals.RangePrice)
	%RangeTitle.text = "GRAB RANGE (" + str(Globals.RangeUpgCount) + "/20)"
