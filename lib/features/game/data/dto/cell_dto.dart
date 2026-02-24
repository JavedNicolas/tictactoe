import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entity/cell.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';

part 'cell_dto.freezed.dart';
part 'cell_dto.g.dart';

@freezed
abstract class CellDto with _$CellDto {
  const CellDto._();

  const factory CellDto({required int index, required String state}) = _CellDto;

  factory CellDto.fromJson(Map<String, dynamic> json) => _$CellDtoFromJson(json);

  factory CellDto.fromCell(Cell cell) {
    return CellDto(index: cell.index, state: cell.state.name);
  }

  Cell toCell() {
    return Cell(index: index, state: CellState.fromString(state));
  }
}
