class_name GameStateMenu extends GameState



func _activate_state() -> void:
	for child in get_children():
		if child is CanvasItem:
			child.visible = false


func _enter_state() -> void:
	super()
	for child in get_children():
		if child is CanvasItem:
			child.visible = true


func _exit_state() -> void:
	super()
	await get_tree().process_frame
	for child in get_children():
		if child is CanvasItem:
			child.visible = false
