clear all

allImages = imread('00963v.jpg');

BlueIm = allImages(20:319,30:371);
GreenIm = allImages(350:649,30:371);
RedIm = allImages(690:989,30:371);

