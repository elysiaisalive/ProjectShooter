enum state {
    idle,
    aiming,
    rolling
}

unarmed = new cWeapon();
unarmed.wepName = "Unarmed";
unarmed.wepAmmo = 0;
unarmed.wepSprite = sprShooterWalk;

pistol = new cWeapon();
pistol.wepName = "Pistol";
pistol.wepAmmo = 12;
pistol.wepFireRate = 1 / 60;
pistol.wepSprite = sprShooterWalkPistol;

playerSprite = sprShooterWalk;
playerAnimSpd = 0;
playerAnimIndex = 0;
playerLegIndex = 0;
playerMoveSpd = 2.50;
playerMoveFrc = 0.75;
playerMoveDir = 0;
playerLookAngle = 0;

playerRollTime = 2 / 60;
playerRollDirection = 0;

playerSprintSpd = 2;

playerHolsteredWeapon = pistol; // Weapon in holster
playerCurrentWeapon = unarmed; // Weapon in hand
playerCurrentAmmo = 0;
playerCurrentState = state.idle;

playerCurrentSpd = 0;
playerCurrentMoveSpd = 0;
playerCurrentMoveSpdX = 0;
playerCurrentMoveSpdY = 0;
playerCurrentMoveDir = 0;

playerAcc = 0;
playerDec = 0;
playerMaxAcc = 2;
playerMaxDec = 2;
playerAccRate = 0.020;
playerDecRate = 0.090;

global.camera_target = self.id;