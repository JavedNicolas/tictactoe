import 'package:tictactoe/features/game/data/dto/cell_dto.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';

final List<GameDto> savedGameWithAGameAlmostWon = <GameDto>[
  const GameDto(
    id: 'game-1',
    date: 1700000003000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'empty'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player1'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player1'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'player2'),
      CellDto(index: 8, state: 'player2'),
    ],
    status: 'player1',
  ),
];

final List<GameDto> savedGameWithAGameAlmostDrawn = <GameDto>[
  const GameDto(
    id: 'game-1',
    date: 1700000003000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'empty'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player2'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player1'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'player2'),
      CellDto(index: 8, state: 'player2'),
    ],
    status: 'player1',
  ),
];

final List<GameDto> savedGameWithOngoing = <GameDto>[
  const GameDto(
    id: 'game-1',
    date: 1700000003000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'player1'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player1'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player1'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'player2'),
      CellDto(index: 8, state: 'player2'),
    ],
    status: 'player1',
  ),
  GameDto(
    id: 'game-2',
    date: 1700000004000,
    cells: List.generate(9, (index) => CellDto(index: index, state: 'empty')),
    status: 'ongoing',
  ),
];

final List<GameDto> saveGameOnlyCompleted = <GameDto>[
  const GameDto(
    id: 'game-1',
    date: 1700000005000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'player1'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player2'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player1'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'player2'),
      CellDto(index: 8, state: 'player2'),
    ],
    status: 'draw',
  ),
  const GameDto(
    id: 'game-2',
    date: 1700000006000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'player1'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player2'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player2'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'empty'),
      CellDto(index: 8, state: 'empty'),
    ],
    status: 'player2',
  ),
];

final List<GameDto> threeSavedGame = [
  const GameDto(
    id: 'game-1',
    date: 1700000005000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'player1'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player2'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player1'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'player2'),
      CellDto(index: 8, state: 'player2'),
    ],
    status: 'draw',
  ),
  const GameDto(
    id: 'game-2',
    date: 1700000006000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'player1'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player2'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player2'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'empty'),
      CellDto(index: 8, state: 'empty'),
    ],
    status: 'player2',
  ),
  const GameDto(
    id: 'game-3',
    date: 1700000005000,
    cells: <CellDto>[
      CellDto(index: 0, state: 'player1'),
      CellDto(index: 1, state: 'player1'),
      CellDto(index: 2, state: 'player2'),
      CellDto(index: 3, state: 'player2'),
      CellDto(index: 4, state: 'player2'),
      CellDto(index: 5, state: 'player1'),
      CellDto(index: 6, state: 'player1'),
      CellDto(index: 7, state: 'player2'),
      CellDto(index: 8, state: 'player2'),
    ],
    status: 'draw',
  ),
];
