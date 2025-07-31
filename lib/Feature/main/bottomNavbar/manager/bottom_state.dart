abstract class Bottomstate{}
class InitializeHome extends Bottomstate{}
class ChangeIndexBottom extends Bottomstate{}

class ChangeCategoryIndex extends Bottomstate{}




class GetBannerImageLoading extends Bottomstate{}
class GetBannerImageSuccess extends Bottomstate{}
class GetBannerImageError extends Bottomstate{}



class GetBestSellerLoading extends Bottomstate {}
class GetBestSellerSuccess extends Bottomstate {}
class GetBestSellerError extends Bottomstate {}


class GetNewProductLoading extends Bottomstate {}
class GetNewProductSuccess extends Bottomstate {}
class GetNewProductError extends Bottomstate {}

class HomeUpdatedState extends Bottomstate {
  final Map<String, dynamic> itemSalah;

  HomeUpdatedState(this.itemSalah);
}



class GetOfferProductLoading extends Bottomstate {}
class GetOfferProductSuccess extends Bottomstate {}
class GetOfferProductError extends Bottomstate {}

class GetOfferTwoProductLoading extends Bottomstate {}
class GetOfferTwoProductSuccess extends Bottomstate {}
class GetOfferTwoProductError extends Bottomstate {}




