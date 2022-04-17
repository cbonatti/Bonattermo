# BonaTTermo

A word game made in Flutter. It is based in [this game](https://term.ooo/) and uses almost the same [word database](https://github.com/fserb/pt-br). 

## Getting Started

It is composed by 2 projects: a helper and an app.

### BonaTTermoHelper
Is a C# console which hits an endpoint to get words, then applys a rule to get the best words and generate a text file. This generated text file will be used by the flutter project **BonaTTermo** app.
- The endpoint return a list of words like this *abate,188868,1,0.9881,0.0019,abcdfhijklmoqrst*
- Only words with length 5 are selected
- After that, the number between the first and second comma is converted to int
- And a weigth is applyed to this (filtering only with rate 100.000 or more)

### BonaTTermo
Is a Flutter app which loads words from a text file, selects a random one and let the user play with it trying to figure out what is the correct word and receiving tips for each word tryed.
