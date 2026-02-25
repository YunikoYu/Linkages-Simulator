/* File: animation.ch */
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
    CPlot plot1, plot2;
    
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
    
    cm.uscUnit(false);
    cm.setLinks(rc, r[1], r[2], r[3], r[4], r[5], theta1);
    cm.setCouplerPoint(rp, beta);
    
    cm.position(theta_1, theta_2);
    //~ cm.velocity(theta_1, omega);
    //~ cm.acceleration(theta_1, omega, alpha);
    //~ cm.couplerPos(theta2, p1, p2);
    cm.sliderPos(theta_1, theta_2, r6, theta5);
    //~ cm.sliderVel(theta_1, omega, v6_x, v6_y, v6);
    //~ cm.sliderAccel(theta_1, omega, alpha, a6);
    cm.plotSliderPos(&plot1);
    //cm.plotSliderVel(&plot2);
    cm.animation();
    
    
    return 0;
}
