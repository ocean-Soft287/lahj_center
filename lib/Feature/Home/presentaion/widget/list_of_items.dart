import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../MyFavoriteAds/manger/post_like_cubit.dart';
import '../../Data/model/advertismint_response.dart';
import '../../manager/categorycubit/category_cubit.dart';
import 'advertsiminte_container.dart';


class Listofitems extends StatelessWidget {
  const Listofitems({super.key, required this.x});
  final int x;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, BaseState<AdvertisementResponse>>(
      builder: (context, state) {
        if (state.isLoading) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Skeletonizer(
                child: Card(
                  child: ListTile(
                    title: Skeleton.leaf(child: Text("")),
                    subtitle: Skeleton.leaf(child: Text("")),
                    leading: Skeleton.leaf(
                      child: CircleAvatar(radius: 24),
                    ),
                  ),
                ),
              );
            },
          );
        }

        if (state.isSuccess) {
          print("-------------------------- Allitemsuccful ${state.data?.items.length}");
          return ListView.builder(
            itemCount: state.data!.items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  
                    
                },
                child:         BlocProvider(create: (context) => GetIt.instance<PostLikeCubit>(),

                  child: AdvertsiminteContainer(item: state.data!.items[index])),
              );
            },
          );
        }

        return  Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            SizedBox(height: 50
              ,),Text(" لاتوجد بيانات",style: TextStyle(color: AppColors.mainAppColor,
            fontFamily: Fonts.font,
            fontWeight: FontWeight.w500,
            fontSize: 25),)
          ],),
        );
      },
    );
  }}
