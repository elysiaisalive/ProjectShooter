var _horizontal_move = keyboard_check( vk_right ) - keyboard_check( vk_left );
var _vertical_move = keyboard_check( vk_down ) - keyboard_check( vk_up );
var _movespd = point_distance( 0, 0, _horizontal_move, _vertical_move ) * playerMoveSpd;

if ( playerCurrentState != state.aiming ) {
	playerLookAngle = rotate( playerLookAngle, playerLastMoveDir, 3.50 );
}

if ( playerCurrentMoveSpd ) {
	playerLastMoveDir = playerCurrentMoveDir;
    playerAcc = lerp( playerAcc, playerMaxAcc, playerAccRate );
}
else {
    playerAcc = lerp( playerAcc, 0, playerDecRate );
}
	
playerCurrentMoveDir = point_direction( 0, 0, _horizontal_move, _vertical_move );
playerCurrentMoveSpd = min( 1, _movespd );

// Movement
playerCurrentMoveSpdX += dcos( playerCurrentMoveDir );
playerCurrentMoveSpdY -= dsin( playerCurrentMoveDir );

playerLegDir = rotate( playerLookAngle, point_direction( x, y, playerCurrentMoveSpdX, playerCurrentMoveSpdY ), 3.85 );

if ( place_free( x + playerCurrentMoveSpdX, y ) ) {
	x += lengthdir_x( playerCurrentMoveSpd * playerSprintSpd * playerAcc, playerCurrentMoveDir );
}

if ( place_free( x, y + playerCurrentMoveSpdY ) ) {
	y += lengthdir_y( playerCurrentMoveSpd * playerSprintSpd * playerAcc, playerCurrentMoveDir );
}
//

if ( keyboard_check( vk_shift ) ) {
    playerSprintSpd = 2;
}

if ( playerCurrentMoveSpd ) {
    playerLegIndex += playerCurrentMoveSpd * 0.25;
    
    if ( playerSprite != sprShooterAimPistol ) {
        playerAnimIndex += playerCurrentMoveSpd * 0.10;
    }
    
    if ( playerSprite == sprShooterWalkPistol ) {
        if ( playerAnimIndex > sprite_get_number( playerSprite ) ) {
            playerAnimIndex = 0;
        }
    }
}
else {
    playerLegIndex = 0;
}

if ( keyboard_check_pressed( ord( "Q" ) )
&& playerHolsteredWeapon
&& playerCurrentState != state.aiming ) {
    playerCurrentWeapon = playerHolsteredWeapon;
    playerSprite = playerCurrentWeapon.wepSprite;
    playerHolsteredWeapon = undefined;
}
else if ( keyboard_check_pressed( ord( "Q" ) )
&& !playerHolsteredWeapon
&& playerCurrentState != state.aiming ) {
    playerHolsteredWeapon = playerCurrentWeapon;
    playerSprite = unarmed.wepSprite;
    playerCurrentWeapon = unarmed;
}

if ( playerCurrentWeapon != unarmed ) {
    if ( mouse_check_button_pressed( mb_right ) ) {
        playerSprite = sprShooterAimPistol;
        playerAnimIndex = 0;
    }
    
    if ( mouse_check_button( mb_right ) ) {
        if ( playerAnimIndex <= sprite_get_number( playerSprite ) - 1 ) {
            playerAnimIndex += 0.35;
            playerSprintSpd = playerSprintSpd * 0.40;
            playerCurrentState = state.aiming;
        }
    }
    else {
        if ( playerSprite == sprShooterAimPistol
        || playerSprite == sprShooterHoldAimPistol ) {
            playerAnimIndex -= 0.20;
            
            if ( playerAnimIndex <= 0 ) {
                playerSprite = sprShooterWalkPistol;
                playerCurrentState = state.idle;
            }
        }
    
        if ( playerSprite == sprShooterHoldAimPistol
        && playerAnimIndex >= sprite_get_number( playerSprite ) - 1 ) {
            playerSprite = sprShooterAimPistol;
        }
    }
}

switch( playerCurrentState ) {
    case state.aiming :
		playerLookAngle = rotate_to( playerLookAngle, point_direction( x, y, mouse_x, mouse_y ), 0.85 );
		playerLastMoveDir = playerLookAngle;
    	playerAnimSpd = 0;
        playerSprintSpd = 0.40;
        
        if ( mouse_check_button_pressed( mb_left ) ) {
        	var inst = instance_create_depth( x, y, depth, objBullet );
        	inst.spd = 8;
        	inst.direction = playerLookAngle;
        }
        break;
    default :
        playerSprintSpd = 1;
        break;
}

// playerAnimIndex += playerAnimSpd;
//playerAnimIndex = clamp( playerAnimIndex, 0, sprite_get_number( playerSprite ) );