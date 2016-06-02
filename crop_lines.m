function [fl re]=crop_lines(im_line)

im_line = strip_line(im_line);
% im_line
count_num = size(im_line,1);
count_num
for x = 1:count_num
    if sum(im_line(x,:))==0
        flm = im_line(1:x-1, :);    % First Line Matrix
        rlm = im_line(x:end, :);    % Second Line Matrix
        
        fl = strip_line(flm);
        
%         pause(2);
        re = strip_line(rlm);
        %temp=fl
        
        break
    else
        fl=im_line;%Only one line.
        re=[ ];
    end
end
figure;
imshow(fl);
title('TEXT IN A LINE');
end

% Stripping the unwanted pixels upto the edges of the 
function img_out = strip_line(inp_img)
% Find the indices of all pixels in the image.
[rows cols] = find(inp_img);

% Strip the image uptil one line of a text is obtained.
img_out = inp_img(min(rows):max(rows), min(cols):max(cols));
end