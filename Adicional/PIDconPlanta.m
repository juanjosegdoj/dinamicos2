kp = 100;
kd = 0;
ki = 0;

PIDnum = [kd kp ki];
PIDden = [1 0];

Gnum = 1;
Gden = [1 5 6];
Gt = tf(conv(PIDnum, Gnum), conv(PIDden, Gden));
t = 0:0.01:10;
F = feedback(Gt, 1);
step(F, t)
grid