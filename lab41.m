pkg load queueing

% factorial erlang function
function res=erlangb_factorial(r,c)
  denom=0;
  for i=0:c
    denom+=(r^i)/factorial(i);
  endfor
  res=(r^c)/factorial(c)/denom;
endfunction

% iterative erlang function
function res=erlangb_iterative(r,c)
  res=1;
  for i=0:c
    res=r*res/(r*res+i);
  endfor
endfunction

% check if functions work
printf("erlangb_factorial(10,10)= %d\n", erlangb_factorial(10,10));
printf("erlangb(10,10)= %d\n",erlangb(10,10));
printf("erlangb_iterative(10,10)= %d\n",erlangb_iterative(10,10));
printf("\nerlangb_factorial(1024,1024)= %d\n", erlangb_factorial(1024,1024));
printf("erlangb(1024,1024)= %d\n",erlangb(1024,1024));
printf("erlangb_iterative(1024,1024)= %d\n",erlangb_iterative(1024,1024));

% plot Pblocking
r=200*23/60;
c=1:200;
for i=1:200
  pblocking(i)=erlangb_iterative(r,i);
endfor
figure(1)
plot(c,pblocking);
title("Chance of losing a customer for different number of call lines");
xlabel("Number of call lines"); ylabel("Pblocking");

% find smallest number of lines so that Pblocking<0.01
lines=1;
while pblocking(lines)>=0.01
  lines++;
endwhile  
printf("\nFewest lines required: %d\n",lines);
printf("Chance of losing a customer with %d lines: %d\n",lines,pblocking(lines));
printf("Chance of losing a customer with %d lines: %d\n",lines-1,pblocking(lines-1));