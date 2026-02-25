#include "mechanism.h"
#include <stdio.h>

int main() {
    class CMechanism cm;
    double r[1:7], rc, rp,
            theta1, theta2, beta;
    double complex p1, p2;
    double theta_1[1:6], theta_2[1:6], 
            omega[1:6], omega_2[1:6],
            r6[1:4], theta5[1:4],
            alpha[1:6];
    double v6_x, v6_y, v6, a6;
    double Fl = 100, ts;
    double mass[1:6], inertia[1:6], rg[1:6], delta[1:6];
    CPlot plot1, plot2;
    
    double sliderWidth, sliderHeight;
    complex double L[1:7];
    FILE *fp;
    
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
    
    mass[2] = 0.8;                // kg
    mass[3] = 2.4;                
    mass[4] = 1.4;                
    mass[5] = 2.0;                
    mass[6] = 0.3;                
    
    inertia[2] = 0.012;           // kg*m^2
    inertia[3] = 0.119;           
    inertia[4] = 0.038;           
    inertia[5] = 0.040;           
    
    rg[2] = 1.25;                 // m
    rg[3] = 2.75;                 
    rg[4] = 2.5;                  
    rg[5] = 3.0;                  
    
    delta[2] = 30*M_PI/180;       // radians
    delta[3] = 15*M_PI/180;
    delta[4] = 30*M_PI/180;
    
    sliderWidth = 0.5;
    sliderHeight = sliderWidth /2;
    L[1] = polar(r[1], theta_1[1]);
    
    cm.uscUnit(false);
    cm.setLinks(rc, r[1], r[2], r[3], r[4], r[5], theta1);
    cm.setCouplerPoint(rp, beta);
    cm.setGravityCenter(rg, delta);
    cm.setInertia(inertia);
    cm.setMass(mass);
    
    cm.position(theta_1, theta_2);
    cm.velocity(theta_1, omega);
    cm.acceleration(theta_1, omega, alpha);
    cm.couplerPos(theta2, p1, p2);
    cm.sliderPos(theta_1, theta_2, r6, theta5);
    cm.sliderVel(theta_1, omega, v6_x, v6_y, v6);
    cm.sliderAccel(theta_1, omega, alpha, a6);
    cm.forceTorque(theta_1, omega, alpha, a6, Fl, ts);
    cm.plotSliderPos(&plot1);
    cm.plotSliderVel(&plot2);
    cm.animation();
    
    printf("\n-- Circuit 1 --\n");
    printf("theta3 = %lf, theta4 = %lf\ntheta5 = %lf, r6 = %lf\n", rad2deg(theta_1[3]), rad2deg(theta_1[4]), rad2deg(theta5[1]), r6[1]);
    printf("p = %lf\n", p1);
    printf("omega3 = %lf, omega4 = %lf\n", omega[3], omega[4]);
    printf("omega5 = %lf, v6 = %lf\n", omega[5], v6);
    printf("alpha 3 = %f, alpha4 = %f\n", alpha[3], alpha[4]);
    printf("alpha 5 = %f, a6 = %f\n", alpha[5], a6);
    printf("input torque = %lf\n", ts);
    //~ printf("\n-- Circuit 2 --\n");
    //~ printf("theta3 = %lf, theta4 = %lf\ntheta5 = %lf, r6 = %lf\n", rad2deg(theta_2[3]), rad2deg(theta_2[4]), rad2deg(theta5[2]), r6[2]);
    //~ printf("p = %lf\n", p2);
    //~ printf("\n-- Circuit 3 --\n");
    //~ printf("theta3 = %lf, theta4 = %lf\ntheta = %lf, r6 = %lf\n", rad2deg(theta_1[3]), rad2deg(theta_1[4]), rad2deg(theta5[3]), r6[3]);
    //~ printf("\n-- Circuit 4 --\n");
    //~ printf("theta3 = %lf, theta4 = %lf\ntheta5 = %lf, r6 = %lf\n", rad2deg(theta_2[3]), rad2deg(theta_2[4]), rad2deg(theta5[4]), r6[4]);

    //Display position
    sliderWidth = 0.5;
    sliderHeight = sliderWidth /2;
    
    fp = fopen("sliderPos.qnm", "w");
    if (fp == NULL) {
        printf("Could not open animation file.\n");
        exit(1);
    }
    
    L[1] = polar(r[1], theta_1[1]);
    L[2] = polar(r[2], deg2rad(45));
    L[3] = L[2] + polar(r[3], theta_1[3]);
    L[4] = L[3] - polar(r[4], theta_1[4]);
    L[5] = L[4] + polar(r[7], theta_1[4]); // r4'
    L[6] = complex(r6[1], 0);
    L[7] = p1;
    
    fprintf(fp, "title \"Slider Mechanism\"\n");
    fprintf(fp, "fixture\n");
    fprintf(fp, "groundpin 0 0\n");
    fprintf(fp, "groundpin %lf %lf\\\n", real(L[1]), imag(L[1]));
    fprintf(fp, "ground %lf %lf %lf %lf\n",
            r6[1] - sliderWidth / 2, -sliderHeight / 2, r6[1] + 
                sliderWidth / 2, -sliderHeight / 2);
    fprintf(fp, "animate restart\n\n");
    
    fprintf(fp, "link 0 0 %lf %lf %lf %lf %lf %lf\\\n",
            real(L[2]), imag(L[2]),
            real(L[3]), imag(L[3]),
            real(L[4]), imag(L[4]));
    fprintf(fp, "link %lf %lf %lf %lf\\\n",
            real(L[5]), imag(L[5]),
            real(L[6]), imag(L[6]));
    fprintf(fp, "rectangle %lf %lf %lf %lf\\\n",
            real(L[6]) - sliderWidth / 2, imag(L[6]) - sliderHeight / 2, 
                sliderWidth, sliderHeight);
    fprintf(fp, "polygon fill gray90 %lf %lf %lf %lf %lf %lf\\\n",
            real(L[2]), imag(L[2]),
            real(L[3]), imag(L[3]),
            real(L[7]), imag(L[7]));

    fprintf(fp, "\n");
        fclose(fp);
    qanimate sliderPos.qnm 

    return 0;
}
