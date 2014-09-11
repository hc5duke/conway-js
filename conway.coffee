#!/usr/bin/env coffee

layout = require('./lib/layout')

ROWS = 20
COLS = 20
SEED = 'rand'

board = null
nextBoard = null

init = ->
  setup()
  play()

setup = ->
  board = layout(SEED, ROWS, COLS)
  nextBoard = layout('blank', ROWS, COLS)

play = ->
  setInterval (->
    step()
  ), 100

step = ->
  for line, row in board
    for _, col in line
      calculate(row, col)
  # Next board is now board
  board = nextBoard
  # Clear next board
  nextBoard = layout('blank', ROWS, COLS)
  printBoard()

printBoard = ->
  console.log "\x1B" + "[#{ROWS + 3}A"
  borderHoriz = ("═" for _ in [0..COLS]).join("═")
  console.log "╔" + borderHoriz + "╗"
  for line in board
    _line = for square in line
      if square then "█" else " "
    console.log "║ " + _line.join(" ") + " ║"
  console.log "╚" + borderHoriz + "╝"

calculate = (row, col) ->
  count = liveNeighbors(row, col)
  #Any live cell with fewer than two live neighbors dies, as if caused by under-population.
  #Any live cell with two or three live neighbors lives on to the next generation.
  #Any live cell with more than three live neighbors dies, as if by overcrowding.
  #Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
  nextBoard[row][col] =
    if board[row][col]
      1 < count < 4
    else
      3 == count

liveNeighbors = (row, col) ->
  count = 0
  for ro in [row-1..row+1]
    for co in [col-1..col+1]
      continue if (ro == row && co == col) || # center
        ro < 0                         || # left edge
        ro > ROWS - 1                  || # right edge
        co < 0                         || # top edge
        co > COLS - 1                     # bottom edge
      count += 1 if board[ro][co]
  count

init()
