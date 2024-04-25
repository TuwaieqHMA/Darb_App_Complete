import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/Auth%20Pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.backgroundColor, this.textColor});

  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Container(
      width: context.getWidth(),
      height: context.getWidth() * 0.91,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: backgroundColor ?? offWhiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              height24,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.push(const ProfilePage(), true);
                    }, 
                    child: SvgPicture.asset(
                      "assets/icons/icon_person.svg",
                      width: context.getWidth() * 0.07,
                    ),
                  ),
                  width16,
                  SizedBox(
                    width: context.getWidth() * .55,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Text(
                          "مرحباً ${locator.currentUser.name.split(' ')[0]}", 
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: textColor ?? skyblueColor,
                              fontSize: context.getWidth() * .07,
                              fontFamily: inukFont),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.getWidth() * 0.23,
                height: context.getWidth() * 0.23,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Image.asset(
                  "assets/images/app_logo.png",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
