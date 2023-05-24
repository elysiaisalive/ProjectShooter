/// @description 
x += dcos( direction ) * spd;
y -= dsin( direction ) * spd;

spd = max( 0, spd - frc );