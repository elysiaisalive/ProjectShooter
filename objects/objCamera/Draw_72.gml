var camera = view_get_camera( view_current );

audio_listener_position( global.camera_target.x, global.camera_target.y, 0 );
audio_listener_set_position( 0, camera_x, camera_y, 0 );
audio_listener_orientation( camera_x, camera_y, 0, -dsin( camera_angle ), dcos( camera_angle ), 0 );
camera_set_view_mat(camera, matrix_build_lookat(camera_x, camera_y, -512, camera_x, camera_y, 0, -dsin(camera_angle), dcos(camera_angle), 0));
camera_set_proj_mat(camera, matrix_build_projection_ortho(camera_width, camera_height, 0, 2048));
camera_apply(camera);