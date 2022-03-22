function [] = ExportEPS(fig,filename)
    Folder = cd;
    f1.PaperUnits = 'inches';
    f1.PaperPosition = [0 0 6 3];
    print(fig,'-depsc',filename)

end

