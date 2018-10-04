for d=1:9
    [ err , model ] = polyreg (x , y , d) ;
    title(sprintf('d=%d',d));
    fulldataset_errors(d)=err;
    fulldatasetmodels{d}=model;

    filename = sprintf('p1_d%d.png',d);
    print(filename,'-dpng');
end