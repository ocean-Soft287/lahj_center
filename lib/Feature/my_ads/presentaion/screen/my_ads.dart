import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/core/constans/app_colors.dart' show AppColors;
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/constans/responsve_font.dart' show getFontSize;

import '../../mange/myadd_cubit.dart';
import '../widget/delete_ad_dialog.dart';
import '../widget/myadscontainer.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyaddCubit>.value(
      value: GetIt.instance<MyaddCubit>()..getmyadd(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "إعلاناتي",
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: getFontSize(context, 15),
            ),
          ),
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            BlocBuilder<MyaddCubit, MyaddState>(
              builder: (context, state) {
                if (state is Allmyadditemsuccful ||
                    state is Deletemyadditemsuccful) {
                  final advertisementResponse = state is Allmyadditemsuccful
                      ? state.advertisementResponse
                      : (state as Deletemyadditemsuccful).advertisementResponse;

                  if (advertisementResponse.items.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 150),
                          child: Column(
                            children: [
                              Icon(
                                Icons.campaign_outlined,
                                size: 100,
                                color: Colors.green,
                              ),

                              Text(
                                "لا توجد إعلانات حالياً",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.font,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Myadscontainer(
                              item: advertisementResponse.items[index],
                              function: () {
                                final cubit = context.read<MyaddCubit>();
                                showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                    value: cubit,
                                    child: DeleteAdDialog(
                                      id: advertisementResponse.items[index].id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }, childCount: advertisementResponse.items.length),
                  );
                } else if (state is Allmyaddsitemsuccfulempty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("لا توجد إعلانات حالياً"),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Center(child: CircularProgressIndicator())),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
