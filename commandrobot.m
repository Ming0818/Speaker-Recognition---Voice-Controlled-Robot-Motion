function commandrobot()

 trai_pairs=30;
 out_neurons=5;
 hid_neurons=6;
 in_nodes=13;
 eata=0.1;emax=0.001;q=1;e=0;lamda=.7;  t=1;
 load backp.mat W V;
 recObj = audiorecorder;
 Fs=8000;
 Nseconds = 1;

while(1)
fprintf('say any word immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
[kk,g] = lpc(x,12);
Z=(kk);
 Z=double(Z);
 p1=max(Z);
 Z=Z/p1;


for p=1:trai_pairs
    
    z=transpose(Z(p,:));
%  calculate output
   y=(tansig(V*(z)));
   o=(tansig(W*(y)));
   break
end
  
    b=o(1);
    c=o(2);
    d=o(3);
    e=o(4);
    f=o(5);
    a= max(o);
    if (b==a )
    display('AHEAD');
    elseif (c== a)
        display('STOP');
    elseif (d== a)
        display('BACK');
    elseif (e==a)
        display('LEFT');
    elseif (f==a)
        display('RIGHT');
    end
end