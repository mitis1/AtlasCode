function map = cmap3( N )

    col_1 = [0, 155, 97]/255;
    col_2 = [255, 155, 97]/255;

    map = [linspace(col_1(1),col_2(1),N)',...
           linspace(col_1(2),col_2(2),N)',...
           linspace(col_1(3),col_2(3),N)'];
end