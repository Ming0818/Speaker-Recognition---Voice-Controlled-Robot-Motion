function record_commands()

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

for i= 1:1:samp
s_ahead = numel(dir([aheaddir '*.wav']));    
fprintf('say AHEAD immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
filename = sprintf('%ss%d.wav', aheaddir, s_ahead+1); 
audiowrite(filename,x,8000);
end

for i= 1:1:samp
s_back = numel(dir([backdir '*.wav']));    
fprintf('say BACK immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
filename = sprintf('%ss%d.wav', backdir, s_back+1); 
audiowrite(filename,x,8000);
end
for i= 1:1:samp
s_right = numel(dir([rightdir '*.wav']));    
fprintf('say RIGHT immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
filename = sprintf('%ss%d.wav', rightdir, s_right+1); 
audiowrite(filename,x,8000);
end

for i= 1:1:samp
s_stop = numel(dir([stopdir '*.wav']));    
fprintf('say STOP immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
filename = sprintf('%ss%d.wav', stopdir, s_stop+1); 
audiowrite(filename,x,8000);
end

for i= 1:1:samp
s_left = numel(dir([leftdir '*.wav']));    
fprintf('say LEFT immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
filename = sprintf('%ss%d.wav', leftdir, s_left+1); 
audiowrite(filename,x,8000);
end