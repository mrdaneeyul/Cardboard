/// @description Takes in an asset layer and "stands up" all sprites on that layer to be perpendicular to the floor.
/// @param {string,id.layer}	layer		The layer name or layer ID
/// @param {real}				[xOffset]	(Optional) The x offset of the layer 
/// @param {real}				[yOffset]	(Optional) The y offset of the layer
/// @param {real}				[zOffset]	(Optional) The z offset of the layer
/// @param {real}				[zAngle]	(Optional) Rotation of the sprite around the z-axis

function CbSpriteLayer(_layer, _xOffset = 0, _yOffset = 0, _zOffset = 0, _zAngle = 0)
{
    var _array = layer_get_all_elements(_layer);
    var _i = 0;
    repeat(array_length(_array))
    {
        var _asset = _array[_i];
        
        CbSpriteExt(layer_sprite_get_sprite(_asset),
					layer_sprite_get_index(_asset),
                    layer_sprite_get_x(_asset) + _xOffset, 
					layer_sprite_get_y(_asset) + _yOffset, 
					_zOffset,
                    layer_sprite_get_xscale(_asset),
					layer_sprite_get_yscale(_asset),
                    layer_sprite_get_angle(_asset),
					_zAngle,
                    layer_sprite_get_blend(_asset),
					layer_sprite_get_alpha(_asset),
                    false);
        
        ++_i;
    }
}