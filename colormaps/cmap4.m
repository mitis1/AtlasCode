function map = cmap4( N )

    col_1 = [0,  100, 21];
    col_2 = [100, -100, 21];

    map = [linspace(col_1(1),col_2(1),N)',...
           linspace(col_1(2),col_2(2),N)',...
           linspace(col_1(3),col_2(3),N)'];

    map = lab2rgb(map);
    map( map<0 ) = 0;
    map( map>1 ) = 1;
end