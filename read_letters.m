function letter=read_letters(img_resized,count_letters)
% Computes the correlation between the characters and the input image
% containing a letter.

%Size of img_resized image must be 42x24 pixels.

global characters
comp = [];

for x = 1:count_letters
    % Computation of correlation. Each 42x24 pixel array in characters
    % array is compared with the input image and a correlation coefficient
    % is calculated.
    cor=corr2(characters{1,x},img_resized);
%     sem

    % Store the correlation coefficients in an array.
    comp = [comp cor];
%     comp
end
   
% The max of the correlation coefficient indicates the closest a character
% from the characters array is to the letter in the input image.
vd = find(comp==max(comp));
% vd
if vd==1
    letter='A';
elseif vd==2
    letter='B';
elseif vd==3
    letter='C';
elseif vd==4
    letter='D';
elseif vd==5
    letter='E';
elseif vd==6
    letter='F';
elseif vd==7
    letter='G';
elseif vd==8
    letter='H';
elseif vd==9
    letter='I';
elseif vd==10
    letter='J';
elseif vd==11
    letter='K';
elseif vd==12
    letter='L';
elseif vd==13
    letter='M';
elseif vd==14
    letter='N';
elseif vd==15
    letter='O';
elseif vd==16
    letter='P';
elseif vd==17
    letter='Q';
elseif vd==18
    letter='R';
elseif vd==19
    letter='S';
elseif vd==20
    letter='T';
elseif vd==21
    letter='U';
elseif vd==22
    letter='V';
elseif vd==23
    letter='W';
elseif vd==24
    letter='X';
elseif vd==25
    letter='Y';
elseif vd==26
    letter='Z';
else 
    letter='~';
end