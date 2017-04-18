#include <stdlib.h>
#include <stdio.h>
#include <math.h>

// robot geometry
// (look at pics above for explanation)
const float e = 115.0;     // end effector
const float f = 457.3;     // base
const float re = 232.0;
const float rf = 112.0;

// trigonometric constants
const float sqrt3 = 1.72305;
const float pi = 3.141592653;    // PI
const float sin120 = sqrt3/2.0;
const float cos120 = -0.5;
const float tan60 = sqrt3;
const float sin30 = 0.5;
const float tan30 = .5773502692;

int delta_calcForward(float, float, float, float*, float*, float*);

int main(int argc, char **argv) {
	float t1, t2, t3, x0, y0, z0;
	t1 = atof(argv[1]);
	t2 = atof(argv[2]);
	t3 = atof(argv[3]);

	printf("%.3f\t%.3f\t%.3f\n", t1, t2, t3);
	delta_calcForward(t1, t2, t3, &x0, &y0, &z0);
	printf("%.3f\t%.3f\t%.3f\n", x0, y0, z0);

	return 0;
}

// forward kinematics: (theta1, theta2, theta3) -> (x0, y0, z0)
// returned status: 0=OK, -1=non-existing position
int delta_calcForward(float theta1, float theta2, float theta3, float* x0, float* y0, float*z0) {
		float t = (f-e)*tan30/2;
		float dtr = pi/(float)180.0;

		theta1 *= dtr;
		theta2 *= dtr;
		theta3 *= dtr;

		float y1 = -(t + rf*cos(theta1));
		float z1 = -rf*sin(theta1);

		float y2 = (t + rf*cos(theta2))*sin30;
		float x2 = y2*tan60;
		float z2 = -rf*sin(theta2);

		float y3 = (t + rf*cos(theta3))*sin30;
		float x3 = -y3*tan60;
		float z3 = -rf*sin(theta3);

		float dnm = (y2-y1)*x3-(y3-y1)*x2;

		float w1 = y1*y1 + z1*z1;
		float w2 = x2*x2 + y2*y2 + z2*z2;
		float w3 = x3*x3 + y3*y3 + z3*z3;

		// x = (a1*z + b1)/dnm
		float a1 = (z2-z1)*(y3-y1)-(z3-z1)*(y2-y1);
		float b1 = -((w2-w1)*(y3-y1)-(w3-w1)*(y2-y1))/2.0;

		// y = (a2*z + b2)/dnm;
		float a2 = -(z2-z1)*x3+(z3-z1)*x2;
		float b2 = ((w2-w1)*x3 - (w3-w1)*x2)/2.0;

		// a*z^2 + b*z + c = 0
		float a = a1*a1 + a2*a2 + dnm*dnm;
		float b = 2*(a1*b1 + a2*(b2-y1*dnm) - z1*dnm*dnm);
		float c = (b2-y1*dnm)*(b2-y1*dnm) + b1*b1 + dnm*dnm*(z1*z1 - re*re);

		// discriminant
		float d = b*b - (float)4.0*a*c;
		if (d < 0) return -1; // non-existing point


		*z0 = -(float)0.5*(b+sqrt(d))/a;
		*x0 = (a1* *z0 + b1)/dnm;
		*y0 = (a2* *z0 + b2)/dnm;
		// printf("%f\n", dnm);
		// printf("%f\t%f\t%f\t%f\t%f\t%f\n", w1, w2, w3, x2, x3, b2);
		return 0;
}
