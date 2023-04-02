part of 'themes.dart';

final secondaryTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.greyDark,
  splashColor: AppColors.greyLight30,
  highlightColor: AppColors.greyLight30,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.greyDark30,
    onPrimary: AppColors.greyLight,
    secondary: AppColors.greyDark,
    onSecondary: AppColors.white,
    error: AppColors.greyLight,
    onError: AppColors.alertCritical,
    background: AppColors.greyLight,
    onBackground: AppColors.greyDark30,
    surface: AppColors.greyDark,
    onSurface: AppColors.greyDark30,
  ),
  textTheme: TextTheme(
    displayMedium:
        TextStyles.medium(color: AppColors.black, fontSize: FontSizes.s24),
    headlineMedium:
        TextStyles.medium(color: AppColors.black, fontSize: FontSizes.s18),
    titleMedium:
        TextStyles.medium(color: AppColors.black, fontSize: FontSizes.s16),
    bodyMedium:
        TextStyles.regular(color: AppColors.black, fontSize: FontSizes.s14),
    labelMedium:
        TextStyles.regular(color: AppColors.black, fontSize: FontSizes.s12),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle:
        TextStyles.medium(color: AppColors.black, fontSize: FontSizes.s24),
    color: AppColors.white,
    centerTitle: true,
  ),
  navigationBarTheme: NavigationBarThemeData(
    elevation: AppSizes.elevationMain,
    backgroundColor: AppColors.greyLight,
    indicatorColor: AppColors.primaryLight,
    labelTextStyle: MaterialStateProperty.all(
      TextStyles.regular(color: AppColors.black, fontSize: FontSizes.s12),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: AppSizes.elevationMain,
    backgroundColor: AppColors.greyLight,
    selectedItemColor: AppColors.black,
    unselectedItemColor: AppColors.black,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.white,
      elevation: AppSizes.elevationMain,
      textStyle: TextStyles.medium(
        color: AppColors.black,
        fontSize: FontSizes.s14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSizes.circularRadius)),
        side: BorderSide(
          color: AppColors.black,
        ),
      ),
      minimumSize: const Size.fromHeight(AppSizes.filledButtonHeight),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyles.medium(
        color: AppColors.greyDark30,
        fontSize: FontSizes.s14,
      ),
    ),
  ),
  chipTheme: ChipThemeData(
    selectedColor: AppColors.greyDark,
    checkmarkColor: AppColors.greyDark30,
    labelStyle: TextStyles.regular(
      color: AppColors.greyDark30,
      fontSize: FontSizes.s12,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.circularRadius),
      ),
    ),
    side: BorderSide(
      color: AppColors.greyDark,
    ),
  ),
  dialogTheme: DialogTheme(
    alignment: Alignment.center,
    elevation: 2,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.circularRadius),
      ),
    ),
  ),
  tabBarTheme: TabBarTheme(
    indicatorColor: AppColors.greyDark30,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    expandedAlignment: Alignment.centerLeft,
    childrenPadding: EdgeInsets.all(AppSizes.smallSpacing),
  ),
);
