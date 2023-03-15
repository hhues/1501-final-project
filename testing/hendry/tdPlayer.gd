extends KinematicBody2D


export var speed = 500
export var friction = 0.2
export var acceleration = 0.4

var input_dir = Vector2.ZERO

onready var hand = get_node("Hand")
onready var inventory = get_node("Hand/Inventory")


var screensize


# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	pass # Replace with function body.


func get_input():
	input_dir = Vector2.ZERO

	if Input.is_action_pressed("player_right"):
		input_dir.x += 1
	
	if Input.is_action_pressed("player_left"):
		input_dir.x -= 1
	
	if Input.is_action_pressed("player_up"):
		input_dir.y -= 1

	if Input.is_action_pressed("player_down"):
		input_dir.y += 1
	
	input_dir = input_dir.normalized()


func sucking():
	pass


func shooting():
	pass


func _physics_process(delta):
	get_input()
	input_dir = move_and_slide(input_dir * speed)
	
	var mouse = get_global_mouse_position()
	
	# don't get the character confused with a close mouse distance
	if mouse.distance_to(self.position) > 50:
		look_at(get_global_mouse_position())
	
	# point the hand towards the mouse
	if mouse.distance_to(self.position) > 100:
		var hand_to_mouse_distance = hand.global_position.distance_to(mouse)
		var hand_to_body_distance = hand.global_position.distance_to(self.global_position)
		var hand_rotation = asin(hand_to_body_distance / hand_to_mouse_distance)
		hand.rotation = -hand_rotation


func _process(delta):
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

