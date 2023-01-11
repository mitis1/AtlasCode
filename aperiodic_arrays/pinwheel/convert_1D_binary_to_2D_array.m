function sourceGrid = convert_1D_binary_to_2D_array(sequenc)

% 20120411
% Ben Payne

if nargin ~= 1,
  disp('  invalid number of input parameters')
  disp('  input1: binary sequence')
  return
end

gensize=size(sequenc,1);

sourceGrid=zeros(gensize,gensize);
sourceGrid(:,1)=sequenc;

firstval=sequenc(1);
for indx=1:gensize,
  if sourceGrid(indx,1)==firstval
    sourceGrid(indx,:)=sequenc;
  end
end

for indx=1:gensize,
  if sourceGrid(indx,1)==abs(firstval-1)
    sourceGrid(indx,:)=abs(sequenc-1);
  end
end
