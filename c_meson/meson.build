project('bowling_game', 'c',
  version : '0.1',
  default_options : ['warning_level=3'])

subdir('./lib/bowling_game')

src = files('./src/bowling_game_cli.c')
incdir = bowling_game_inc

exe = executable('bowling_game', src, include_directories : incdir, link_with : bowling_game_lib)
