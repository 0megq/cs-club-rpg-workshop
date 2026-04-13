extends Node2D

var player_death_detected: bool = false
var win_detected: bool = false

func _ready() -> void:
	$Label.hide()
	$Button.hide()

func _physics_process(delta: float) -> void:
	if %Player.health <= 0 and !player_death_detected:
		player_death_detected = true
		await get_tree().create_timer(0.5).timeout
		$Label.text = "You Died!"
		$Label.show()
		$Button.show()
	
	var win := true
	for child in get_children():
		if child.is_in_group("enemy") and child.health > 0:
			win = false
	
	if win:
		win_detected = true
		$Label.text = "You Win!"
		$Label.show()
		$Button.show()
	

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
