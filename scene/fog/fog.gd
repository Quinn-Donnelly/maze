class_name Fog
extends Node

var format: Image.Format = Image.Format.FORMAT_RGBAH

@export var fog_sprite: Sprite2D
@export var tiles: TileMapLayer
@export var player: Player

var world_dimensions: Vector2i
var world_position: Vector2i

var fog: Image
var vision_image: Image
var vision_image_offset: Vector2

func _ready() -> void:
	_generate_fog()
	_update_fog()

func _process(_delta: float) -> void:
	if player.velocity.length():
		_update_fog()
	
func _generate_fog() -> void:
	world_dimensions = tiles.get_used_rect().size * tiles.tile_set.tile_size
	world_position = tiles.get_used_rect().position * tiles.tile_set.tile_size

	fog = Image.create(world_dimensions.x, world_dimensions.y, false, format)
	fog.fill(Color.BLACK)

	var fog_texture = ImageTexture.create_from_image(fog)
	fog_sprite.texture = fog_texture

	vision_image = player.vision_sprite.texture.get_image()
	vision_image.convert(format)
	vision_image_offset = vision_image.get_used_rect().size / 2

func _update_fog() -> void:
	var aligned_position = player.global_position - vision_image_offset
	var vision_rect = Rect2i(Vector2i.ZERO, vision_image.get_size())
	fog.blend_rect(vision_image, vision_rect, aligned_position) 
	var fog_texture = ImageTexture.create_from_image(fog)
	fog_sprite.texture = fog_texture
