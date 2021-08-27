pkg load queueing;

clear all; close all; clc;

a=0.001:0.001:0.999;
lambda=10000;
m1=(15*10^6)/128/8;
m2=(12*10^6)/128/8;
lambda1=lambda.*a;
lambda2=lambda.*(1-a);

[U1,R1,Q1,X1]=qsmm1(lambda1,m1);
[U2,R2,Q2,X2]=qsmm1(lambda2,m2);

R=a.*R1+(1-a).*R2;
[minR,mina]=min(R);

figure(1);
plot(a,R);
title("Average waiting time for different a");
xlabel("a"); ylabel("Average waiting time");

printf("Minimum average waiting time is %d for a=%d\n",minR,a(mina));
