extends "res://Scenes&Scripts/Characters/BaseEnemy.gd"

var minRange : float = 200
var maxRange : float = 300
var rangeMidPoint : float = (maxRange + minRange)/2

func _ready():
	enemyType = ENEMYTYPES.Red
	gun = $Machinegun
	gun.user = self
	bulletSpawnDistance = 30
	gunDrop = GUNDROPS.MachineGun


func _process(delta):
#	dodgeCooldownCounter -= delta
	handle_shooting(delta)


func _physics_process(delta):
	handle_movement(delta)


func handle_movement(delta):
	if not GlobalReferences.playerExists:
		return
	
	look_at(player.position)
	
	var dFromPlayer = (player.position - position).length()
	if dFromPlayer > maxRange:
		velocity = (player.position - position).normalized() * enemySpeed
	elif dFromPlayer < minRange:
		velocity = (position - player.position).normalized() * enemySpeed
	else:
		velocity = (player.position - position).normalized() * ((dFromPlayer - rangeMidPoint) / (0.5*(maxRange-minRange))) * enemySpeed
		if abs(dFromPlayer - rangeMidPoint) <= (maxRange-minRange)*0.1:
			velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity)


func handle_shooting(delta):
	if not GlobalReferences.playerExists:
		return
	
	if (player.position - position).length() > maxRange:
		return
	.handle_shooting(delta)







