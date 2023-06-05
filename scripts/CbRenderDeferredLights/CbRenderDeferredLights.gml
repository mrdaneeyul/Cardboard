function CbRenderDeferredLights()
{
    __CB_GLOBAL
    
    if (CbLightModeGet() != CB_LIGHT_MODE.DEFERRED) return;
    
    var _matrices        = CbCameraMatricesGet();
    var _vpMatrix        = matrix_multiply(_matrices.view, _matrices.projection);
    var _vpMatrixInverse = __CbMatrixInvert(_vpMatrix);
    
    var _refSurface = surface_get_target();
    
    with(_global)
    {
        surface_set_target(__CbDeferredSurfaceLightEnsure(surface_get_target()));
        gpu_set_blendmode(bm_add);
        
        
        
        //Draw unshadowed lights first
        shader_set(__shdCbDeferredUnshadowed);
        shader_set_uniform_matrix_array(shader_get_uniform(__shdCbDeferredUnshadowed, "u_mCameraInverse"), _vpMatrixInverse);
        texture_set_stage(shader_get_sampler_index(__shdCbDeferredUnshadowed, "u_sDepth" ), surface_get_texture(__CbDeferredSurfaceDepthEnsure( _refSurface)));
        texture_set_stage(shader_get_sampler_index(__shdCbDeferredUnshadowed, "u_sNormal"), surface_get_texture(__CbDeferredSurfaceNormalEnsure(_refSurface)));
        
        with(__lighting)
        {
            shader_set_uniform_f_array(shader_get_uniform(__shdCbDeferredUnshadowed, "u_vPosRadArray"), __posRadArray);
            shader_set_uniform_f_array(shader_get_uniform(__shdCbDeferredUnshadowed, "u_vColorArray"),  __colorArray);
            
            draw_surface(application_surface, 0, 0);
            
            shader_reset();
        }
        
        
        
        //Then draw shadowed lights
        shader_set(__shdCbDeferredShadowed);
        shader_set_uniform_matrix_array(shader_get_uniform(__shdCbDeferredShadowed, "u_mCameraInverse"), _vpMatrixInverse);
        texture_set_stage(shader_get_sampler_index(__shdCbDeferredShadowed, "u_sDepth" ), surface_get_texture(__CbDeferredSurfaceDepthEnsure( _refSurface)));
        texture_set_stage(shader_get_sampler_index(__shdCbDeferredShadowed, "u_sNormal"), surface_get_texture(__CbDeferredSurfaceNormalEnsure(_refSurface)));
        
        with(__lighting)
        {
            var _i = 0;
            repeat(array_length(__array))
            {
                with(__array[_i].ref)
                {
                    if (__hasShadows && visible)
                    {
                        __SetDeferredUniforms();
                        draw_surface(application_surface, 0, 0);
                    }
                }
                
                ++_i;
            }
            
            shader_reset();
        }
        
        
        
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
    }
    
    
    
    gpu_set_colorwriteenable(true, true, true, false);
    gpu_set_blendmode_ext(bm_dest_color, bm_zero);
    draw_surface(__CbDeferredSurfaceLightEnsure(surface_get_target()), 0, 0);
    gpu_set_colorwriteenable(true, true, true, true);
    gpu_set_blendmode(bm_normal);
}