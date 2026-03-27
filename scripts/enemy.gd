extends CharacterBody2D

const ENEMY_MAX_SPEED: float = 40

var max_health: int = 5
var health: int = 5

@onready var sprite: CharacterSprite = $Sprite2D

func _physics_process(_delta: float) -> void:
	if health > 0:
		move()
	animate()

func move() -> void:
	var to_player: Vector2 = %Player.position - position
	var input: Vector2 = to_player.normalized()
	velocity = input * ENEMY_MAX_SPEED
	move_and_slide()


func animate() -> void:
	# Do the direction
	var to_player: Vector2 = %Player.position - position
	var input: Vector2 = to_player.normalized()
	if input.x > 0:
		sprite.dir = sprite.Dir.RIGHT
	elif input.x < 0:
		sprite.dir = sprite.Dir.LEFT
	if abs(input.y) > abs(input.x):
		if input.y < 0:
			sprite.dir = sprite.Dir.UP
		elif input.y > 0:
			sprite.dir = sprite.Dir.DOWN
		
	# Do the walk and idle
	const frame_time: float = 0.1
	if velocity == Vector2.ZERO:
		sprite.anim_frame = 1
	else:
		# Generate a frame index based on elapsed time
		var index := Time.get_ticks_msec() / int(frame_time * 1000) % 4
		match (index):
			0:
				sprite.anim_frame = 0
			1:
				sprite.anim_frame = 1
			2:
				sprite.anim_frame = 2
			3:
				sprite.anim_frame = 1
	


func damage() -> void:
	#health = health - 1
	health -= 1
	$Hit.play()
	print(health)
	if health <= 0:
		$Dead.play()
		$Sprite2D.hide()
		$DeadSprite.show()


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage()
