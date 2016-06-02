% Reference: Prof. Kinsman's Lecture Code
% Reference: Optical Character Recognition Code by Ankit Saroch.
% Found from following link:
% http://www.mathworks.com/matlabcentral/fileexchange/31322-optical-character-recognition-lower-case-and-space-included-
function Digitize_Handwriting
Create_Characters
image = imread('TEST_IMAGES\ISCOOL.jpg');
Find_Text(image);
My_OCR
end