function speaker_number = addspeaker()
%%how many training samples we have.. access the folder and know
traindir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train\';   
a = dir([traindir '*.wav']);
s = numel(a);
recObj = audiorecorder(44100,16,1);
fprintf('say ZERO immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
filename = sprintf('%ss%d.wav', traindir, s+1); 
audiowrite(filename,x,8000);
speaker_number = s+1;