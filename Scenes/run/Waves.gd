extends Node

const BUGS = {
	"1" = preload("res://Scenes/characters/bugs/beetle/beetle.tscn"),
	"2" = preload("res://Scenes/characters/bugs/D_fly/D_fly.tscn"),
	"3" = preload("res://Scenes/characters/bugs/Moth/mothj.tscn"),
}

signal wave_complete

var bugcount = 0:
	set(val):
		bugcount = val
		if bugcount <= 0:
			wave_complete.emit()

func _ready() -> void:
	Global.new_wave.connect(spawn_bugs)
	wave_complete.connect(Global.end_night)

func spawn_bugs() -> void:
	var wave = Global.wavecount
	var bosswave = (wave % 5 == 0)
	var new_bugcount = max(floori(2.5 * wave), 5)
	bugcount = new_bugcount
	if bosswave: bugcount *= 2
	for i in range(bugcount):
		var bug = (randi() % 3) + 1
		var instance = BUGS.get(str(bug)).instantiate()
		if instance:
			var randompos = find_child("spawnpoint" + str( (randi()%4) + 1)).global_position
			add_child(instance, true)
			instance.global_position = randompos
			instance.died.connect(bug_died)

func bug_died() -> void:
	bugcount -= 1
