function traincommands()
Fs=8000;
Nseconds = 1;
samp=6;
words=5;
recObj = audiorecorder;
aheaddir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train_commands\ahead\';   
backdir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train_commands\back\';   
stopdir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train_commands\stop\';   
rightdir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train_commands\right\';   
leftdir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train_commands\left\';   
s_right = numel(dir([rightdir '*.wav']));    

for i= 1:1:samp
   
filename = sprintf('%ss%d.wav', aheaddir, i); 
fprintf('Reading %ss%d ',aheaddir,i);
[x,Fs] = audioread(filename);
[s(i,:),g] = lpc(x,12); 
end

for i= (samp+1):1:2*samp
    
filename = sprintf('%ss%d.wav', stopdir, i- samp); 
fprintf('Reading %ss%d ',stopdir,i);
[x,Fs] = audioread(filename);
[s(i,:),g] = lpc(x,12);
%plot(s(i,:));
end
 
for i= (2*samp+1):1:3*samp
filename = sprintf('%ss%d.wav', backdir, i-2*samp); 
fprintf('Reading %ss%d ',backdir,i);
[x,Fs] = audioread(filename);
[s(i,:),g] = lpc(x,12);
end

for i= (3*samp+1):1:4*samp
filename = sprintf('%ss%d.wav', leftdir, i-3*samp); 
fprintf('Reading %ss%d ',leftdir,i);
[x,Fs] = audioread(filename);
[s(i,:),g] = lpc(x,12);
end

for i= (4*samp+1):1:5*samp
    
filename = sprintf('%ss%d.wav', rightdir, i- 4*samp); 
fprintf('Reading %ss%d ',rightdir,i);
[x,Fs] = audioread(filename);
[s(i,:),g] = lpc(x,12);
end

S=zeros(1,13);
for i=1:1:samp
    S=cat(1,S,s(i,:));
    S=cat(1,S,s(samp+i,:));
    S=cat(1,S,s(2*samp+i,:));
    S=cat(1,S,s(3*samp+i,:));
    S=cat(1,S,s(4*samp+i,:));
end
S(1,:)=[];
save speechp.mat S
trai_pairs=30; % 48 samples
out_neurons=5; % no of words
hid_neurons=6; %matka
in_nodes=13; %features are 13
eata=0.1;emax=0.001;q=1;e=0;lamda=.7;  t=1;


load speechp.mat S

p1=max(max(S));
s=S/p1;

Z= double(s);

dummy=[1 -1 -1 -1 -1;
   -1 1 -1 -1 -1;
   -1 -1 1 -1 -1;
   -1 -1 -1 1 -1;
   -1 -1 -1 -1 1];
   
t=trai_pairs/out_neurons;
D=dummy;
for i= 1:1:5
    D=cat(1,D,dummy);
end
%step 1 initialisation of weight matrices

W=randn(out_neurons,hid_neurons);
V=randn(hid_neurons,in_nodes);
for main_loop=1:3000

% step 2 training step starts here compute layer responses

for p=1:trai_pairs
    z=transpose(Z(p,:));
  d=transpose(D(p,:));
 %calculate output of hidden and output layer

   y=(tansig(V*(z)));
   o=(tansig(W*(y))); 

% step 3 Error value is computed

        e=0.5*norm(d-o)^2+e;

% step 4 error signal vectors of both layers are computed
                 
                 % error signal vector for output layer
              
                 for k=1:out_neurons
                       delta_ok(k,:)=0.5*(d(k)-o(k))*(1-o(k)^2);
                 end

                 %error signal vector for hidden layer

                 for j=1:hid_neurons
                        sum=0;
                 for k=1:out_neurons
                 sum=sum+delta_ok(k)*W(k,j);
                 end
                 delta_yj(j,:)=0.5*(1-y(j)^2)*sum;
                 end

% step 5 Adjust weights of output and hidden layer

     W=W+eata*delta_ok*transpose(y);
     V=V+eata*delta_yj*transpose(z);
     q=q+1;                           % update step counter
 end

% step 6 training cycle is completed

fprintf('error=%f no of epcohes = %d \n',e,main_loop);
            if e>=emax
               e=0;
            else
               save backp20_2.mat W V Z;
                   break;
            end
                  
end 
save backp.mat W V Z;
trai_pairs=30; %48 samples
out_neurons=5; %hello,left,right
hid_neurons=6; 
in_nodes=13; %13 features
eata=0.1;emax=0.001;q=1;e=0;lamda=.7;  t=1;

for p=1:trai_pairs
    
    z=transpose(Z(p,:));
%  calculate output
   y=(tansig(V*(z)));
   o=(tansig(W*(y)));
    
  % pause
end