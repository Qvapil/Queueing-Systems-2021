lambda=[4,1];
mu=[6,5,8,7,6];

function [r,ergodic]=intensities(lambda,mu)
  r(1)=lambda(1)/mu(1);
  r(2)=(lambda(2)+2/7*lambda(1))/mu(2);
  r(3)=4/7*lambda(1)/mu(3);
  r(4)=3/7*lambda(1)/mu(4);
  r(5)=(4/7*lambda(1)+lambda(2))/mu(5);
  ergodic=1;
  for i=1:5
##    printf("Intensity at queue %d: %d\n",i,r(i));
    if r(i)>=1
      ergodic=0;
    endif
  endfor
end

function [En]=mean_clients(lambda,mu)
  [r,ergodic]=intensities(lambda,mu);
  En=r./(1-r);
end

[ro,erg]=intensities(lambda,mu);
if erg==1
  printf("The system is ergodic\n");
else
  printf("The system is not ergodic\n");
end
printf("\n");

for i=1:5
  printf("Intensity at queue %d: %d\n",i,ro(i));
end
printf("\n");

En=mean_clients(lambda,mu);
for i=1:5
  printf("Mean clients at queue %d: %d\n",i,En(i));
end
printf("\n");

avgTotalTime=sum(En)/sum(lambda);
printf("Average total waiting time: %d\n",avgTotalTime);

lambda_max=6;
for i=1:99
  lmd(i)=lambda_max*i/100;
  lambda=[lmd(i),1];
  wait(i)=sum(mean_clients(lambda,mu))/sum(lambda);
endfor

figure(1);
plot(lmd,wait);
title("Average total waiting time for different lambda1");
xlabel("lambda"); ylabel("Average total waiting time");