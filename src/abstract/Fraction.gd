extends Node
class_name Fraction

var num
var denom
const epsilon = 0.00000001

func _ready():
	num = 0
	denom = 1

func calc_value() -> float:
	return num / denom
	
func compare(other: Fraction) -> int:
	if calc_value() < other.calc_value():
		return -1
	elif abs(calc_value() - other.calc_value()) < epsilon:
		return 0
	else:
		return 1
		
func add(other: Fraction) -> void:
	var gcd = calc_gcd(denom, other.denom)
	var final_denom = (denom * other.denom) / gcd
	var final_num = num * (final_denom / denom) 
	+ other.num * (final_denom / other.denom)
	
	num = final_num
	denom = final_denom
	
func add_value(value: float) -> void:
	num += value * denom
	
func substract(other: Fraction) -> void:
	other.num *= -1
	add(other)
	
func substract_value(value: float) -> void:
	add_value(-value)
	
# calculation of greatest common divisor
func calc_gcd(a: int, b: int) -> int:
	if a == 0:
		return b
	return calc_gcd(b % a, b)
 
