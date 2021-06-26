img = im2double(imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\T2\imagens/img_cells.jpg'));
[linha, coluna, formato] = size(img)

% Mostra Imagem original 
subplot(3,3,1);
imshow(img);
title('Imagem Original');

% Cálculo do limiar
limiar = graythresh(img);

% Binarização pelo limiar
imgBin = im2bw(img,limiar);

subplot(3,3,4);
imshow(imgBin);
imwrite(imgBin,'Bin_cells.png');
title('Imagem Binarizada');

% Preenchimento das células
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

% Preenchimento dos espaços (bwareaopen())
imgfill = bwareaopen(~imgfill,10);
imgfill = ~imgfill;

subplot(3,3,6);
imshow(imgfill);
imwrite(imgfill,'Bin_fin_cells.png');
title('Binaria Final');

###########################################################
% SECTION Não sei como melhorar a segmentação
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

% Calcular bwdist(), Computar segmentação watershed() 
  % Calculo Euclidiano bwdist
Dimg = bwdist(imgfill);
  
  % Aplicação da segmentacao por watershed
Dimg = -Dimg;
L = watershed(Dimg);
subplot(3,3,7);
imshow(L);
imwrite(L,'Segm_cells.png');
title('Segmentação');
  
  % Segmentos aplicados à imagem binaria tratada
L(~Dimg) = 0;
subplot(3,3,8);
imshow(L);
imwrite(L,'Segm_apl_cells.png');
title('Segmentação aplicada');

  
  % Aplicando cor para melhor visualização
rgb = label2rgb(L,'jet',[.5 .5 .5]);
subplot(3,3,9);
imshow(rgb);
imwrite(rgb,'WatSh_cells.png');
title('Transformada Watershed');


