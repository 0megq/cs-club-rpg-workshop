extends CharacterBody2D

@export var max_health: int = 5

@onready var health: int = max_health

func damage() -> void:
	# decrease health and display
	health -= 1
	print("OW!")
	print(name + " health: " + str(health))
	
	# delete the enemy if 0 hp
	if health <= 0:
		queue_free()
