function sourceGrid = generate_1D_baumSweet_array(generation,seed)
% http://en.wikipedia.org/wiki/Baum%E2%80%93Sweet_sequence

% example usage:
%med=convert_2D_array_to_coordinates(convert_1D_binary_to_2D_array(generate_1D_baumSweet_array(4,1)'),1);
%plot(med(:,1),med(:,2),'MarkerSize',8,'Marker','.','LineStyle','none'); axis equal tight

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

initialGrid=[1 1];
gen=0;

for gen=1:generation
  sourceGrid=zeros(1,2*size(initialGrid,2));
  srcindx=1;
  for indx=1:2:size(initialGrid,2);
    if     initialGrid(indx)==0 & initialGrid(indx+1)==0 %  00 --> 0000
      sourceGrid(1,srcindx:srcindx+3)=[0 0 0 0];
    elseif initialGrid(indx)==0 & initialGrid(indx+1)==1 %  01 --> 1001
      sourceGrid(1,srcindx:srcindx+3)=[1 0 0 1];
    elseif initialGrid(indx)==1 & initialGrid(indx+1)==0 %  10 --> 0100
      sourceGrid(1,srcindx:srcindx+3)=[0 1 0 0];
    elseif initialGrid(indx)==1 & initialGrid(indx+1)==1 %  11 --> 1101
      sourceGrid(1,srcindx:srcindx+3)=[1 1 0 1];
    else
      disp('error in Baum-Sweet')
      stop
    end
    srcindx=srcindx+4;
  end
  initialGrid=sourceGrid;
end

if seed==0
  sourceGrid=abs(sourceGrid-1);
end




