import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  // TODO: اضف وظيفة الضغط هنا
                },
                child: AdvertsiminteContainer(item: items[index]),
              );
            },
          );
        }

        // ✅ في حالة عدم تطابق أي شرط
        return const Center(child: CircularProgressIndicator());
      },
    );
  }}
