extends Area2D

export var world: int = 0
export var level: int = 0

var with_player: bool = false

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var anim_player_glow: AnimationPlayer = $AnimationPlayerGlow


func _ready() -> void:
	connect("body_entered", self, "_body_entered")
	connect("body_exited", self, "_body_exited")
	show()


func _input(event: InputEvent) -> void:
	if event.is_action_released("interact") and with_player and not UI.menu_transitioning:
		Signals.emit_signal("level_completed")
		anim_player.play("hide")


func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		with_player = true
		anim_player_glow.play("glow")


func _body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		with_player = false
		anim_player_glow.play_backwards("glow")

