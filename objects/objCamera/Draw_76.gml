///@desc move topdown camera
var camera = view_get_camera(0);

if ( !instance_exists( global.camera_target ) )
{
	if ( valid_target )
	{
		valid_target = false;
		show_message( "Camera Target Invalid!" );
	};
	
	exit;
};

valid_target = true;

switch ( global.camera_mode ) {
	default: // Topdown Camera
		var camera_target_x = global.camera_target.x;
		var camera_target_y = global.camera_target.y;
		var look_factor		= 8;
		var look_dist		= point_distance( camera_target_x, camera_target_y, camera_get_view_x( camera ), camera_get_view_y( camera ) ) / look_factor;
		
		var range_distance = 128; // maximum look distance
		var range_scale_dis = 256; // mouse distance to reach maximum

		var range = range_distance * clamp( point_distance( global.camera_target.x, global.camera_target.y, mouse_x, mouse_y ) / range_scale_dis, range_min, range_max );
		
		camera_target_x += range * dcos( global.camera_target.image_angle );
		camera_target_y -= range * dsin( global.camera_target.image_angle );

		var _pull = camera_pull;
		var _dis = point_distance( camera_x, camera_y, camera_target_x, camera_target_y );
		var _dir = point_direction( camera_x, camera_y, camera_target_x, camera_target_y );
		var _angle = point_direction( camera_x, camera_y, camera_target_x, camera_target_y );
		var _spd = _dis * _pull;
		
		camera_x += dcos( _dir ) * _spd;
		camera_y -= dsin( _dir ) * _spd;
		
		var dir;
		
		if ( true )
		{
			dir = point_direction(room_width / 2, room_height / 2, camera_target_x, camera_target_y) * 2;
		}
		else
		{
			dir = point_direction(room_width / 2, room_height / 2, camera_x, camera_y) * 2;
		}
		
		var dis = point_distance(room_width / 2, room_height / 2, camera_x, camera_y);
		
		{
			camera_angle = ( -dsin( dir ) * dis * 0.00625 );
		}

		var _width = camera_width;
		var _height = camera_height;
		
		if ( camera_keep_inside_room ) 
		{
			camera_x = median( _width / 2, camera_x, room_width - _width / 2 );
			camera_y = median( _height / 2, camera_y, room_height - _height / 2 );
		}
		
		var _x = camera_x - ( _width  / 2 );
		var _y = camera_y - ( _height / 2 );
		
		camera_set_view_pos( camera, _x, _y );
		camera_set_view_size( camera, _width * camera_zoomfactor, _height * camera_zoomfactor );
		
		camera_width = clamp( camera_width, 480/2, camera_width_max );
		camera_height = clamp( camera_height, 270/2, camera_height_max );
		
		camera_set_view_angle( camera, camera_angle );
		camera_apply( camera );
		break;
}