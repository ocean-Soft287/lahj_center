// import 'package:darelhekma/Feature/Auth/Register/screen/register_screen.dart';
// import 'package:darelhekma/Feature/Auth/Data/screen/login_screen.dart';
// import 'package:darelhekma/Feature/main/bottomNavbar/home_screen.dart';
// import 'package:go_router/go_router.dart';
//
// import '../Feature/intial/on_boarding_screen.dart';
// import '../Feature/main/ItemDetails/screen/item_details_screen.dart';
// import '../main.dart';
//
// final goRouter = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) =>  const StartApp(),
//
//     ),
//     GoRoute(
//       path: '/homecubit',
//       builder: (context, state) =>
//           HomeScreen(),
//
//     ),
//     GoRoute(
//       path: '/details/:itemId/:nameItem',
//       builder: (context, state) =>
//           ItemDetailsScreen(productId:state.pathParameters['itemId'], parentCategoryName: '${state.pathParameters['nameItem']}' ,),
//     ),
//     GoRoute(
//         path: '/Data',
//         builder: (context, state) =>
//             LoginScreen()
//     ),
//     GoRoute(
//         path: '/onBoarding',
//         builder: (context, state) =>
//             OnboardingScreen()
//     ),
//     GoRoute(
//         path: '/register',
//         builder: (context, state) =>
//             RegisterScreen()
//     )
//   ],
// );
//
//
// // final goRouter = GoRouter(
// //   routes: [
// //     GoRoute(
// //       path: '/',
// //       builder: (context, state) =>  const StartApp(),
// //       routes: [
// //         GoRoute(
// //           path: '/homecubit',
// //           builder: (context, state) =>
// //              HomeScreen(),
// //
// //         ),
// //         GoRoute(
// //           path: '/details/:itemId',
// //           builder: (context, state) =>
// //               ItemDetailsScreen(productId:state.pathParameters['itemId'], parentCategoryName: 'ff' ,),
// //         ),
// //         GoRoute(
// //           path: '/Data',
// //           builder: (context, state) =>
// //               LoginScreen()
// //         ),
// //         GoRoute(
// //           path: '/onBoarding',
// //           builder: (context, state) =>
// //               OnboardingScreen()
// //         ),
// //         GoRoute(
// //           path: '/register',
// //           builder: (context, state) =>
// //              RegisterScreen()
// //         )
// //       ],
// //     )
// //   ],
// // );
