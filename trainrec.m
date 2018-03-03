

%train('C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train\', 7)
function speaker_id = trainrec()
traindir = 'C:\Users\Rezetane\Desktop\HRI Proj\Speech-Recognition-master\data\train\';   
a = dir([traindir '*.wav']);
n = numel(a);
% kc = 16;                       
kc = 2 * n; 
for i=1:n                       
     file = sprintf('%ss%d.wav', traindir, i);           
%      disp(file);
        [s, fs] = audioread(file);  

      v = mfcc(s, fs);            % Compute MFCC's
   
%    code{i} = vqCodeBook(v, k);      % Train VQ codebook
    code{i} = vqCodeBook(v, kc); 
end


recObj = audiorecorder(44100,16,1);
fprintf('say ZERO immediately after hitting enter');
input('');
recordblocking(recObj, 1);
x = getaudiodata(recObj);
%[recObj.TotalSamples, recObj.SampleRate] = audioread(x);      
%[s, fs] = audioread(x);      
    v = mfcc(x, recObj.SampleRate);            % Compute MFCC's
   
    distmin = inf;
    k1 = 0;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = distance(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);                                                                               
      
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
    end
                                                                                                                                                                                                                                                                                                  
    msg = sprintf('You match speaker number %d', k1);                                                                                                                                                                                                                                                                               
    speaker_id=k1;
    if k1 == n 
        access_ = 1 ;
    else 
        access_ = 0 ;
    end
    disp(msg);

