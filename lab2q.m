clc; clear all; close all;
pkg load queueing; pkg load statistics;

% Part 2
lambda=5;
mu=5.01:.01:10;
U=zeros(1,500);
R=zeros(1,500);
Q=zeros(1,500);
X=zeros(1,500);

for i=1:500
    [U(i),R(i),Q(i),X(i)] = qsmm1(lambda, mu(i));
endfor

figure(1)
plot(mu,U); title("Utilisation for different \\mu");
xlabel("\\mu"); ylabel("Utilisation");

figure(2)
plot(mu,R); title("Average response time for different \\mu");
xlabel("\\mu"); ylabel("Average response time");

figure(3)
plot(mu,Q); title("Average queue size for different \\mu");
xlabel("\\mu"); ylabel("Average queue size");

figure(4)
plot(mu,X); title("Throughput for different \\mu");
xlabel("\\mu"); ylabel("Throughput");

% Part 3
lambda = 5;
mu = 10;
states = [0, 1, 2, 3, 4]; % system with capacity 4 states
% the initial state of the system. The system is initially empty.
initial_state = [1, 0, 0, 0, 0];

% define the birth and death rates between the states of the system.
births_B = [lambda, lambda/2, lambda/3, lambda/4];
deaths_D = [mu, mu, mu, mu];

% i
% get the transition matrix of the birth-death process
transition_matrix = ctmcbd(births_B, deaths_D)

% ii
% get the ergodic probabilities of the system
display("Ergodic probabilities of the system:");
P = ctmc(transition_matrix)
% plot the ergodic probabilities (bar for bar chart)
figure(5);
bar(states, P, "r", 0.5);
title("Ergodic probabilities"); xlabel("State"); ylabel("Probability");

% iii
display("Average number of customers:");
avg_customers=sum(P.*states)
display("");

% iv
display("Probability of losing a customer:");
P_blocking=P(5)
display("");

% v
% transient probability of states until convergence to ergodic probability. Convergence takes place P0 and P differ by 0.01
index = 0;
for T = 0 : 0.01 : 50
  index = index + 1;
  P0 = ctmc(transition_matrix, T, initial_state);
  Prob0(index) = P0(1);
  Prob1(index)=P0(2);
  Prob2(index)=P0(3);
  Prob3(index)=P0(4);
  Prob4(index)=P0(5);
  if P0 - P < 0.01*P
    break;
  endif
endfor

T = 0 : 0.01 : T;
figure(6);
hold on;
plot(T, Prob0, "linewidth", 1.3);
plot(T, Prob1, "linewidth", 1.3);
plot(T, Prob2, "linewidth", 1.3);
plot(T, Prob3, "linewidth", 1.3);
plot(T, Prob4, "linewidth", 1.3);
title("Transient probability of states until convergence\n with \\lambda=5 and \\mu=10");
xlabel("Time(sec)"); ylabel("Probability");
legend("State 0","State 1","State 2","State 3","State 4");


mu = 1;
deaths_D = [mu, mu, mu, mu];
transition_matrix = ctmcbd(births_B, deaths_D);
index = 0;
for T = 0 : 0.01 : 6
  index = index + 1;
  P0 = ctmc(transition_matrix, T, initial_state);
  Prob0(index) = P0(1);
  Prob1(index)=P0(2);
  Prob2(index)=P0(3);
  Prob3(index)=P0(4);
  Prob4(index)=P0(5);
  if P0 - P < 0.01*P
    break;
  endif
endfor

T = 0 : 0.01 : T;
figure(7);
hold on;
plot(T, Prob0, "linewidth", 1.3);
plot(T, Prob1, "linewidth", 1.3);
plot(T, Prob2, "linewidth", 1.3);
plot(T, Prob3, "linewidth", 1.3);
plot(T, Prob4, "linewidth", 1.3);
title("Transient probability of states until convergence\n with \\lambda=5 and \\mu=1");
xlabel("Time(sec)"); ylabel("Probability");
legend("State 0","State 1","State 2","State 3","State 4");


mu = 5;
deaths_D = [mu, mu, mu, mu];
transition_matrix = ctmcbd(births_B, deaths_D);
index = 0;
for T = 0 : 0.01 : 2
  index = index + 1;
  P0 = ctmc(transition_matrix, T, initial_state);
  Prob05(index) = P0(1);
  Prob15(index)=P0(2);
  Prob25(index)=P0(3);
  Prob35(index)=P0(4);
  Prob45(index)=P0(5);
  if P0 - P < 0.01*P
    break;
  endif
endfor

T = 0 : 0.01 : 2;
figure(8);
hold on;
plot(T, Prob05, "linewidth", 1.3);
plot(T, Prob15, "linewidth", 1.3);
plot(T, Prob25, "linewidth", 1.3);
plot(T, Prob35, "linewidth", 1.3);
plot(T, Prob45, "linewidth", 1.3);
title("Transient probability of states until convergence\n with \\lambda=5 and \\mu=5");
xlabel("Time(sec)"); ylabel("Probability");
legend("State 0","State 1","State 2","State 3","State 4");


mu = 20;
deaths_D = [mu, mu, mu, mu];
transition_matrix = ctmcbd(births_B, deaths_D);
index = 0;
for T = 0 : 0.01 : 0.5
  index = index + 1;
  P0 = ctmc(transition_matrix, T, initial_state);
  Prob02(index) = P0(1);
  Prob12(index)=P0(2);
  Prob22(index)=P0(3);
  Prob32(index)=P0(4);
  Prob42(index)=P0(5);
  if P0 - P < 0.01*P
    break;
  endif
endfor

T = 0 : 0.01 : 0.5;
figure(9);
hold on;
plot(T, Prob02, "linewidth", 1.3);
plot(T, Prob12, "linewidth", 1.3);
plot(T, Prob22, "linewidth", 1.3);
plot(T, Prob32, "linewidth", 1.3);
plot(T, Prob42, "linewidth", 1.3);
title("Transient probability of states until convergence\n with \\lambda=5 and \\mu=20");
xlabel("Time(sec)"); ylabel("Probability");
legend("State 0","State 1","State 2","State 3","State 4");
