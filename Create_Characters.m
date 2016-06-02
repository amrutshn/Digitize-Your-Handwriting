% Creation of characters:
clc;
% Read all the uppercase characters.
A=imread('letters\A.bmp');B=imread('letters\B.bmp');
C=imread('letters\C.bmp');D=imread('letters\D.bmp');
E=imread('letters\E.bmp');F=imread('letters\F.bmp');
G=imread('letters\G.bmp');H=imread('letters\H.bmp');
I=imread('letters\I.bmp');J=imread('letters\J.bmp');
K=imread('letters\K.bmp');L=imread('letters\L.bmp');
M=imread('letters\M.bmp');N=imread('letters\N.bmp');
O=imread('letters\O.bmp');P=imread('letters\P.bmp');
Q=imread('letters\Q.bmp');R=imread('letters\R.bmp');
S=imread('letters\S.bmp');T=imread('letters\T.bmp');
U=imread('letters\U.bmp');V=imread('letters\V.bmp');
W=imread('letters\W.bmp');X=imread('letters\X.bmp');
Y=imread('letters\Y.bmp');Z=imread('letters\Z.bmp');

all_letters = [A B C D E F G H I J K L M N O P Q R S T U V W X Y Z];

% Store an array of arrays of individual characters.
% Since the characters are of 24x42 pixels in dimension,
% we create an array of 42x24 pixel arrays.
characters = mat2cell(all_letters, 42,[24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24]);
    
save('characters', 'characters');