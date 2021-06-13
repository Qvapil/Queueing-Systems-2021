% M/M/1/10 simulation.

clc;
clear all;
close all;


rand("seed",10);
lambda = [1 5 10]; 
mu = 5;

for n=1:3
  threshold = lambda(n)/(lambda(n) + mu); % the threshold used to calculate probabilities
  
  transitions = 0; % holds the transitions of the simulation in transitions steps
  arrivals=zeros(1,11);
  total_arrivals = 0; % to measure the total number of arrivals
  current_state = 0;  % holds the current state of the system
  previous_mean_clients = 0; % will help in the convergence test
  index = 0;
  to_plot=zeros(1,1000);
  
  % for debugging
##  tracestate=zeros(1,30);
##  tracearrdep=zeros(1,30);
##  tracearrivals=zeros(1,30);
  
  while transitions >= 0
    %threshold = lambda(n)/(lambda(n) + current_state+1);
    transitions = transitions + 1; % one more transitions step 
    % for debugging
##    if transitions<=30
##      tracestate(transitions)=current_state;
##      tracearrivals(transitions)=arrivals(current_state+1);    
##    endif
    
    if mod(transitions,1000) == 0 % check for convergence every 1000 transitions steps
      index = index + 1;
      for i=1:1:length(arrivals)
          P(i) = arrivals(i)/total_arrivals; % calculate the probability of every state in the system
      endfor
    
      mean_clients = 0; % calculate the mean number of clients in the system
      for i=1:1:length(arrivals)
         mean_clients = mean_clients + (i-1).*P(i);
      endfor
    
      to_plot(index) = mean_clients;
        
      if abs(mean_clients - previous_mean_clients) < 0.00001 || transitions > 1000000 % convergence test
       break;
      endif
    
     previous_mean_clients = mean_clients;
    
   endif
  
   random_number = rand(1); % generate a random number (Uniform distribution)
   if current_state == 0 || random_number < threshold % arrival
     % for debugging
##     if transitions<=30
##      tracearrdep(transitions)=1;
##     endif
     
     total_arrivals = total_arrivals + 1;
     arrivals(current_state + 1) = arrivals(current_state + 1) + 1; % increase the number of arrivals in the current state
     
     if current_state<10
        current_state = current_state + 1;
     endif     
     
   else % departure
     %for debugging
##     if transitions<=30
##      tracearrdep(transitions)=2;
##     endif
     
     if current_state != 0 % no departure from an empty system
        current_state = current_state - 1;
     endif
   endif
  endwhile

  printf('For lambda=%d\n',lambda(n));
  printf('Ergodic Probabilities\n');
  for i=1:1:length(arrivals)
   disp(P(i));
  endfor
  printf('\n');
  
  printf('Average number of customers: %d\n',mean_clients);
  printf('Probability of rejecting a customer: %d\n',P(11));
  throughput=lambda(n)*(1-P(11));  
  printf('Average waiting time: %d\n\n',mean_clients/throughput);
  
##  printf('First 30 states');
##  disp(tracestate);
##  printf('\n');
##  printf('Arrivals at current state');
##  disp(tracearrivals);
##  printf('\n');
##  printf('Next is arrival(1) or departure(2)')
##  disp(tracearrdep);
##  printf('\n');
  
  figure(1);
  plot(to_plot(1:index),"r","linewidth",1.3);
  title("Average number of clients in the M/M/1/10 queue: Convergence");
  xlabel("transitions in thousands");
  ylabel("Average number of clients");

  figure(2);
  bar(0:10,P,'r',0.4);
  title("Probabilities")
  %pause(2);
endfor
