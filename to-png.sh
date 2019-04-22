#!/bin/bash
if [ ! -d "./png" ] 
then
  mkdir png
fi
lilypond --png -dresolution=600 tchaikovsky-romeo-and-juliet.ly
rm *.midi
mv *.png ./png
