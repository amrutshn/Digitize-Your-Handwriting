%To perform OCR on the image.
clc;
close all;

% Read in the image that was generated for finding the text.
image = imread('Handwritten_Text.JPG');

% image = imtophat(image,strel('disk',20));
% imshow(image);

% Perform dilation to increase the edge strength 
% of the characters in the text.
se1 = strel('disk' , 5);
image= imdilate(image,se1);
% imshow(image);

% Remove unwanted pixels/noise from the image.

image_trh = bwareaopen(image, 100);
%figure,imshow(imagen3);
%title('after bwareaopen')


% TEXT: BLACK and Background: White
% image = ~image_trh;
% %figure,imshow(imagen3);
% %title('after bwareaopen')
% imwrite(image,'Test.JPG');
% % imshow(image);
% image = ~image;

% Store the text from image in word.
word = [];
re = image;
% imshow(re);

% Opens a text file for writing the results of character recognition.
fid = fopen('myText.txt', 'wt+');
% Loads the characters saved previously.
load characters
global characters

% Gets the number of characters present in the 2-D characters array.
count_letters = size(characters,2);

while 1
    % 'crop_lines' function is used to differentiate
    % the different lines of text in the image.
    % fl contains the first line of matrix from re image.
    % re contains the image that is left.
    [fl re] = crop_lines(re);   
    rem_img = fl;
    n = 0;
%     figure;
%     imshow(fl);
%     title('line');
    
    
    % Used to compute if there exists enough space between two characters 
    % to compute it as a space.
    check_spaces = [];
   
    % Pass the a single line text obtained from 'crop_lines' to find
    % letters individually.
    rc = fl;

    while 1
        
        % 'crop_letters' is used to separate each letter in a line.
        % fc contains the first letter in the line being passed.
        % rc contains the remaining characters present in the line.
        % space contains the space between the letter cropped and the next
        % letter.
        [fc, rc, space] = crop_letters(rc);
        
        %figure,imshow(fc);
        
        % Resize the pixels so that correlation can be performed.
        img_resized = imresize(fc, [42 24]);
        
        % Maintain a count of the number of characters or letters.
        n = n+1;
        check_spaces(n)=space;
        
        % 'read_letters' correlates the cropped letter with the images
        % present in the folder 'letters'.
        letter = read_letters(img_resized, count_letters);
        
        % Add the letter to the existing word.
        word = [word letter];
%         word
        % Break the loop when there are no more letters in the line.
        if isempty(rc)
            break;
        end
    end
    
    % Finds the maximum of check_spaces.
    max_space = max(check_spaces);
    no_spaces = 0;
    
    % Run a loop to put a space at locations where they exist in the
    % original image.
    for x = 1:n
        % Determine a threshold value for a character to be chosen as a
        % space. In this case, if the distance between any two characters
        % value is more than 0.5 times the letter size then we can 
        % classify it as a space character.
        if check_spaces(x+no_spaces)>(0.5*max_space)
            no_spaces = no_spaces + 1;
            for m = x:n
                % Iterate from the end of the word to the position where
                % space needs to be inserted.
                word(n-m+x+no_spaces)=word(n-m+x+no_spaces-1);
            end
            % Insertion of a space character in between the words.
            word(x+no_spaces) = ' ';
            check_spaces = [0 check_spaces];
        end
    end
    % Write the letters present in the 'word' to the text document.
    fprintf(fid,'%s\n',word);
    
    % Flush the word array to handle the next line of text, if any.
    word = [ ];
    
    % If the line of text has finished then break the loop
    if  isempty(re)
        break
    end
end
fclose(fid);
% Opens the text file in a new window.
winopen('myText.txt')
