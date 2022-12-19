function sourceGrid = generate_1D_fibonacci_array(generation,seed)
% http://en.wikipedia.org/wiki/Fibonacci_word

% example usage:
% med=convert_2D_array_to_coordinates(convert_1D_binary_to_2D_array(generate_1D_fibonacci_array(8,0)'),1);
% plot(med(:,1),med(:,2),'MarkerSize',8,'Marker','.','LineStyle','none'); axis equal tight     

% 20120413
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


initialAry=[0];
nextAry=[0 1];
if generation==1
  sourceGrid=nextAry;
  return
end

for gen=2:generation
  sourceGrid=zeros(1,size(initialAry,2)+size(nextAry,2));
  srcindx=1;
  for indx=1:size(nextAry,2),
    if nextAry(indx)==0
      sourceGrid(1,srcindx:srcindx+1)=[0 1];
      srcindx=srcindx+2;
    elseif nextAry(indx)==1
      sourceGrid(1,srcindx)=0;
      srcindx=srcindx+1;
    else
      disp('error in fib')
      stop
    end
  end
  initialAry=nextAry;
  nextAry=sourceGrid;
end

if seed==1
  sourceGrid=abs(sourceGrid-1);
end