class Chip:
	static var RNG = RandomNumberGenerator.new()
	
	static var dict: Dictionary = {
		"MULT_X2_IF_RESULT_PAIR":Chip.new(
			1,"Double or halve it", # ID & name
			"Doubles the result if the result is pair.",# Description
			func(chip: Chip,result: int, throws_left: int, dice: Array,throw: Array[String]): return result %2 == 0, # Trigger condition
			2), # Multiplier
		"MULT_X1p5_IF_THROW_HAS_ONE":Chip.new(
			1,"Troublesorter", # ID & name
			"Multiplies the result by 1.5 if a one was thrown.",# Description
			func(chip: Chip,result: int, throws_left: int, dice: Array,throw: Array[String]): return throw.has("1"),# Trigger condition
			1.5),# Multiplier
		"MULT_X1p25_IF_RESULT_LOWER_THAN_MEDIAN":Chip.new(
			1,"Fairness by all means", # ID & name
			"Multiplies the result by 1.25 the result was lower than the median throw.", # Description
			func(chip: Chip,result: int, throws_left: int, dice: Array,throw: Array[String]): # Trigger condition
				var throw_max = 0
				for dice_instance in dice:
					if not dice_instance.is_multiplier:
						throw_max += dice_instance.faces
				var median = throw_max / len(dice)
				return result < median,
				1.25), # Multiplier
		"MULT_X2_LOWER_0p25_EACH_MULT":Chip.new(
			1,"Fairness by all means" ,# ID & name
			"Multiplies the result by 1.25 the result was lower than the median throw.", # Description
			func(chip: Chip,result: int, throws_left: int, dice: Array,throw: Array[String]): # Trigger condition
				if chip.multiplier > 1:
					chip.multiplier -= 0.25
				return true,
				2), # Multiplier
	}
	
	var id: int
	var name: String
	var description: String
	var should_trigger_callable: Callable
	var multiplier: float
		
	func _init(id: int,name: String, description: String, should_trigger_func: Callable, multiplier: float = 1):
		self.id = id
		self.name = name
		self.description = description
		self.should_trigger_callable = should_trigger_func
		self.multiplier = multiplier

	func should_trigger(result: int, throws_left: int, dice: Array, throw: Array[String]):
		return self.should_trigger_callable.call(self,result,throws_left,dice, throw)
	
	
	
	
	#Cartas de multiplicador
	# si resultado par x2 sino x0.5
	# si un dado tiene un 1, resultado x1.5
	# resultado x2, por cada tirada, mult -0.25
	# | ------------------------ |
	# Bolsas de dados
	# Cartas de multiplicador
	# Dados concretos
