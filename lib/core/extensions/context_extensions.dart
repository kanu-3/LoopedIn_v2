import 'package:flutter/cupertino.dart';

//scaledValue = (currentWidth / figmaWidth) * figmaValue

const double figmaWidth = 440.0;
const double figmaHeight = 956.0;

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  double scale(num value) => scaleW(value);
  double scaleW(num value) => (value * screenWidth) / figmaWidth;
  double scaleH(num value) => (value * screenHeight) / figmaHeight;

  double get spacingXXS => scale(8);
  double get spacingXS  => scale(12);
  double get spacingS   => scale(16);
  double get spacingM   => scale(20);
  double get spacingL   => scale(24);
  double get spacingLL  => scale(28);
  double get spacingXL  => scale(40);
  double get spacingXXL => scale(80);
  double get spacingV   => scale(46);
  double get nav        => scale(96);

  double get buttonHeight      => scale(52);
  double get inputFieldHeight  => scale(52);
  double get boxSize           => scale(60);

  double get logoWidth         => scale(235);
  double get cardHeightLarge   => scale(216);
  double get cardHeightMedium  => scale(173);
  double get cardHeightSmall   => scale(146);
  double get cardHeightXSmall  => scale(86);

  double get bottomSheetHeight => scale(373);

  EdgeInsets get padAllXS => EdgeInsets.all(spacingXS);
  EdgeInsets get padAllS  => EdgeInsets.all(spacingS);
  EdgeInsets get padAllM  => EdgeInsets.all(spacingM);
  EdgeInsets get padAllL  => EdgeInsets.all(spacingL);
  EdgeInsets get padAllV  => EdgeInsets.all(46);

  EdgeInsets get marginAllS => EdgeInsets.all(spacingS);
  EdgeInsets get marginAllM => EdgeInsets.all(spacingM);
  EdgeInsets get marginAllL => EdgeInsets.all(spacingL);

  EdgeInsets get bodypad => EdgeInsets.only(
    top: spacingM,
    left: spacingS,
    right: spacingS,
    bottom: spacingM,
  );

  Widget get gapXXS => SizedBox(height: spacingXXS);
  Widget get gapXS  => SizedBox(height: spacingXS);
  Widget get gapS   => SizedBox(height: spacingS);
  Widget get gapM   => SizedBox(height: spacingM);
  Widget get gapL   => SizedBox(height: spacingL);

  Widget get gapWXXS => SizedBox(width: spacingXXS);
  Widget get gapWS   => SizedBox(width: spacingS);
  Widget get gapWM   => SizedBox(width: spacingM);

  BorderRadius get borderRadiusS => BorderRadius.circular(scale(12));
  BorderRadius get borderRadiusM => BorderRadius.circular(scale(16));

  double scaledFont(double size) => scale(size);
}