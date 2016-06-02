% Reference: Prof. Kinsman's  Lecture Code
% Reference: Optical Character Recognition Code by Ankit Saroch.
function Find_Text(img )
% Function to differentiate between the foreground and background pixels.
close all;

% Set INTERACTIVE = 1 in order to let the user identify text in the given image.
INTERACTIVE = 1

im_rgb=img;
% im_rgb=imrotate(im_rgb,270);
%  imshow(im_rgb);    

% Apply Gaussian filter to remove noise and smoothen the image.
gauss = fspecial('Gaussian', 3 ,3);
im_rgb= imfilter(im_rgb,gauss, 'same','repl');
imshow(im_rgb);

pause(3);


if INTERACTIVE

fprintf('SELECT HANDWRITTEN TEXT');
fprintf('Click on points to capture positions');

% Take input from user(text) and store the point's co-ordinates.
[x_fg, y_fg] = ginput();

fprintf('SELECT BACKGROUND OBJECT ... ');
fprintf('Click on points to capture positions:  Hit return to end...\n');

% Take input from user(objects other than the graffiti text) and store the point's co-ordinates.
[x_bg, y_bg] = ginput();
save my_temp_graffiti

else
    load my_temp_graffiti
end

% Run it for the LAB space. LAB space is chosen as we can easily deal with
% intensties of the foreground and background pixels.
im_lab      = rgb2lab( im_rgb );
im_a        = im_lab(:,:,2);
im_b        = im_lab(:,:,3);


% sub2ind helps identify the linear index equivalent to the row and column subscripts specified for 
% matrix specified.  
fg_indices  = sub2ind( size(im_lab), round(y_fg), round(x_fg) );
fg_a        = im_a( fg_indices );
fg_b        = im_b( fg_indices );
    
% Similar operations for background pixels.
bg_indices  = sub2ind( size(im_lab), round(y_bg), round(x_bg) );
bg_a        = im_a( bg_indices );
bg_b        = im_b( bg_indices );
        
fg_ab       = [ fg_a fg_b ];            % This forms a matrix of the two features of the foreground pixels
bg_ab       = [ bg_a bg_b ];            % This forms a matrix of the two features of the background pixels
im_ab       = [ im_a(:) im_b(:) ];     
    
% Used to calculate Mahalanobis distance to determine how many points away
% a standard deviation is from the mean.
mahal_fg    = ( mahal( im_ab, fg_ab ) ) .^ (1/2);
mahal_bg    = ( mahal( im_ab, bg_ab ) ) .^ (1/2);
    

%  Classify as Class 0 (foreground object) if distance to FG is < distance to BG.
% Multiplied by a constant to choose only those pixels that are evidently
% the handwritten text.
class_0     = mahal_fg*3< mahal_bg;

% Reshape will reshape class_0 vector into a matrix whose dimensions are
% determined by the size of the im_a image obtained.
class_im    = reshape( class_0, size(im_a,1), size(im_a,2) );

% Removal of unwanted pixels. Removes all components that are
% fewer than 60 pixels.
class_im = bwareaopen(class_im,30);

figure('Position',[10 10 1024 768]);
subplot(1,2,1);
imagesc(im_rgb);
axis image;
title(' Original Image', 'FontSize', 20, 'FontWeight', 'bold' );    
subplot(1,2,2);
imagesc( class_im );
axis image;
colormap(gray);
title('Handwritten Text', 'FontSize', 20, 'FontWeight', 'bold' );

% Write the image which will be used in the Character Recognition Process.
imwrite(class_im,'Handwritten_Text.JPG');
end