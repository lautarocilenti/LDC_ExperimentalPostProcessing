function [] = SynthesizeFrequencyData()
AddAllPaths();
M = Parameters();

files = dir(fullfile(M.folder,"RAW*.mat"));
% names = ["down","up"];
sweep.date = datetime("now");
sweep.dateNum = datenum(sweep.date);

    for i = 1:2
        file = fullfile(files(i).folder,files(i).name);
        data = load(file);
        data = data.data.Data;
        sweep.names{i} = files(i).name;
        sweep.time{i} = data.Time.data(1:end-1);
        sweep.control{i} = data.Control.data(1:end-1);
        sweep.strain{i} = data.Strain1.data(1:end-1);
        sweep.frequency{i} = data.Untitled_2.data(1:end-1);
        sweep.noiseIntensity{i} = data.Untitled_3.data(1:end-1);
    end
save(fullfile(files(i).folder,"A_frequencySweep.mat"),"sweep","-v7.3");
end

