/* File: acceleration.ch */
#include <mechanism.h>

int main(){
    class CMechanism cm;
    double r[1:7], rc, rp,
            theta1, theta2, beta;
    double complex p1, p2;
    double theta_1[1:6], theta_2[1:6], 
            omega[1:6], omega_2[1:6],
            r6[1:4], theta5[1:4],
            alpha[1:6];
    
    rc = 1;
    rp = 2.5;
    
    r[1] = 6;
    r[2] = 1;
    r[3] = 3;
    r[4] = 5;
    r[5] = 4;
    r[7] = r[4] - rc;
    
    theta1 = -30*M_PI/180;
    theta2 = 45*M_PI/180;
    beta = 20*M_PI/180;
    
    theta_1[1] = theta1;
    theta_1[2] = theta2;
    theta_2[1] = theta1;
    theta_2[2] = theta2;
    
    omega[2] = 15;
    omega_2[2]= omega[2];

    cm.uscUnit(false);
    cm.setLinks(rc, r[1], r[2], r[3], r[4], r[5], theta1);
    
    cm.position(theta_1, theta_2);
    cm.velocity(theta_1, omega);
    cm.acceleration(theta_1, omega, alpha);
    
    printf("alpha3 = %f\n", alpha[3]);
    printf("alpha4 = %f\n", alpha[4]);

    return 0;
}

