function [] = ExportPNG(fig,filename)
%EXPORTPNG Generates a png file of inout figure with input filename
    Folder = cd;
    f1.PaperUnits = 'inches';
    f1.PaperPosition = [0 0 6 3];
    print(fig,'-dpng',filename);
end

