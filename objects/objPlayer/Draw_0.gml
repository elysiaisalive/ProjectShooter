if ( ( playerSprite == sprShooterAimPistol 
|| playerSprite == sprShooterHoldAimPistol )
&& playerAnimIndex >= sprite_get_number( playerSprite ) - 1 ) {
    for( var i = 0; i < 256; ++i ) {
        gpu_set_blendmode( bm_add );
        draw_set_alpha( 0.10 * playerAnimIndex );
        draw_line_width_colour( x + lengthdir_x( 16, playerLookAngle ), y + lengthdir_y( 16, playerLookAngle ), x + lengthdir_x( 16 + i, playerLookAngle ), y + lengthdir_y( 16 + i, playerLookAngle ), 1, c_red, c_black );
        draw_set_alpha( 1 );
        gpu_set_blendmode( bm_normal );
    }
}

draw_sprite_ext( sprShooterLegs, playerLegIndex, x, y, 1, 1, playerCurrentMoveDir, c_white, 1 );
draw_sprite_ext( playerSprite, playerAnimIndex, x, y, 1, 1, playerLookAngle, c_white, 1 );

var str = playerHolsteredWeapon ? playerHolsteredWeapon.wepName : "None";
var str2 = playerCurrentWeapon ? playerCurrentWeapon.wepName : "None";

draw_text( x, y, str );
draw_text( x, y + 20, $"{sprite_get_name( playerSprite )}" );

draw_sprite( sprCursor, -1, ~~mouse_x*1, ~~mouse_y*1 );