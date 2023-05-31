function __CbDeferredSurfaceDepthEnsure(_refSurface)
{
    __CB_GLOBAL
    
    with(_global)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__deferredSurfaceDepth)
        &&   ((_width  != surface_get_width( __deferredSurfaceDepth))
           || (_height != surface_get_height(__deferredSurfaceDepth))))
        {
            surface_free(__deferredSurfaceDepth);
            __deferredSurfaceDepth = -1;
        }
        
        if (not surface_exists(__deferredSurfaceDepth))
        {
            __deferredSurfaceDepth = surface_create(_width, _height);
        }
        
        return __deferredSurfaceDepth;
    }
}