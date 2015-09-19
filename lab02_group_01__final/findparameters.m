function [cx ,cy, axis1, axis2, theta_radian, theta_degree ] = findparameters(a)

        % get ellipse orientation
        theta = atan2(a(2),a(1)-a(3))/2;

        % get scaled major/minor axes
        ct = cos(theta);
        st = sin(theta);
        ap = a(1)*ct*ct + a(2)*ct*st + a(3)*st*st;
        cp = a(1)*st*st - a(2)*ct*st + a(3)*ct*ct;

        % get translations
        T = [[a(1) a(2)/2]' [a(2)/2 a(3)]'];
        t = -inv(2*T)*[a(4) a(5)]';
        cx = t(1);
        cy = t(2);

        % get scale factor
        val = t'*T*t;
        scale = 1 / (val- a(6));

        % get major/minor axis radii
        r1 = 1/sqrt(scale*ap);
        r2 = 1/sqrt(scale*cp);
       
        axis1 = 2*r1
        axis2 = 2*r2
        center_x = cx
        center_y = cy
        theta_radian = theta
        theta_degree = (theta*180)/pi