class Dice:
	static var RNG = RandomNumberGenerator.new()
	
	var _BASE_THROW: Callable = func():
		return str(RNG.randi() % self.faces + 1)
	
	var id: int
	var faces: int
	var is_multiplier: bool
	var throw_callable: Callable
	var max_result: int
	
	func _init(id: int,faces: int, is_multiplier: bool = false, throw_callable: Callable = _BASE_THROW, max_result = faces):
		self.id = id
		self.faces = faces
		self.is_multiplier = is_multiplier
		self.throw_callable = throw_callable
		self.max_result = max_result
	
	func throw() -> String:
		return self.throw_callable.call()
	
	### DICE INSTANCES
	static var dict: Dictionary = {
		"D4": Dice.new(1,4),
		"D6": Dice.new(2,6),
		"D8": Dice.new(3,8),
		"COIN": Dice.new(101,2,true, func():
			return "x" + str((Dice.RNG.randi() % 2) * 0.5 + 1)),
		"D4_MULT_SIMPLE": Dice.new(102,4,true, func():
			return "x" + str((Dice.RNG.randi() % 4) + 1)),
		"D6_ONE_ONE_ONE_TWO_TWO_THREE": Dice.new(103,4,true, func():
			return "x" + str([1,1,1,2,2,3].pick_random())),
		"D20_MULT_RESULT_DIV_TEN": Dice.new(104,20,true, func():
			return "x" + str(((Dice.RNG.randi() % 20) + 1) / 10 + 1)),
		"D100_MULT_RESULT_DIV_TEN": Dice.new(105,100,true, func():
			return "x" + str(((Dice.RNG.randi() % 100) + 1) / 10 + 1)),
	}
	# TODO: 

