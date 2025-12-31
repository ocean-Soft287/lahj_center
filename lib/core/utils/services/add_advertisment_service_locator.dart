import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/add_advertisement_bloc/add_advertisement_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/category_bloc/category_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/category_bloc/category_event.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/services_bloc/services_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_catagory_bloc/sub_catagory_cubit.dart';
import '../../../Feature/AddAdvertisement/blocs/currency_bloc/currency_event.dart';
import '../../../Feature/AddAdvertisement/blocs/government_bloc/government_event.dart';
import '../../../Feature/AddAdvertisement/blocs/services_bloc/services_event.dart';
import '../../../Feature/AddAdvertisement/data/repo/repo.dart';

class AddAdvertismentServiceLocator {
  static Future<void> execute({required GetIt getIt}) async {
    getIt.registerLazySingleton<CategoryBloc>(
      () => CategoryBloc(getIt<Addadvertisminterepo>())..add(GetCategories()),
    );
    getIt.registerLazySingleton<GovernmentBloc>(
      () =>
          GovernmentBloc(getIt<Addadvertisminterepo>())..add(GetGovernments()),
    );
    getIt.registerLazySingleton<ServicesBloc>(
      () => ServicesBloc(getIt<Addadvertisminterepo>())..add(GetServices()),
    );
    getIt.registerLazySingleton<CurrencyBloc>(
      () => CurrencyBloc(getIt<Addadvertisminterepo>())..add(GetCurrencies()),
    );
    getIt.registerFactory<AddAdvertisementBloc>(
      () => AddAdvertisementBloc(getIt<Addadvertisminterepo>()),
    );
  
    

  }
}
