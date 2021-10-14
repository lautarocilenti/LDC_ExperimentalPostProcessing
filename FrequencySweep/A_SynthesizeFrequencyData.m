function [] = SynthesizeFrequencyData()
AddAllPaths();
M = Parameters();

files = dir(fullfile(M.folder,"*.mat"));
% names = ["down","up"];
sweep.date = datetime("now");
sweep.dateNum = datenum(sweep.date);

    for i = 1:2
        file = fullfile(files(i).folder,files(i).name);
        data = load(file);
        data = data.data.Data;
        sweep.names{i} = files(i).name;
        sweep.time{i} = data.Time.data;
        sweep.control{i} = data.Control.data;
        sweep.strain{i} = data.Strain1.data;
        sweep.frequency{i} = data.Untitled_2.data;
        sweep.noiseIntensity{i} = data.Untitled_3.data;
    end
save(fullfile(files(i).folder,"A_frequencySweep.mat"),"sweep","-v7.3");
end

