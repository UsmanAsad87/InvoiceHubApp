import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return GoogleFonts.mukta(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}
TextStyle _getLibreBaskervilleTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
    ) {
  return GoogleFonts.libreBaskerville(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}

// regular style
TextStyle getRegularStyle({double fontSize = 16, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.regular, color);
}

// medium style
TextStyle getMediumStyle({double fontSize = 16, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.medium, color);
}

// medium style
TextStyle getLightStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.light, color);
}

// bold style
TextStyle getBoldStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.bold, color);
}

// semibold style
TextStyle getSemiBoldStyle({
  double fontSize = 14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize.sp,
    FontWeightManager.semiBold,
    color,
  );
}

// bold style
TextStyle getExtraBoldStyle({double fontSize = 14, required Color color}) {
  return _getLibreBaskervilleTextStyle(fontSize.sp, FontWeightManager.extraBold, color);
}


// regular style
TextStyle getLibreBaskervilleRegularStyle({double fontSize = 16, required Color color}) {
  return _getLibreBaskervilleTextStyle(fontSize.sp, FontWeightManager.regular, color);
}

// medium style
TextStyle getLibreBaskervilleMediumStyle({double fontSize = 16, required Color color}) {
  return _getLibreBaskervilleTextStyle(fontSize.sp, FontWeightManager.medium, color);
}

// medium style
TextStyle getLibreBaskervilleLightStyle({double fontSize = 14, required Color color}) {
  return _getLibreBaskervilleTextStyle(fontSize.sp, FontWeightManager.light, color);
}

// bold style
TextStyle getLibreBaskervilleBoldStyle({double fontSize = 14, required Color color}) {
  return _getLibreBaskervilleTextStyle(fontSize.sp, FontWeightManager.bold, color);
}

// semibold style
TextStyle getLibreBaskervilleSemiBoldStyle({
  double fontSize = 14,
  required Color color,
}) {
  return _getLibreBaskervilleTextStyle(
    fontSize.sp,
    FontWeightManager.semiBold,
    color,
  );
}

// bold style
TextStyle getLibreBaskervilleExtraBoldStyle({double fontSize = 14, required Color color}) {
  return _getLibreBaskervilleTextStyle(fontSize.sp, FontWeightManager.extraBold, color);
}