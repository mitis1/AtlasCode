function map = gray_blue()

    col_1 = [0 0 0]/255;
    col_2 = [173 216 230]/255;
    col_3 = [255 255 255]/255;

    map = [linspace(col_1(1),col_2(1),col_3(1))',...
           linspace(col_1(2),col_2(2),col_3(2))',...
           linspace(col_1(3),col_2(3),col_3(3))'];
end