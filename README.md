[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Mfyqb_T6)
# NeXtCS Project 01
### thinker0: Franklin Li
---

### Overview
Your mission is create either:
- Life-like cellular automata [life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), [life-like](https://en.wikipedia.org/wiki/Life-like_cellular_automaton), [demo](https://www.netlogoweb.org/launch#https://www.netlogoweb.org/assets/modelslib/Sample%20Models/Computer%20Science/Cellular%20Automata/Life.nlogo).
- Breakout/Arkanoid [demo 0](https://elgoog.im/breakout/)  [demo 1](https://www.crazygames.com/game/atari-breakout)
- Space Invaders/Galaga

This project will be completed in phases.  
The first phase will be to work on this document. 
* Use markdown formatting.
* For more markdown help
  - [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or
  - [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)


---

## Phase 0: Selection, Analysis & Plan

#### Selected Project: Le Conway

### Necessary Features
What are the core features that your program should have? These should be things that __must__ be implemented in order to make the program useable/playable, not extra features that could be added to make the program more interesting/fun.

Cells, rules for cells to live/die, ability to make cells alive or dead

### Extra Features
What are some features that are not essential to the program, but you would like to see (provided you have time after completing the necessary features. Theses can be customizations that are not part of the core requirements.

more cell states, somewhat irregular cell neighbor shapes, more cell rules

### Array Usage
How will you be using arrays in this project?

1D Array:
 - Will be used to store a list of all cell neighbors to avoid having to search for them every time
2D Array:
 - Will store the entire grid of cells


### Controls
How will your program be controlled? List all keyboard commands and mouse interactions.

Keyboard Commands:
- use space to halt the simulation

Mouse Control:
- Mouse pressed: kill a living cell or reanimate a dead one


### Classes
What classes will you be creating for this project? Include the instance variables and methods that you believe you will need. You will be required to create at least 2 different classes. If you are going to use classes similar to those we've made for previous assignments, you will have to add new features to them.


Cell
- Instance variables:
  - currentState (current state)
  - nextState (next cell state)
  - center (actually the corner)
  - indices (index that shows this cell's position in grid)
  - size (cell size)
- METHODS
  - firstTick (determines neighbors)
  - Cell() (constructor)
  - determineNextState (checks neighbors current states)
  - Tick (sets current to next state)
  - display (displays)
