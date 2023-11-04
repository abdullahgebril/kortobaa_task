import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'dart:ui' as ui;

import 'package:flutter_task/features/home/home_view_model.dart';

class BackDropFliterContainer extends StatelessWidget {
  const BackDropFliterContainer({super.key, required this.homeViewmodel});

  final HomeViewmodel homeViewmodel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: homeViewmodel.bannerCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
            height: context.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    homeViewmodel.dropFliterColor,
                    Colors.white30.withOpacity(0.8),
                    homeViewmodel.dropFliterColor,
                    homeViewmodel.dropFliterColor,
                  ]),
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 50,
                sigmaY: 50,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ));
      },
    );
  }
}
