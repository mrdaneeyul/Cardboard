/// Draws a sprite parallel to the floor ("lying down")
/// 
/// This function presumes that the camera is pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the sprite may not be immediately drawn
/// 
/// @param sprite  Sprite to draw
/// @param image   Image of the sprite to draw
/// @param x       x-coordinate to draw the sprite at
/// @param y       y-coordinate to draw the sprite at
/// @param z       z-coordinate to draw the sprite at

function CardboardSpriteFloor(_sprite, _image, _x, _y, _z)
{
    __CARDBOARD_GLOBAL
    
    var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);
    var _imageData = _global.__texturePageIndexMap[? __CARDBOARD_MAX_IMAGES*_sprite + _flooredImage];
    
    //Break the batch if we've swapped texture
    if (_imageData.textureIndex != _global.__batchTextureIndex)
    {
        __CardboardBatchComplete();
        
        _global.__batchTexturePointer = _imageData.texturePointer;
        _global.__batchTextureIndex   = _imageData.textureIndex;
    }
    
    //Cache the vertex positions
    var _l = _x + _imageData.left;
    var _t = _y + _imageData.top;
    var _r = _x + _imageData.right;
    var _b = _y + _imageData.bottom;
    
    //Cache the UVs for speeeeeeeed
    var _u0 = _imageData.u0;
    var _v0 = _imageData.v0;
    var _u1 = _imageData.u1;
    var _v1 = _imageData.v1;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _l, _t, _z); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0);
    vertex_position_3d(_vertexBuffer, _r, _t, _z); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _l, _b, _z); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    vertex_position_3d(_vertexBuffer, _r, _t, _z); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _r, _b, _z); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1);
    vertex_position_3d(_vertexBuffer, _l, _b, _z); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    if (!_global.__autoBatching && !_global.__buildingModel) CardboardBatchForceSubmit();
}