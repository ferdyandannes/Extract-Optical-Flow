clc
clear 
close all


main_dir = '/media/ee401_2/SPML/Ferdyan/tugas_ferdyan/video/'
save_dir = '/media/ee401_2/SPML/Ferdyan/tugas_ferdyan/video/'

src1 = dir(main_dir);
src1 = src1(3:end);

% setelah video 1x
for k = 1:length(src1)
    fname1 = src1(k).name;
    sub1 = strcat(save_dir,fname1);
    
    src2 = dir(sub1);
    src2 = src2(3:end);
    
    % setelah video 2x
    for l = 1:length(src2)
        fname2 = src2(l).name;
        sub2 = fullfile(sub1, fname2);
        
        % save di sub2
        subx = '/x/';
        suby = '/y/';
        outdirx = fullfile(sub2, subx)
        outdiry = fullfile(sub2, suby);
        
        %%%% tambahan
        if exist(outdirx, 'dir')
            continue
        else
            src3 = dir(sub2);
            src3 = src3(3:end);

            for m = 1:length(src3)
                fname3 = src3(m).name;
                subi = '/i/';
                sub3 = fullfile(sub2, subi)

                img_dir = fullfile(sub3, '*.jpg');
                jpg_Files = dir(img_dir);

                hitung = 1;

                for n = 1:length(jpg_Files)
                    baseFileName = jpg_Files(n).name;
                    fullFileName = fullfile(sub3, baseFileName);
                    fprintf('Now reading %s\n', fullFileName);
                    
                    if length(jpg_Files) == 1
                        im1 = double(imread(fullFileName));
                        im2 = double(imread(fullFileName));
                        
                        flow = mex_OF(im1,im2);
                        x = (flow(:,:,1).*16) + 128;
                        x = uint8(x);
                        y = (flow(:,:,2).*16) + 128;
                        y = uint8(y);
                        
                        if ~exist(outdirx, 'dir') mkdir(outdirx); end
                        if ~exist(outdiry, 'dir') mkdir(outdiry); end

                        save_x = fullfile(outdirx, baseFileName_old);
                        save_y = fullfile(outdiry, baseFileName_old);
                        imwrite(x,save_x);
                        imwrite(y,save_y);
                        
                    elseif hitung > 1 && hitung < 11
                        im1 = double(imread(fullFileName_old));
                        im2 = double(imread(fullFileName));

                        flow = mex_OF(im1,im2);
                        x = (flow(:,:,1).*16) + 128;
                        x = uint8(x);
                        y = (flow(:,:,2).*16) + 128;
                        y = uint8(y);

                        if ~exist(outdirx, 'dir') mkdir(outdirx); end
                        if ~exist(outdiry, 'dir') mkdir(outdiry); end

                        save_x = fullfile(outdirx, baseFileName_old);
                        save_y = fullfile(outdiry, baseFileName_old);
                        imwrite(x,save_x);
                        imwrite(y,save_y);

                        if hitung == length(jpg_Files)
                            save_x_last = fullfile(outdirx, baseFileName);
                            save_y_last = fullfile(outdiry, baseFileName);
                            imwrite(x,save_x_last);
                            imwrite(y,save_y_last);
                        end
                    end
                    baseFileName_old = baseFileName;
                    fullFileName_old = fullFileName;
                    hitung = hitung + 1;
                end
            end 
        end
    end
end