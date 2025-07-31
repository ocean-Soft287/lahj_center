part of 'myadd_cubit.dart';

sealed class MyaddState {}

final class MyaddInitial extends MyaddState {}
class Allmyadditemsuccfulload extends MyaddState{}
class AllmyadditemFailure extends MyaddState{}
class Allmyadditemsuccful extends MyaddState{
  final AdvertisementResponse advertisementResponse;

  Allmyadditemsuccful({required this.advertisementResponse});

}
class Allmyaddsitemsuccfulempty extends MyaddState{}


class DeletemyadditemFailure extends MyaddState{}
class Deletemyadditemsuccful extends MyaddState{

}
class Deletemyaddsitemsuccfulempty extends MyaddState{}