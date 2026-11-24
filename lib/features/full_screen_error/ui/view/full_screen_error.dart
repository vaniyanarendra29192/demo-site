import 'package:base_frame/imports/core_imports.dart';
import 'package:base_frame/imports/dart_package_imports.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/localization/base_localization.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/routes.dart';
import '../../../../core/utils/styles.dart';
import '../bloc/full_screen_error_bloc.dart';
import '../bloc/full_screen_error_contractor.dart';

class FullScreenError extends StatefulWidget {
  final String title;
  final String message;
  final String? buttonTitle;
  final Function onRetryTap;

  const FullScreenError(
      {required this.onRetryTap,
      this.message = '',
      this.title = '',
      this.buttonTitle,
      super.key});

  @override
  State<FullScreenError> createState() => _FullScreenErrorState();
}

class _FullScreenErrorState
    extends BaseState<FullScreenErrorBloc, FullScreenError> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FullScreenErrorBloc>.value(
      value: bloc,
      child: BlocBuilder<FullScreenErrorBloc, FullScreenErrorData>(
        builder: (_, state) =>  _NoInternetConnectionScreen(
                onRetryTap: () async {
                  if (await bloc.networkInfo.isConnected) {
                    widget.onRetryTap();
                  }
                },
              ),
      ),
    );
  }

  @override
  void onViewEvent(ViewAction event) async {
    switch (event.runtimeType) {
      case const (NavigateScreen):
        final screen = event as NavigateScreen;
        switch (screen.target) {
          case AppRoutes.networkRestored:
            widget.onRetryTap();
        }
    }
  }
}

class _NoInternetConnectionScreen extends StatelessWidget {
  final Function onRetryTap;
  const _NoInternetConnectionScreen({required this.onRetryTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spaceXMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          
          Gap(Dimens.spaceMedium),
          Text(
            AppLocalization.currentLocalization().connectionLostTitle,
            style: AppFontTextStyles.textStyleBold()
                .copyWith(fontSize: Dimens.fontSizeSixteen),
          ),
          Gap(Dimens.spaceSmall),
          Text(
            textAlign: TextAlign.center,
            AppLocalization.currentLocalization().noInternetSubtitle,
            style: AppFontTextStyles.textStyleMedium()
                .copyWith(fontSize: Dimens.fontSizeSixteen),
          ),
          Gap(Dimens.spaceSmall),
          _RetryButton(onRetryTap: onRetryTap)
        ],
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final Function onRetryTap;
  const _RetryButton({required this.onRetryTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRetryTap as void Function()?,
      child: Container(
        width: Dimens.container2xSmall,
        padding: const EdgeInsets.symmetric(vertical: Dimens.spaceSmall),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Dimens.radiusSmall),
          border: Border.all(color: AppColors.primaryBlue1, width: 1),
        ),
        child: Center(
          child: Text(
            AppLocalization.currentLocalization().retry,
            style: AppFontTextStyles.buttonTextStyle()
                .copyWith(color: AppColors.primaryBlue1),
          ),
        ),
      ),
    );
  }
}
