extends Node2D

var directionVector : Vector2
var velocity : Vector2
var speed : float = 2
var deceleration : float = 5


var gunType : int
var player : KinematicBody2D
var pickUpRange : float = 75
var lifeSpan : float = 7
var beingPickedUp : bool = false



func _ready():
	GlobalReferences.tween.connect("tween_completed", self, "move_to_player_finished")
	player = GlobalReferences.player
	velocity = directionVector * speed


func _process(delta):
	if not GlobalReferences.playerExists:
		return
	position = position + velocity
	velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	var distanceFromPlayer = (position - player.position).length()
	if distanceFromPlayer <= pickUpRange and not beingPickedUp:
		on_picked_up()
		beingPickedUp = true
	
	lifeSpan -= delta
	if lifeSpan <= 0:
		queue_free()


func on_picked_up():
	
	var tween : Tween = GlobalReferences.tween
	tween.interpolate_property(self, "position", position, player.position, 0.1) # Tween nodes are useful for animating properties in code, here we animate the position of the pick up to the player position
	if not tween.is_active():
		tween.start()
	
	


func move_to_player_finished(object, key):
	if object != self:
		return
	
	
	var newGun : Node
	player.get_new_gun(gunType)
	
	queue_free()




