/******************************************************  
*   File: plotKinematics.ch
*   Plotting for position, velocity, and acceleration 
*   using the member functions in mechanism.h
*******************************************************/ 

#include<mechanism.h>

int main(){
    int i, numpoints = 50;
    double r1 = 6, r2 = 1, r3 = 3, r4 = 5,
            r5 = 4, rc = 1, r7 = r4 - rc;
    double rp = 2.5, beta = 20*M_PI/180;
    double theta1 = -30*M_PI/180;
        double theta_1[1:6], theta_2[1:6],omega[1:5],alpha[1:5],theta5[1:4],r6[1:4],
            v6_x, v6_y, v6, a6;
    double  theta2[numpoints], t[numpoints],
            theta3_1[numpoints], theta4_1[numpoints], theta5_1[numpoints], 
            omega3_1[numpoints], omega4_1[numpoints], omega5_1[numpoints],
            alpha3_1[numpoints], alpha4_1[numpoints], alpha5_1[numpoints],
            A6[numpoints];
    double theta3_1w[numpoints], theta4_1w[numpoints], theta5_1w[numpoints];

    CMechanism cm;
    CPlot plot1, plot2, plot3, plot4, plot5, plot6;
    
    linspace(theta2, 0, 2*M_PI);
    
    cm.uscUnit(false);
    cm.setLinks(rc, r1, r2, r3, r4, r5, theta1);
    cm.setCouplerPoint(rp, beta);
    
    theta_1[1] = theta1;
    theta_2[1] = theta_1[1];
    omega[2] = 15;

    for(i =0; i< numpoints;i++)
    {
        theta_1[2] = theta2[i];
        theta_2[2] = theta2[i];
        t[i] = i;
        
        cm.position(theta_1, theta_2);
        cm.velocity(theta_1, omega);
        cm.acceleration(theta_1, omega, alpha);
        cm.sliderPos(theta_1, theta_2, r6, theta5);
        cm.sliderVel(theta_1, omega, v6_x, v6_y, v6);
        cm.sliderAccel(theta_1, omega, alpha, a6);
        
        theta3_1[i] = theta_1[3];
        theta4_1[i] = theta_1[4];
        theta5_1[i] = theta5[1];
        
        omega3_1[i] = omega[3];
        omega4_1[i] = omega[4];
        omega5_1[i] = omega[5];
        
        alpha3_1[i] = alpha[3];
        alpha4_1[i] = alpha[4];
        alpha5_1[i] = alpha[5];
        
        A6[i] = a6;
    }
 
    // Unwrap the angles
    unwrap(theta3_1w,theta3_1);
    unwrap(theta4_1w,theta4_1);
    unwrap(theta5_1w,theta5_1);
    
    // Plot of theta3, theta4, and theta5 over time 
    plot1.data2D(t,theta3_1w);
    plot1.data2D(t,theta4_1w);
    plot1.data2D(t,theta5_1w);
    plot1.title("Position Plot");
    plot1.legend("theta 3", "theta 4", "theta 5");
    plot1.label(PLOT_AXIS_X, "Time (sec)"); 
    plot1.label(PLOT_AXIS_Y, "Angle (rad)"); 
    plot1.border(PLOT_BORDER_ALL, PLOT_ON);
    plot1.plotting();
    
    // Plot of omega3, omega4, and omega 5 over time
    plot2.data2D(t,omega3_1);
    plot2.data2D(t,omega4_1);
    plot2.data2D(t,omega5_1);
    plot2.title("Angular Velocity Plot");
    plot2.legend("omega 3", "omega 4", "omega 5");
    plot2.label(PLOT_AXIS_X, "Time (sec)"); 
    plot2.label(PLOT_AXIS_Y, "Angular Velocity (rad/s)"); 
    plot2.border(PLOT_BORDER_ALL, PLOT_ON);
    plot2.plotting();
    
    // Plot of alpha3, alpha4, and alpha5 over time
    plot3.data2D(t,alpha3_1);
    plot3.data2D(t,alpha4_1);
    plot3.data2D(t,alpha5_1);
    plot3.title("Angular Accleration Plot");
    plot3.legend("alpha 3", "alpha 4", "alpha 5");
    plot3.label(PLOT_AXIS_X, "Time (sec)"); 
    plot3.label(PLOT_AXIS_Y, "Angular Acceleration (rad/s^2)"); 
    plot3.border(PLOT_BORDER_ALL, PLOT_ON);
    plot3.plotting();
    
    // Plot of slider position over time
    cm.plotSliderPos(&plot4);
    
    // Plot of slider velocity over time
    cm.plotSliderVel(&plot5);
    
    // Plot of slider acceleration
    plot6.data2D(t,A6);
    plot6.title("Slider Accleration Plot");
    plot6.label(PLOT_AXIS_X, "Time (sec)"); 
    plot6.label(PLOT_AXIS_Y, "Slider Acceleration (cm/s^2)"); 
    plot6.border(PLOT_BORDER_ALL, PLOT_ON);
    plot6.plotting();
    
    return 0;
}
