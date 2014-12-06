#!/usr/bin/python3
import pygame
import sys


x_s = int(sys.argv[2]) #arg 2 is how many x's
y_s = int(sys.argv[3]) #arg3 how many y's
width = int(sys.argv[4]) #arg4 width
height = int(sys.argv[5]) #arg5 height
pygame.init()
screen = pygame.display.set_mode((x_s*width, y_s*height)) 
sheet = pygame.image.load(sys.argv[1]).convert_alpha() # FIRST ARG filename of the image to split
mapfile = []

for x in range(x_s): # second argument the x val of how many sprites
    for y in range(y_s):
        img = sheet.subsurface((width*x,y*height,width,height))
        name = str(x+y*x_s) + '.bmp'
        pygame.image.save( img, name) 
        mapfile.append(str(x+y*x_s) + ' ' + name)

for m in sorted(mapfile):
    print(m)

pygame.quit()
