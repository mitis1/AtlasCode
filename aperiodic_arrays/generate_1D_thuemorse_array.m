function sourceGrid = generate_1D_thuemorse_array(generation,seed)
% http://oeis.org/A010060
% http://mathworld.wolfram.com/Thue-MorseSequence.html
% http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence

% 20120123
% Ben Payne

if nargin ~= 2,
  disp('  invalid number of input parameters')
  disp('  input1: generation')
  disp('  input2: seed')
  return
end
if generation<1
  disp('  input generation must be larger than 1')
end
if mod(generation,1)~=0
  disp('  input generation must be a postive integer')
end

if seed~=0 && seed~=1
  disp('  ')
  disp('  seed must be either 0 or 1.');
  disp('  ')
  stop
end


gensize=2^generation;

% create 1D Thue-Morse binary sequence
TMarray=zeros(1,gensize);
TMarray(1,1)=seed;
for n=1:generation,
  TMarray(1,2^(n-1)+1:2^n)=~TMarray(1,1:2^(n-1));
end

% convert from 1D to 2D array
sourceGrid=zeros(gensize,1);
sourceGrid(:,1)=TMarray;

