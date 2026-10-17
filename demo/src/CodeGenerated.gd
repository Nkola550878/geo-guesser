extends Node

var terrain: Terrain3D


func _ready() -> void:
	terrain = await create_terrain()

func create_terrain() -> Terrain3D:
	# Create a terrain
	var terrain := Terrain3D.new()
	terrain.name = "Terrain3D"
	add_child(terrain, true)

	# Set material and assets
	terrain.material.world_background = Terrain3DMaterial.NONE 

	# Generate height map w/ 32-bit noise and import it with scale
	var noise := FastNoiseLite.new()
	noise.frequency = 0.0005
	var img: Image = Image.create_empty(2048, 2048, false, Image.FORMAT_RF)
	for x in img.get_width():
		for y in img.get_height():
			var c1 = 0.000002;
			var height : float = sin(c1 * (pow(x - 1024, 2) + pow(y - 1024, 2)) + PI / 2);
			img.set_pixel(x, y, Color(height, height, height));
	terrain.region_size = 1024
	terrain.data.import_images([img, null, null], Vector3(-1024, 0, -1024), 0.0, 150.0)

	# Enable the next line and `Debug/Visible Collision Shapes` to see collision
	#terrain.collision.mode = Terrain3DCollision.DYNAMIC_EDITOR

	return terrain
