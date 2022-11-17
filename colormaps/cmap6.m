function map = cmap6( N )

    col_2 = [174 196 176]/255;
    col_1 = [ 19  69  89]/255;

    map = [linspace(col_1(1),col_2(1),N)',...
           linspace(col_1(2),col_2(2),N)',...
           linspace(col_1(3),col_2(3),N)'];
end