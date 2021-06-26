img = im2double(imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\T2\imagens/img_cells.jpg'));
[linha, coluna, formato] = size(img)

% Mostra Imagem original 
subplot(3,3,1);
imshow(img);
title('Imagem Original');

% C�lculo do limiar
limiar = graythresh(img);

% Binariza��o pelo limiar
imgBin = im2bw(img,limiar);

subplot(3,3,4);
imshow(imgBin);
imwrite(imgBin,'Bin_cells.png');
title('Imagem Binarizada');

% Preenchimento das c�lulas
  % INSERINDO BORDAS DE TRATAMENTO NA IMAGEM
for i=1:1:linha
    imgBin(1,i)=0;
end
for i=1:1:linha
    imgBin(linha,i)=0;
end
for i=1:1:linha
    imgBin(i,linha)=0;
end

aux = ~imgBin;
imgfill = imfill(aux,'holes');
imgfill = ~imgfill;
%% figure,imshow(imgfill);

  % ARRUMANDO BORDAS DA IMAGEM
for i=1:1:linha
    if imgfill(2,i) == 0
      imgfill(1,i)=0;
    else
      imgfill(1,i)=1;
    end  
end
for i=1:1:linha
    if imgfill(linha-1,i) == 0
      imgfill(linha,i)=0;
    else
      imgfill(linha,i)=1;
    end  
end
for i=1:1:linha
    if imgfill(i,linha-1) == 0
      imgfill(i,linha)=0;
    else
      imgfill(i,linha)=1;
    end  
end

subplot(3,3,5);
imshow(imgfill);
imwrite(imgfill,'Bin_fill_cells.png');
title('Binaria Preenchida');

% Preenchimento dos espa�os (bwareaopen())
imgfill = bwareaopen(~imgfill,10);
imgfill = ~imgfill;

subplot(3,3,6);
imshow(imgfill);
imwrite(imgfill,'Bin_fin_cells.png');
title('Binaria Final');

###########################################################
% SECTION N�o sei como melhorar a segmenta��o
##SE = strel('disk',2,0);
##imgfill = imerode(~imgfill,SE);
##imgfill = ~imgfill;
##
##SE = strel('disk',2,0);
##imgfill = imopen(~imgfill, SE);
##imgfill = ~imgfill;
##
##figure,imshow(imgfill);
##title('Imagem Erosao', 'FontSize', 15);
###########################################################

% Calcular bwdist(), Computar segmenta��o watershed() 
  % Calculo Euclidiano bwdist
Dimg = bwdist(imgfill);
  
  % Aplica��o da segmentacao por watershed
Dimg = -Dimg;
L = watershed(Dimg);
subplot(3,3,7);
imshow(L);
imwrite(L,'Segm_cells.png');
title('Segmenta��o');
  
  % Segmentos aplicados � imagem binaria tratada
L(~Dimg) = 0;
subplot(3,3,8);
imshow(L);
imwrite(L,'Segm_apl_cells.png');
title('Segmenta��o aplicada');

  
  % Aplicando cor para melhor visualiza��o
rgb = label2rgb(L,'jet',[.5 .5 .5]);
subplot(3,3,9);
imshow(rgb);
imwrite(rgb,'WatSh_cells.png');
title('Transformada Watershed');


