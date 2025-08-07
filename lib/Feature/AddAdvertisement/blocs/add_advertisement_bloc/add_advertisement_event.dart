import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AddAdvertisementEvent extends Equatable {
  const AddAdvertisementEvent();
  
  @override
  List<Object?> get props => [];
}

class SubmitAdvertisement extends AddAdvertisementEvent {
  final String name;
  final String phone;
  final int groupId;
  final int serviceId;
  final double price;
  final bool isCloseReplies;
  final int currencyId;
  final int governorateId;
  final String area;
  final String description;
  final List<File> images;

  const SubmitAdvertisement({
    required this.name,
    required this.phone,
    required this.groupId,
    required this.serviceId,
    required this.price,
    required this.isCloseReplies,
    required this.currencyId,
    required this.governorateId,
    required this.area,
    required this.description,
    required this.images,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    groupId,
    serviceId,
    price,
    isCloseReplies,
    currencyId,
    governorateId,
    area,
    description,
    images,
  ];
}
