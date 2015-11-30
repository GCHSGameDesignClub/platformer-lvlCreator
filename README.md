# platformer-lvlCreator
A utility to create .lvl files for the WIP platformer.


The format of the .lvl file consists of several ordered
sections seperated by the | character.  The sections are
in the following order:

1. The header

This only consists of the characters lvl and just confirms
that the file being read is a correctly formatted .lvl file.

2. Map Width

3. Map Height

4. Tileset

A number specifying the tileset to be used.  All tilesets must
be a grid of 256 tiles in a 16x16 layout.  Each tile should be
128x128, making each tileset 2048x2048 pixels.

5. Tiles

This section is a list of each tile's index in the spritesheet.
This list is written top down, left right.  There are 
MapWidth\*MapHeight tiles total.

6. Metadata

This section contains metadata detailing enemy types, spawn
locations, cutscene triggers, player spawn point, etc.  The
actual format of which is in the form m1 x1 y1, m2 x2 y2, and
so on where m is the data's type (eg playerspawn), and x and
y are its coordinates.

