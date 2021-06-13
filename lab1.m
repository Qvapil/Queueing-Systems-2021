clc;
clear all;
close all;
 
pkg load statistics;
 
# TASK: In a common diagram, design the Probability Mass Function of Poisson processes
# with lambda parameters 3, 10, 30, 50. In the horizontal axes, choose k parameters 
# between 0 and 70. 
 
k = 0:1:70;
lambda = [3,10,30, 50];
 
for i=1:columns(lambda)
  poisson(i,:) = poisspdf(k,lambda(i));
endfor
 
colors = "rbkm";
figure(1);
hold on;
for i=[1,2,4]
  stem(k,poisson(i,:),colors(i),"linewidth",1.2);
endfor 
hold off;
 
title("Probability Mass Function of Poisson processes");
xlabel("k values");
ylabel("probability");
legend("lambda=3","lambda=10","lambda=50");
 
# TASK: regarding the poisson process with parameter lambda 30, compute its mean 
# value and variance
 
index = find(lambda == 30);
chosen = poisson(index,:);
mean_value = 0;
for i=0:(columns(poisson(index,:))-1)
  mean_value = mean_value + i.*poisson(index,i+1);
endfor
 
display("mean value of Poisson with lambda 30 is");
display(mean_value);
 
second_moment = 0;
for i=0:(columns(poisson(index,:))-1)
  second_moment = second_moment + i.*i.*poisson(index,i+1);
endfor 
variance = second_moment - mean_value.^2;
display("Variance of Poisson with lambda 30 is");
display(variance);
 
# TASK: consider the convolution of the Poisson distribution with lambda 20 with 
# the Poisson distribution with lambda 30. 
 
first = find(lambda==10);
second = find(lambda==50);
poisson_first = poisson(first,:);
poisson_second = poisson(second,:);
 
composed = conv(poisson_first,poisson_second);
new_k = 0:1:(2*70);
 
figure(2);
hold on;
stem(k,poisson_first(:),colors(1),"linewidth",1.2);
stem(k,poisson_second(:),colors(2),"linewidth",1.2);
stem(new_k,composed,"mo","linewidth",2);
hold off;
title("Convolution of two Poisson processes");
xlabel("k values");
ylabel("Probability");
legend("lambda=10","lambda=50","new process");
 
# TASK: show that Poisson process is the limit of the binomial distribution.
k = 0:1:200;
# Define the desired Poisson Process
lambda = 30;
i=[10 100 1000];
n = lambda.*i; 
p = lambda./n;
 
figure(3);
title("Poisson process as the limit of the binomial process");
xlabel("k values");
ylabel("Probability");
hold on;
for i=1:3
  binomial = binopdf(k,n(i),p(i));
  stem(k,binomial,colors(i),'linewidth',1.2);
endfor 
hold off;
legend("n=300","n=3000","n=30000");


# TASK: In a common diagram, design the Probability Mass Function of Exponential processes
# with mean 0.5, 1, 3. In the horizontal axes, choose k parameters 
# between 1 and 8. 
 
# I use a larger step 0.0001 instead of 0.00001
# because my computer can't handle it and octave crashes
k = 0:0.0001:8;
expmean = [0.5,1,3,2.5];
 
for i=[1 2 3 4]
  exponpdf(i,:) = exppdf(k,expmean(i));
endfor
 
colors = "rbm";
figure(4);
hold on;
for i=[1 2 3]
  plot(k,exponpdf(i,:),colors(i),"linewidth",1.2);
endfor
hold off;
 
title("Probability Mass Function of Exponential processes");
xlabel("k values");
ylabel("probability");
legend("mean=0.5","mean=1","mean=3");
 
 
# TASK: In a common diagram, design the Cumulative Distribution Function of Exponential processes
# with mean 0.5, 1, 3.
 
for i=[1 2 3 4]
  exponcdf(i,:) = expcdf(k,expmean(i));
endfor
 
colors = "rbm";
figure(5);
hold on;
for i=[1 2 3]
  plot(k,exponcdf(i,:),colors(i),"linewidth",1.2);
endfor
hold off;
 
title("Cumulative Distribution Function of Exponential processes");
xlabel("k values");
ylabel("probability");
legend("mean=0.5","mean=1","mean=3");

# TASK: Compute the probabilities P(X>30000) and P(X>50000|X>20000)
# using the cdf with mean 2.5
 
display("Probability P(X>30000) is");
display(1-exponcdf(4,30000));
display("Probability P(X>50000|X>20000) is");
display((1-exponcdf(4,50000))/(1-exponcdf(4,20000)));

# TASK: Plot a Poisson Process counting 100 random arrivals

d=exprnd(1/5,1,100);
timeArrivals=zeros(1,101);
for i=2:101
  timeArrivals(i)=timeArrivals(i-1)+d(i-1);
endfor
 
figure(6) 
stairs(timeArrivals,0:100);
title("Poisson counting process");
ylabel("arrivals");
xlabel("time (sec)");
 
# TASK: Compute the average number of arrivals per second

numArrivals=[100 200 300 500 1000 10000];
display("Average number of arrivals per second for 100, 200, 300, 500, 1000, 10000 arrivals");
for i=1:6
  d=exprnd(1/5,1,numArrivals(i));
  timeArrivals=zeros(1,numArrivals(i)+1);
  for n=2:numArrivals(i)+1
    timeArrivals(n)=timeArrivals(n-1)+d(n-1);
  endfor
  display(numArrivals(i)/timeArrivals(numArrivals(i)+1));
endfor

