import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/manger/register_view_cubit/register_view_cubit.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_all_comment_repo.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_all_comment_repo_impl.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_report_repo.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_report_repo_impl.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/home_repo.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/home_repo_imp.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/post_repo_impl_comment.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/repo_post_comment.dart';
import 'package:lahijcenter/Feature/Home/manager/commentcubit/get_all_comment_cubit.dart';
import 'package:lahijcenter/Feature/Home/manager/commentcubit/get_report_cubit.dart';
import 'package:lahijcenter/Feature/Home/manager/commentcubit/post_comment_cubit.dart';
import 'package:lahijcenter/Feature/Home/manager/homecubit/item_details_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/fav_repo.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/fav_repo_imp.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/favourite_cubit.dart';
import 'package:lahijcenter/Feature/Search/data/repo/search_repo.dart';
import 'package:lahijcenter/Feature/profile/data/repo/get_profile_repo.dart';
import 'package:lahijcenter/Feature/profile/data/repo/get_profile_repo_impl.dart';
import 'package:lahijcenter/Feature/profile/data/repo/new_password_repo.dart';
import 'package:lahijcenter/Feature/profile/data/repo/new_password_repo_impl.dart';
import 'package:lahijcenter/Feature/profile/manager/new_password_cubit.dart';
import 'package:lahijcenter/Feature/profile/manager/profile_cubit.dart';
import 'package:lahijcenter/Feature/profile/manager/update_profile_cubit.dart';
import 'package:lahijcenter/core/connectivity/cubit/connectivity_cubit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../Feature/AddAdvertisement/data/repo/repo.dart';
import '../../../Feature/AddAdvertisement/data/repo/repoimp.dart';
import '../../../Feature/AddAdvertisement/manger/addadvertisminte_cubit.dart';
import '../../../Feature/Auth/Data/repo/repo.dart';
import '../../../Feature/Auth/Data/repo/repoimp.dart';
import '../../../Feature/Auth/manger/login-cubit/login_view_cubit.dart';
import '../../../Feature/Home/manager/categorycubit/category_cubit.dart';
import '../../../Feature/Home/manager/commentcubit/comment_cubit.dart';
import '../../../Feature/Home/manager/homecubit/home_cubit.dart';
import '../../../Feature/Search/data/repo/search_repo_imp.dart';
import '../../../Feature/Search/manager/search_cubit.dart';
import '../../../Feature/my_ads/data/my_ad_repo/myad_imp.dart';
import '../../../Feature/my_ads/data/my_ad_repo/myad_repo.dart';
import '../../../Feature/my_ads/mange/myadd_cubit.dart';
import '../../../Feature/profile/data/repo/profile_repo.dart';
import '../../../Feature/profile/data/repo/profile_repo_imp.dart';
import '../../../Feature/profile/data/repo/update_profile_repo.dart';
import '../../../Feature/profile/data/repo/update_profile_repo_impl.dart';
import '../../../Feature/profile/manager/get_profile_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../api/endpoint.dart';
import 'add_advertisment_service_locator.dart';

final sl = GetIt.instance;
Future<void> setup() async {
  // Dio instance registration
  sl.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(baseUrl: EndPoint.baseUrl))
        ..interceptors.add(PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          enabled: kDebugMode,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,

        )));

  /// Register DioConsumer
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: sl<Dio>()));
  sl.registerLazySingleton<ApiConsumer>(() => sl<DioConsumer>());

  /// Registering login
  sl.registerLazySingleton<Loginrepo>(() => Loginrepoimp(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<LoginViewCubit>(() => LoginViewCubit(sl<Loginrepo>()));
  sl.registerFactory<RegisterViewCubit>(() => RegisterViewCubit(sl<Loginrepo>()));


  /// Registering home data
  sl.registerLazySingleton<Homerepo>(
      () => Homerepoimp(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<Homerepo>()));
  sl.registerFactory<CategoryCubit>(() => CategoryCubit(sl<Homerepo>()));
  sl.registerFactory<ItemDetailsCubit>(() => ItemDetailsCubit(sl<Homerepo>()));
  sl.registerFactory<CommentCubit>(() => CommentCubit(sl<Homerepo>()));

  ///add comment
  ///CommentCubit
  /// Add Advertisement
  sl.registerLazySingleton<Addadvertisminterepo>(
    () => Addadvertisminterepoimp(
      dioConsumer: sl<DioConsumer>(),
    ),
  );
  sl.registerFactory<AddadvertisminteCubit>(
      () => AddadvertisminteCubit(sl<Addadvertisminterepo>(), sl<Homerepo>()));

  ///favourite
  sl.registerLazySingleton<Favrepo>(
    () => FavRepoImp(
      dioConsumer: sl<DioConsumer>(),
    ),
  );
  sl.registerFactory<FavouriteCubit>(() => FavouriteCubit(sl<Favrepo>()));

  ///myadds
  sl.registerLazySingleton<Myaddrepo>(
    () => Myaddimp(
      dioConsumer: sl<DioConsumer>(),
    ),
  );
  sl.registerFactory<MyaddCubit>(() => MyaddCubit(sl<Myaddrepo>()));

  ///profile
  sl.registerLazySingleton<Profilerepo>(
    () => Profilerepoimp(
      dioConsumer: sl<DioConsumer>(),
    ),
  );

  sl.registerFactory<ProfileViewCubit>(
      () => ProfileViewCubit(sl<Profilerepo>()));

  ///search


  sl.registerLazySingleton<Searchrepo>(
        () => SearchrepoRepoImp(
      dioConsumer: sl<DioConsumer>(),
    ),
  );

  sl.registerFactory<SearchCubit>(
          () => SearchCubit(sl<Searchrepo>()));

  // Get profile repo and cubit
  sl.registerLazySingleton<GetProfileRepo>(
        () => GetProfileRepoImpl(dioConsumer: sl<DioConsumer>()),
  );

  sl.registerFactory<GetProfileCubit>(
        () => GetProfileCubit(sl<GetProfileRepo>()),
  );
  //update profile
  sl.registerLazySingleton<UpdateProfileRepo>(()=> UpadateProfileRepoImpl(dioConsumer: sl<DioConsumer>()));
sl.registerFactory<UpdateProfileCubit>((

)=>UpdateProfileCubit(sl<UpdateProfileRepo>()));
// new password
sl.registerLazySingleton<NewPasswordRepo>(()=>NewPasswordRepoImpl(dioConsumer: sl<DioConsumer>()));
sl.registerFactory<NewPasswordCubit>(()=>NewPasswordCubit(sl<NewPasswordRepo>()));

  await AddAdvertismentServiceLocator.execute(getIt: sl);
  sl.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
  //post comment
  sl.registerLazySingleton<RepoPostComment>(() => PostRepoImplComment(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<PostCommentCubit>(() => PostCommentCubit(sl<RepoPostComment>()));
//get all comment
  sl.registerLazySingleton<GetAllCommentRepo>(() => GetAllCommentRepoImpl(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<GetAllCommentCubit>(() => GetAllCommentCubit(sl<GetAllCommentRepo>()));
  
  //report comment
  sl.registerLazySingleton<GetReportRepo>(() => GetReportRepoImpl(dioConsumer: sl<DioConsumer>()));
  sl.registerFactory<GetReportCubit>(() => GetReportCubit(sl<GetReportRepo>()));
  





}
