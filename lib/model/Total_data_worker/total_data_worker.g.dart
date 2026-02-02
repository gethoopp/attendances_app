// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_data_worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataTotalWorker _$DataTotalWorkerFromJson(Map<String, dynamic> json) =>
    DataTotalWorker(
      status: (json['status'] as num).toInt(),
      totalWorker: TotalWorker.fromJson(
        json['totalWorker'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DataTotalWorkerToJson(DataTotalWorker instance) =>
    <String, dynamic>{
      'status': instance.status,
      'total_worker': instance.totalWorker,
    };

TotalWorker _$TotalWorkerFromJson(Map<String, dynamic> json) =>
    TotalWorker(totalDayWorking: (json['total_day_working'] as num).toInt());

Map<String, dynamic> _$TotalWorkerToJson(TotalWorker instance) =>
    <String, dynamic>{'total_day_working': instance.totalDayWorking};
