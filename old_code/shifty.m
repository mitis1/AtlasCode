function result = shifty(mat,num)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
y_size = size(mat, 1);
if(num < 0)
    result = zeros(size(mat));
    result(1:y_size+num, :) = mat((-1*num)+1:end, :);
else
    result = zeros(size(mat));
    result(num+1:end, :) = mat(1:y_size-num, :);
end
end