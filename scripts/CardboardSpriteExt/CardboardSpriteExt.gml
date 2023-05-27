/// Draws a sprite perpendicular to the floor ("standing up")
/// 
/// This function treats a z angle of 0 degrees as facing a camera pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the sprite may not be immediately drawn
/// 
/// @param sprite     Sprite to draw
/// @param image      Image of the sprite to draw
/// @param x          x-coordinate to draw the sprite at
/// @param y          y-coordinate to draw the sprite at
/// @param z          z-coordinate to draw the sprite at
/// @param xScale     Scale of the sprite on the x-axis
/// @param zScale     Scale of the sprite on the z-axis
/// @param yAngle     Rotation of the sprite around the y-axis
/// @param zAngle     Rotation of the sprite around the z-axis
/// @param color      Blend color for the sprite (c_white is "no blending")
/// @param alpha      Blend alpha for the sprite (0 being transparent and 1 being 100% opacity)
/// @param cruciform

function CardboardSpriteExt(_sprite, _image, _x, _y, _z, _xScale, _zScale, _yAngle, _zAngle, _color, _alpha, _cruciform)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_SPRITE_COMMON_TEXTURE
    __CARDBOARD_SPRITE_COMMON_UVS
    
    //Scale up the image
    var _l = _xScale*_imageData.left;
    var _t = _zScale*_imageData.top;
    var _r = _xScale*_imageData.right;
    var _b = _zScale*_imageData.bottom;
    
    //Perform a simple 2D rotation
    var _sin = dsin(-_yAngle);
    var _cos = dcos(-_yAngle);
    
    var _ltX0 =   _l*_cos - _t*_sin;
    var _ltZ  = -(_l*_sin + _t*_cos) + _z;
    var _rtX0 =   _r*_cos - _t*_sin;
    var _rtZ  = -(_r*_sin + _t*_cos) + _z;
    var _lbX0 =   _l*_cos - _b*_sin;
    var _lbZ  = -(_l*_sin + _b*_cos) + _z;
    var _rbX0 =   _r*_cos - _b*_sin;
    var _rbZ  = -(_r*_sin + _b*_cos) + _z;
    
    //Perform a less simple 2D rotation
    var _sin = dsin(-_zAngle);
    var _cos = dcos(-_zAngle);
    
    var _ltX = _ltX0*_cos + _x;
    var _ltY = _ltX0*_sin + _y;
    var _rtX = _rtX0*_cos + _x;
    var _rtY = _rtX0*_sin + _y;
    var _lbX = _lbX0*_cos + _x;
    var _lbY = _lbX0*_sin + _y;
    var _rbX = _rbX0*_cos + _x;
    var _rbY = _rbX0*_sin + _y;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    if (CARDBOARD_WRITE_NORMALS)
    {
        
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    }
    
    if (_cruciform)
    {
        var _ltX = -_ltX0*_sin + _x;
        var _ltY =  _ltX0*_cos + _y;
        var _rtX = -_rtX0*_sin + _x;
        var _rtY =  _rtX0*_cos + _y;
        var _lbX = -_lbX0*_sin + _x;
        var _lbY =  _lbX0*_cos + _y;
        var _rbX = -_rbX0*_sin + _x;
        var _rbY =  _rbX0*_cos + _y;
        
        if (CARDBOARD_WRITE_NORMALS)
        {
            
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
            
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        }
    }
    
    __CARDBOARD_FORCE_SUBMIT_CONDITION
}