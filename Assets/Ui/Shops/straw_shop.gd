extends Control

signal purchase_speed
signal purchase_rate
signal purchase_range

var SpeedPrice: int = 50
var RatePrice: int = 100
var RangePrice: int = 75

func _ready():
	%SpeedPrice.text = str(SpeedPrice)
	%RatePrice.text = str(RatePrice)
	%RangePrice.text = str(RangePrice)

func _on_speed_button_button_pressed():
	purchase_speed.emit()

func _on_rate_button_button_pressed():
	purchase_rate.emit()

func _on_range_button_button_pressed():
	purchase_range.emit()
