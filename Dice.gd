class Dice:
	static var RNG = RandomNumberGenerator.new()
	
	var _BASE_THROW: Callable = func():
		return str(RNG.randi() % self.faces + 1)
	
	var id: int
	var faces: int
	var is_multiplier: bool
	var throw_callable: Callable
	
	func _init(id: int,faces: int, is_multiplier: bool = false, throw_callable: Callable = _BASE_THROW):
		self.id = id
		self.faces = faces
		self.is_multiplier = is_multiplier
		self.throw_callable = throw_callable
	
	func throw() -> String:
		return self.throw_callable.call()
	
	### DICE INSTANCES
	static var dict: Dictionary = {
		"D4": Dice.new(1,4),
		"D6": Dice.new(2,6),
		"COIN": Dice.new(101,2,true, func():
			return "x" + str((Dice.RNG.randi() % 2) * 0.5 + 1))
	}
	


