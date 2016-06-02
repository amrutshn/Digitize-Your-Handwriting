function [fc, rc, space] = crop_letters(inp_image)
% Cropping different letters in a given line.


img = strip_line(inp_image);
count_num = size(img,2); % Take the height of the pixels into consideration.
fc= [];
rc= [];
space = [];
for x = 1:count_num
    col_sum = sum(img(:,x));
    
    if col_sum == 0
        % flm contains the matrix for first letter.
        flm = img(:,1:x-1);
%         imshow(flm);
%         pause();
        %rlm contains the matrix for the rest of the letters in the line.
        rlm = img(:,x:end);
%         imshow(rlm);
%         pause();
        fc = strip_line(flm);
        rc = strip_line(rlm);
        
        space = size(rlm,2) - size(rc,2);

    % UNCOMMENT THE LINES BELOW TO SEE RESULTS
%         subplot(2,1,1);
%         imshow(fc);
%         subplot(2,1,2);
%         imshow(rc);
        break;
    else
        fc = img;   % Only a single line. 
        rc = [];
        space = 0;
    end
end
end

% Stripping the unwanted pixels upto the edges of the 
function img_out = strip_line(inp_img)
% Find the indices of all pixels in the image.
[rows, cols] = find(inp_img);

% Strip the image uptil one line of a text is obtained.
img_out = inp_img(min(rows):max(rows), min(cols):max(cols));
end