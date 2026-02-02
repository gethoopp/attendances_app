import 'package:json_annotation/json_annotation.dart';

part 'total_data_worker.g.dart';

@JsonSerializable()
class DataTotalWorker {
  final int status;
  final TotalWorker totalWorker;

  DataTotalWorker({required this.status, required this.totalWorker});

  DataTotalWorker copyWith({int? status, TotalWorker? totalWorker}) =>
      DataTotalWorker(
        status: status ?? this.status,
        totalWorker: totalWorker ?? this.totalWorker,
      );

  factory DataTotalWorker.fromJson(Map<String, dynamic> json) =>
      _$DataTotalWorkerFromJson(json);

  Map<String, dynamic> toJson() => _$DataTotalWorkerToJson(this);
}

@JsonSerializable()
class TotalWorker {
  final int totalDayWorking;

  TotalWorker({required this.totalDayWorking});

  TotalWorker copyWith({int? totalDayWorking}) =>
      TotalWorker(totalDayWorking: totalDayWorking ?? this.totalDayWorking);

  factory TotalWorker.fromJson(Map<String, dynamic> json) =>
      _$TotalWorkerFromJson(json);

  Map<String, dynamic> toJson() => _$TotalWorkerToJson(this);
}
