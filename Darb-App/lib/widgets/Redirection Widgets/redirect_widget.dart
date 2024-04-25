import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedirectWidget extends StatelessWidget {
  const RedirectWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          authBloc.add(RedirectEvent());
          return Scaffold(
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if(state is RedirectedState){
                  context.push(state.page, false);
                }
              },
              builder: (context, state) {
                if(state is AuthLoadingState){
                  return Container(
                    width: context.getWidth(),
                    height: context.getHeight(),
                    color: offWhiteColor,
                    child: const Center(
                      child: CircularProgressIndicator(color: signatureYellowColor,),
                    ),
                  );
                }else {
                  return Container(
                    width: context.getWidth(),
                    height: context.getHeight(),
                    color: offWhiteColor,
                  );
                }
              },
            ),
          );
        }
      ),
    );
  }
}
