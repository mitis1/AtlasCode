function scatterer_coordinates = convert_2D_array_to_coordinates(sourceGrid,scatr_const)
% change from 2D to coordinates
% 
if nargin ~= 2,
  disp('  invalid number of input parameters')
  disp('  ')
  disp('  input1: 2D array of binary values')
  disp('  input2: scatr_const, either 0 or 1')
  disp('  ')
  disp('  stopping due to input problem')
  return
end

if scatr_const==1
  scatterer_coordinates = zeros(sum(sum(sourceGrid)),2); 
else
  scatterer_coordinates = zeros(size(sourceGrid,1)*size(sourceGrid,2) - sum(sum(sourceGrid)),2); 
end

scatcount=0;
for xindx=1:size(sourceGrid,1)
  for yindx=1:size(sourceGrid,1)
    if sourceGrid(xindx,yindx) == scatr_const,
      scatcount=scatcount+1;
      scatterer_coordinates(scatcount,1:2)=[xindx yindx]; 
    end
  end
end
%{
plot(medxy(:,1),medxy(:,2),'MarkerFaceColor',[0 0 0],'MarkerSize',6,'Marker','o',...
    'LineStyle','none','Color',[0 0 0]); axis equal tight;   
%}
%save([filename '_medium.dat'],'medxy','-ascii','-tabs');
