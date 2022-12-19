function binary_array = generate_1D_rudinShapiro_array(generation,seed)
% http://en.wikipedia.org/wiki/Rudin%E2%80%93Shapiro_sequence
% http://mathworld.wolfram.com/Rudin-ShapiroSequence.html

% 20120408
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

if seed~=0 && seed~=1 && seed~=2 && seed~=3
  disp('  ')
  disp('  seed must be either 0 or 1 or 2 or 3.');
  disp('  ')
  stop
end


gensize=2^generation;

switch seed
case 0
  letter='A';
case 1
  letter='B';
case 2
  letter='C';
case 3
  letter='D';
end
current_array=seed;
for iteratn=1:generation
  clear grid nextarray
  nextarray=zeros(1,size(current_array,2)*2);
  for indx=1:size(current_array,2)
    if current_array(indx)==0 % g(A) = AC
      nextarray(indx*2-1)=0;
      nextarray(indx*2  )=2;
    elseif current_array(indx)==1 % g(B)=DC
      nextarray(indx*2-1)=3;
      nextarray(indx*2  )=2;
    elseif current_array(indx)==2 % g(C)=AB
      nextarray(indx*2-1)=0;
      nextarray(indx*2  )=1;
    elseif current_array(indx)==3 % g(D)=DB
      nextarray(indx*2-1)=3;
      nextarray(indx*2  )=1;
    else
      disp('unexpected error')
    end
  end
  current_array=nextarray; % initial 1D basis, (4 letters for RS)
end

% convert from 4 letters to 2 letters
binary_array=current_array;
for indx=1:size(current_array,2)
  if current_array(indx)==2
    binary_array(indx)=0;
  elseif current_array(indx)==3
    binary_array(indx)=1;
  end
end
%binary_array % initial 1D basis, 2 letters
