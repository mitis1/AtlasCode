function final = remove_elts(mat,x_cols, y_rows)
    sz = length(x_cols);
    final = mat;
    for i = 0:sz-1
        final(y_rows(sz - i), :) = [];
        final(:, x_cols(sz-i)) = [];
    end
end