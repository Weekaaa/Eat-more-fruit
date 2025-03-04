extends Control

signal purchase_speed
signal purchase_rate
signal purchase_range
signal purchase_size
signal purchase_grapes

var disabled_text: Color = Color("b8b8b8")
var enabled_text: Color = Color("ffffff")


func _process(_delta):
	check_upgrade(%RateButton, %RatePrice, Globals.RatePrice, Globals.RangeUpgCount, 15)
	check_upgrade(%SizeButton, %SizePrice, Globals.SizePrice, Globals.SizeUpgCount, 2)
	check_upgrade(%RangeButton, %RangePrice, Globals.RangePrice, Globals.RangeUpgCount, 15)
	check_upgrade(%SpeedButton, %SpeedPrice, Globals.SpeedPrice, Globals.SpeedUpgCount, 10)
	check_upgrade(%GrapesButton, %GrapesPrice, Globals.GrapesPrice, Globals.GrapesUpgCount, 1)
	
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

func check_upgrade(button, price_label, price, upg_count, max_upg_count):
	var is_disabled = Globals.Strawberries < price or upg_count >= max_upg_count
	button.get_child(0).disabled = is_disabled
	price_label.modulate = disabled_text if is_disabled else enabled_text
	price_label.text = "DONE" if upg_count >= max_upg_count else Globals.fix_nums(price)

func _on_speed_button_button_pressed():
	Globals.SpeedUpgCount += 1
	purchase_speed.emit()

func _on_rate_button_button_pressed():
	Globals.RateUpgCount += 1
	purchase_rate.emit()

func _on_range_button_button_pressed():
	Globals.RangeUpgCount += 1
	purchase_range.emit()

func _on_size_button_button_pressed():
	Globals.SizeUpgCount += 1
	purchase_size.emit()

func _on_grapes_button_button_pressed():
	Globals.GrapesUpgCount += 1
	purchase_grapes.emit()
