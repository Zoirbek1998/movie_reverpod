
import 'package:freezed_annotation/freezed_annotation.dart';

import 'Casts.dart';


part 'Cast.freezed.dart';
part 'Cast.g.dart';

@freezed
class Cast with _$Cast {
  factory Cast({
    required int id,
    required List<Casts> cast,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
