part of 'themes.dart';

final primaryTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.greyLight,
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
    displayMedium: TextStyles.medium(
      color: AppColors.black,
      fontSize: FontSizes.s24,
    ),
    headlineMedium: TextStyles.medium(
      color: AppColors.black,
      fontSize: FontSizes.s18,
    ),
    titleMedium: TextStyles.medium(
      color: AppColors.black,
      fontSize: FontSizes.s16,
    ),
    bodyMedium: TextStyles.regular(
      color: AppColors.black,
      fontSize: FontSizes.s14,
    ),
    labelMedium: TextStyles.regular(
      color: AppColors.black,
      fontSize: FontSizes.s12,
    ),
  ),
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0.0,
    titleTextStyle:
        TextStyles.bold(color: AppColors.black, fontSize: FontSizes.s24),
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
  navigationRailTheme: NavigationRailThemeData(
    elevation: AppSizes.elevationMain,
    minWidth: AppSizes.navigationRailWidth,
    minExtendedWidth: AppSizes.navigationRailWidth,
    useIndicator: false,
    backgroundColor: AppColors.white,
    unselectedLabelTextStyle:
        TextStyles.regular(color: AppColors.black, fontSize: FontSizes.s12),
    selectedLabelTextStyle:
        TextStyles.bold(color: AppColors.black, fontSize: FontSizes.s12),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      disabledBackgroundColor: AppColors.white,
      disabledForegroundColor: AppColors.greyDark,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.white,
      elevation: AppSizes.elevationMain,
      textStyle: TextStyles.bold(
        color: AppColors.black,
        fontSize: FontSizes.s14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: appBorderRadius,
        side: BorderSide(color: AppColors.greyDark),
      ),
      minimumSize: const Size.fromHeight(AppSizes.filledButtonHeight),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(4),
      textStyle: TextStyles.bold(
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
    shape: appShape,
    side: BorderSide(color: AppColors.greyDark),
  ),
  dialogTheme: DialogTheme(
    alignment: Alignment.center,
    elevation: 2,
    backgroundColor: AppColors.white,
    shape: appShape,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.greyLight30,
  ),
  cardTheme: cardTheme,
  inputDecorationTheme: inputDecorationTheme,
  listTileTheme: ListTileThemeData(
    contentPadding:
        const EdgeInsets.symmetric(horizontal: AppSizes.normalSpacing),
    shape: appSmallShape.copyWith(
      side: BorderSide(color: AppColors.greyLight30),
    ),
    tileColor: AppColors.greyLight10,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.transparent,
    shape: CircleBorder(side: BorderSide(color: AppColors.greyDark)),
    elevation: 0,
  ),
  tabBarTheme: TabBarTheme(
    indicatorColor: AppColors.greyDark30,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    expandedAlignment: Alignment.centerLeft,
    childrenPadding: EdgeInsets.all(AppSizes.smallSpacing),
  ),
);

const appBorderRadius =
    BorderRadius.all(Radius.circular(AppSizes.circularRadius));
const appSmallRadius = BorderRadius.all(
  Radius.circular(AppSizes.smallCircularRadius),
);

const appLargeRadius = BorderRadius.all(
  Radius.circular(AppSizes.largeCircularRadius),
);

const appShape = RoundedRectangleBorder(borderRadius: appBorderRadius);
const appSmallShape = RoundedRectangleBorder(borderRadius: appSmallRadius);
const appLargeShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(AppSizes.largeCircularRadius),
  ),
);

const cardTheme = CardTheme(shape: appSmallShape, elevation: 0);
const inputBorder = OutlineInputBorder(
  borderRadius: appLargeRadius,
  borderSide: BorderSide(color: Colors.white),
);

const inputDecorationTheme = InputDecorationTheme(
  isDense: true,
  filled: true,
  fillColor: Colors.white,
  // hintStyle: hintStyle,
  // errorStyle: accentTextStyle.copyWith(color: AppColors.red),
  border: inputBorder,
  enabledBorder: inputBorder,
  focusedBorder: inputBorder,
  errorBorder: inputBorder,
  focusedErrorBorder: inputBorder,
  disabledBorder: inputBorder,
  contentPadding: EdgeInsets.only(
    left: AppSizes.normalSpacing,
    top: AppSizes.normalSpacing,
    right: AppSizes.xLargeSpacing,
    bottom: AppSizes.normalSpacing,
  ),
);
