function [sys,x0,str,ts] = DiscKal(t,x,u,flag,data) %DiscKal(t,x,u,flag,data) if method 2 is used
% Shell for the discrete kalman filter assignment in
% TTK4115 Linear Systems.
%
% Author: J�rgen Spj�tvold
% 19/10-2003 
%

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(data);%mdlInitializeSizes(data); if method 2 is used

  %%%%%%%%%%%%%
  % Outputs   %
  %%%%%%%%%%%%%
  
  case 3,
    sys=mdlOutputs(t,x,u,data); % mdlOutputs(t,x,u,data) if mathod 2 is used
  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  
  case 2,
    sys=mdlUpdate(t,x,u, data); %mdlUpdate(t,x,u, data); if method 2 is used
  
  case {1,4,}
    sys=[];

  case 9,
      sys=mdlTerminate(t,x,u);
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

function [sys,x0,str,ts]=mdlInitializeSizes(data) %mdlInitializeSizes(data); if method 2 is used
% This is called only at the start of the simulation. 
sizes = simsizes; % do not modify

sizes.NumContStates  = 0; % Number of continuous states in the system, do not modify
sizes.NumDiscStates  = 5+5+25; % Number of discrete states in the system, modify. 
sizes.NumOutputs     = 2; % Number of outputs, the hint states 2
sizes.NumInputs      = 2; % Number of inputs, the hint states 2
sizes.DirFeedthrough = 0; % 1 if the input is needed directly in the
% update part
sizes.NumSampleTimes = 1; % Do not modify  

sys = simsizes(sizes); % Do not modify  

x0  = [data.x0_minus; data.x0_minus; data.P0_minus(:)]; % Initial values for the discrete states, modify
%Pk_minus = data.P0_minus;
str = []; % Do not modify

ts  = [-1 0]; % Sample time. [-1 0] means that sampling is
% inherited from the driving block and that it changes during
% minor steps.


function sys=mdlUpdate(t,x,u, data)%mdlUpdate(t,x,u, data); if method 2 is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update the filter covariance matrix and state etsimates here.
% example: sys=x+u(1), means that the state vector after
% the update equals the previous state vector + input nr one.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute xk, xk_minus, zk
Pk_minus = reshape(x(11:35),sqrt(length(x(11:35))),sqrt(length(x(11:35)))); 
xk_minus = x(1:5);
%xk = x(6:10);
zk = u(1);

% Kalman gain matrix
Kk = Pk_minus*(data.C') / (data.C*Pk_minus*(data.C') + data.Rd);

% Update estimate
xk = xk_minus + Kk * (zk - data.C*xk_minus);

% Compute error covariance
Pk = (eye(size(data.Ad)) - Kk*data.C)*Pk_minus*(((eye(size(data.Ad)) - Kk*data.C))') + Kk*data.Rd*(Kk');

% Project ahead
xk_minus = data.Ad*xk + data.Bd*(u(2));
Pk_minus = data.Ad*Pk*data.Ad' + data.Qd; %data.Ed*data.Q*data.Ed';


sys=[xk_minus; xk; Pk_minus(:)];

function sys=mdlOutputs(t,x,u,data)% mdlOutputs(t,x,u,data) if mathod 2 is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the outputs here
% example: sys=x(1)+u(2), means that the output is the first state+
% the second input. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%persistent C_;
C_ = [0 0 0 0 0 0 0 1 0 0 zeros(1, 25);
      0 0 0 0 0 0 0 0 0 1 zeros(1, 25)];
sys=C_*x;

function sys=mdlTerminate(t,x,u) 
sys = [];


