/*******************************************
* File: mechanism.h
*******************************************/
#ifndef _MECHANISM_H_
#define _MECHANISM_H_

#include <linkage.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdarg.h>
#include <float.h>
#include <complex.h>
#include <chplot.h>


/********************************************
* CMechanism class definition
********************************************/

class CMechanism {
    private:
        // Private data members
        double m_r[1:7];                    // lengths of links
        double m_theta[1:6];                // phase angles of the links
        double m_omega[1:6];                // angular velocity
        double m_rc;                        // length of link BC
        double m_rp;                        // length of coupler link
        double m_beta;                      // angle between PA and AB
        int m_numpoints;                     // number of points to plot
        bool m_uscunit;                     // unit selection
        
        double m_mass[1:6];                 // mass of links
        double m_inertia[1:6];              // gravitational inertia of links
        double m_rg[1:6];                     // center of gravity of links
        double m_delta[1:6];                  // angle between m_rg and link
    
        // Private function members
        void m_initialize(void);             // initialize private members
    
    public:
        // Constructor and Destructor
        CMechanism();
        ~CMechanism();
        
        // Set information functions
        void uscUnit(bool unit);
        void setLinks(double rc, r1, r2, r3, r4, r5, theta1);
        void setCouplerPoint(double rp, beta);
        void setGravityCenter(double rg[1:], delta[1:]);      
        void setInertia(double ig[1:]);
        void setMass(double m[1:]);   
        
        // Public member functions
        void position(double theta[1:], theta_2[1:]);     
        void velocity(double theta[1:], omega[1:]);                           
        void acceleration(double theta[1:], omega[1:], alpha[1:]);
        void couplerPos(double Theta2, double complex &p1, &p2);
        void sliderPos(double theta_1[1:], theta_2[1:], r6[1:], theta5[1:]);
        void sliderVel(double theta[1:], omega[1:], &v6_x, &v6_y, &v6);
        void sliderAccel(double theta[1:], omega[1:], alpha[1:], &a6);
        void forceTorque(double theta[1:], omega[1:], alpha[1:], a6, Fl, &ts);
        void plotSliderPos(class CPlot *pl);
        void plotSliderVel(class CPlot *pl);
        int animation(void);
};

#pragma importf <CMechanism.chf>

#endif
