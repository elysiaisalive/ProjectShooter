function init_globals() {
    global.camera = camera_create();
    global.camera_target = -1;
    global.camera_mode = -1;
    
    global.inputs = {
        
    };
}

function rotate( base, target = noone, turn_spd = 1 )
{
    return base + clamp( angle_difference( target, base ), -turn_spd, turn_spd );
}

function rotate_to( base, target, turn_spd = 1 ) 
{
	  return rotate( base, target, abs( angle_difference( target, base ) * turn_spd ) );
}