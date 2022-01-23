import cv2
import os
import math

orgImgPath = './images'
outImgPathE = './DataFaces/outEyes'
outImgPathNE = './DataFaces/outNoEyes'

os.mkdir(outImgPathE)
os.mkdir(outImgPathNE)
imgList = os.listdir(orgImgPath)


for img in imgList:
	
	x_i = 0
	x_f = 450
	y_i = 0
	y_f = 90
	
	for i in range(1,22):
		orImg = cv2.imread('./images/' + img)
		
		if i % 2 == 0:
			x_i = 450
			x_f = 900
			y_i += 90
			y_f += 90
		else:
			x_i = 0
			x_f = 450


		if i == 10:
			slc = orImg[440:530,287:737]
			cv2.imwrite(outImgPathE + '/Eyes' + img, slc)
		elif i == 11:
			pass
		else:
			slc = orImg[y_i:y_f,x_i:x_f]
			#print(i,y_i, y_f)
			cv2.imwrite(outImgPathNE + '/NoEyes' + str(i) + img, slc)
		

			