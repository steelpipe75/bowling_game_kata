project('bowling_game', 'c',
  version : '0.1',
  default_options : ['warning_level=3'])

src = [
    './src/bowling_game_cli.c',
    './lib/bowling_game/src/bowling_game.c',
]

incdir = include_directories('./lib/bowling_game/src/')

exe = executable('bowling_game', src, include_directories : incdir)
