function cCamera( _cam_w = 480, _cam_h = 270, xx, yy ) constructor {
    static camera = camera_create();
    
    cam_x = xx;
    cam_y = yy;
    camera_width = _cam_w;
    camera_height = _cam_h;
    camera_target = noone;
    camera_target_pos = [0, 0];
    camera_surf = -1;
    
    #macro view view_camera[0];
    #macro viewWidth camera_get_view_width( view );
    #macro viewHeight camera_get_view_height( view );
    
    static Init = function() {
        camera_set_view_size( camera, camera_width + 1, camera_height + 1 );
        camera_apply( camera );
    }
    
    static Tick = function() {
        if ( !camera_target ) {
            camera_set_view_pos( camera, camera_target_pos[0], camera_target_pos[1] );
        }
        else {
            camera_set_view_pos( camera, camera_target.x, camera_target.y );
        }
        
        if ( !surface_exists( camera_surf ) ) {
            camera_surf = surface_create( camera_width + 1, camera_height + 1 );
            view_surface_id[0] = camera_surf;
        }
    }
    
    static Draw = function() {
        camera_apply( camera );
        // if ( surface_exists( camera_surf ) ) {
        // 	var _x = camera_get_view_x( camera ) - cam_x;
        // 	var _y = camera_get_view_y( camera ) - cam_y;
        	
        // 	surface_set_target( camera_surf );
        // 	draw_surface( camera_surf, _x, _y );
        // 	surface_reset_target();
        // }
    }
    
    static Cleanup = function() {
        if ( surface_exists( camera_surf ) ) { 
            surface_free( camera_surf ); 
        }
        
        camera_surf = -1;
    }
}