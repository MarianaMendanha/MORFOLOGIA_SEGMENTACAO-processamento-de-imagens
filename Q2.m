img = im2double(imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\T2\imagens/cookies.tif'));

% Cálculo do limiar
limiar = graythresh(img);
% Binarização pelo limiar
imgBin = im2bw(img,limiar);
%imshow(imgBin);

subplot(3,2,1);
imshow(img);
title('Imagem Original', 'FontSize', 15);

subplot(3,2,3);
imshow(imgBin);
imwrite(imgBin,'Bin_cookies.png');
title('Imagem Binarizada', 'FontSize', 15);

% Eliminando cookie mordido por erosão
  % Elemento estruturante em disco de raio 60
SE = strel('disk',60,0);
imgEro = imerode(imgBin,SE);

subplot(3,2,4);
imshow(imgEro);
imwrite(imgEro,'Ero_cookies.png');
title('Imagem Erosao', 'FontSize', 15);

% Devolvendo forma de cookie por dilatação
  % Elemento estruturante em disco de raio 60
SE = strel('disk',60,0);
imgDil = imdilate(imgEro,SE);

subplot(3,2,5);
imshow(imgDil);
imwrite(imgDil,'Dil_cookies.png');
title('Imagem Dilatacao', 'FontSize', 15);

% Cookie completo
fin = imgDil-img;

subplot(3,2,6);
imshow(fin);
imwrite(fin,'Fin_cookies.png');
title('Imagem Final', 'FontSize', 15);


% TESTES DE TAMANHO DO COOKIE
##aux = imgDil-imgBin;
##aux2 = imgBin-imgDil;
##aux3 = aux-aux2;
##imshow(aux3);
