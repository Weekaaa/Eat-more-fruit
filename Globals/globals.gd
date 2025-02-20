extends Node

# player collectables
var entities: int = 0
var Strawberries: int = 200
var Grapes: int = 2000

# upgrade counts
var SpeedUpgCount: int = 0
var RateUpgCount: int = 0
var RangeUpgCount: int = 0
var SizeUpgCount: int = 0
var GrapesUpgCount: int = 0
var GrateUpgCount: int = 0
var ExtraUpgCount: int = 0
var GhostsUpgCount: int = 0
var GainUpgCount: int = 0

# upgrade prices
var SpeedPrice: int = 50
var RatePrice: int = 100
var RangePrice: int = 75
var SizePrice: int = 1000
var GrapesPrice: int = 100
var GratePrice: int = 100
var ExtraPrice: int = 100
var GhostsPrice: int = 100
var GainPrice: int = 100

func fix_nums(num):
	var suffixes = ["", "K", "M", "B", "T"]
	var magnitude = 0
	
	while num >= 1000 and magnitude < suffixes.size() - 1:
		num /= 1000.0
		magnitude += 1
	
	if magnitude == 0:
		return str(int(num))
	else:
		return "%.1f%s" % [num, suffixes[magnitude]]
