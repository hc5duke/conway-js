layout = (seedName, rows, cols) ->
  board = for num in [1..rows]
    false for num in [1..rows]

  seeds = []
  switch seedName
    when 'blinker'
      seeds = [
        [2, 1]
        [2, 2]
        [2, 3]
      ]
    when 'toad'
      seeds = [
        [2, 2]
        [2, 3]
        [2, 4]
        [3, 1]
        [3, 2]
        [3, 3]
      ]
    when 'beacon'
      seeds = [
        [1, 1]
        [1, 2]
        [2, 1]
        [3, 4]
        [4, 3]
        [4, 4]
      ]
    when 'pulsar'
      for num1 in [2,7,9,14]
        for num2 in [4,5,6,10,11,12]
          seeds.push([num1, num2], [num2, num1])

    # Spaceships
    when 'glider'
      seeds = [
        [1, 3]
        [2, 1]
        [2, 3]
        [3, 2]
        [3, 3]
      ]
    when 'lwss'
      seeds = [
        [1, 2]
        [1, 3]
        [1, 4]
        [1, 5]
        [2, 1]
        [2, 5]
        [3, 5]
        [4, 1]
        [4, 4]
      ]

    # Randomized
    when 'rand'
      seeds = []
      for row in [0...rows]
        for col in [0...cols]
          seeds.push([row, col]) if Math.random() > 0.7

  for rc in seeds
    [row, col] = rc
    board[row][col] = true

  return board


module.exports = layout
