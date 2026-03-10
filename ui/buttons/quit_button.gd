class_name QuitButton extends UIButton


func _on_pressed() -> void:
	# wait to hear the click sound
	await get_tree().create_timer(0.25).timeout 
	Game.quit()
