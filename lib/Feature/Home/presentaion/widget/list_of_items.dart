import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Data/model/item_model.dart';
import '../../manager/categorycubit/category_cubit.dart';
import 'advertsiminte_container.dart';


class Listofitems extends StatelessWidget {
  const Listofitems({super.key, required this.x});
  final int x;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is Groupload || state is Allitemload) {
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

        if (state is Groupsuccful || state is Allitemsuccful) {
          final List<Item> items = (state is Groupsuccful)
              ? state.item.items
              : (state as Allitemsuccful).item.items;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

                },
                child: AdvertsiminteContainer(item: items[index]),
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
