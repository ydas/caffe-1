function GenerateTrainTestFiles

ImageDir='G:\Temp\ImagesBing';
%Dirs={'Tables','BarCharts','PieCharts','Graphs'};
Dirs={'table','pieChart','map','graphic','lineGraph','barChart','photo'};

trainFile='G:\GitHub\caffe\examples\yves\train.txt';
testFile='G:\GitHub\caffe\examples\yves\val.txt';

TRAIN_RATIO=0.70;

train_files=[];
test_files=[];

for k=1:length(Dirs)

    fils=dir([ImageDir '\' Dirs{k}]);
    fils=fils(find(~[fils.isdir]));
    fils={fils.name};
    ma=regexp(fils,'\.(jpg|jpeg|png|gif)','match');
    ids=find(~cellfun(@isempty,ma));
    fils=fils(ids);
    for j=1:length(fils)
        %for caffe, replace ' ' and '%' and '.' by '_'
        [p name e]=fileparts(fils{j});
        ma=regexpi(name,'(\s|\%|\.)','match');
        if ~isempty(ma)
            name=regexprep(name,'(\s|\%|\.)','_');
            movefile([ImageDir '\' Dirs{k} '\' fils{j}],[ImageDir '\' Dirs{k} '\' name e]);
        end
        fils{j}=[Dirs{k} '/' name e ' ' num2str(k)];
    end
    %shuffle
    fils=fils(randperm(length(fils)));
    id=floor(TRAIN_RATIO*length(fils));
    
    %split
    train_files=[train_files  fils(1:id)];
    test_files=[test_files  fils(id+1:end)];
    
end

fid=fopen(trainFile,'w+');
for k=1:length(train_files)
    fprintf(fid,'%s\n',train_files{k});
end
fclose(fid);
fid=fopen(testFile,'w+');
for k=1:length(test_files)
    fprintf(fid,'%s\n',test_files{k});
end
fclose(fid);

disp('Done');

return;

end