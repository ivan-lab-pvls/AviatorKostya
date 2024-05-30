import 'package:jorney_map/data/model/plan_model.dart';
import 'package:jorney_map/data/model/transfer_model.dart';

import 'arrival_info_model.dart';
import 'departure_info_model.dart';

class TravelModel {
  DepartureInfoModel departureInfo;
  ArrivalInfoModel arrivalInfo;
  List<TransferModel> transfers;
  List<PlanModel>? plans;

  TravelModel({
    required this.departureInfo,
    required this.arrivalInfo,
    this.transfers = const [],
    this.plans,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      departureInfo: DepartureInfoModel.fromJson(json['departureInfo']),
      arrivalInfo: ArrivalInfoModel.fromJson(json['arrivalInfo']),
      transfers: List<TransferModel>.from(
        (json['transfers'] as List)
            .map((transfer) => TransferModel.fromJson(transfer)),
      ),
      plans: json['plans'] != null
          ? List<PlanModel>.from(
              (json['plans'] as List).map((plan) => PlanModel.fromJson(plan)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departureInfo': departureInfo.toJson(),
      'arrivalInfo': arrivalInfo.toJson(),
      'transfers': transfers.map((transfer) => transfer.toJson()).toList(),
      'plans': plans?.map((plan) => plan.toJson()).toList(),
    };
  }
}
