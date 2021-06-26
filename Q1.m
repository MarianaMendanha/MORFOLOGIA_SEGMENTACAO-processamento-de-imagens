img = im2double(imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\T2\imagens/morf_test.png'));

% C�lculo do limiar
limiar = graythresh(img);
% Binariza��o pelo limiar
imgBin = im2bw(img,limiar);

% REALCE DAS LETRAS
SE = strel('square',3);
imgEro = imerode(img,SE);

subplot(2,2,1);
imshow(imgEro);
imwrite(imgEro,'HL_morf.png');
title('Imagem Realcada', 'FontSize', 15);

% FECHAMENTO para obter fundo
SE = strel('octagon',3);
fundo = imclose(img, SE);
 %% imshow(fundo);
 %% title('Fechamento', 'FontSize', 15);

% Subtra��o do fundo da imagem
imgb = fundo-imgEro; 

subplot(2,2,2);
imshow(imgb);
imwrite(imgb,'BL_morf.png');
title('Subtracao do Fundo', 'FontSize', 15);

% C�lculo do limiar para nova imagem
limiar2 = graythresh(imgb);

% Binarizacao da imagem tratada
imgBW = imgb < limiar2;

% Retirada de ru�dos
##imgBW = bwareaopen(~imgBW,10);
##imgBW = ~imgBW;

subplot(2,2,4);
imshow(imgBW,[]);
imwrite(imgBW,'Bin_morf.png');
title('Nova Imagem Binarizada', 'FontSize', 15);

% Imagem Diretamente Binarizada
subplot(2,2,3);
imshow(imgBin);
imwrite(imgBin,'Bin_dir_morf.png');
title('Imagem Diretamente Binarizada', 'FontSize', 15); 
 
