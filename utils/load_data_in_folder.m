toppath = genpath(pwd);
addpath(toppath);

pushd('../data - complete/Part 4');


files = dir();
for i=3:(size(files,1))
    if files(i).isdir == 0 && strcmp(files(i).name((end-2):end), "mat") 
        load(files(i).name)
    end
end

popd

rmpath(toppath);


