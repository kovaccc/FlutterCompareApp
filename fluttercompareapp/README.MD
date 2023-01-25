# Flutter Starter

Flutter skeleton project that should be a starting point for every new project. It should have all
environments already setup (dev, staging, production) for iOS and Android. Project will be CI/CD
friendly. Q packages should be automatically added. Mandatory checks will be added to enforce
inclusion of crashlytics, analytics, coding standards and test code coverage. Project won't build if
any of this prerequisite are not met.

## Project setup

Let's start by setting up our environment in order to run the init project script

### Prerequisites

This starter depends on [mason_cli](https://pub.dev/packages/mason_cli)
In order to install it, run:

```
dart pub global activate mason_cli
```

Before running the initialization script, you must install the following software (Mac users already
have these):

* [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [Gem](https://rubygems.org/pages/download)
* [Xcodeproj](https://github.com/CocoaPods/Xcodeproj) (through RubyGems)

## Initialize the project

In order to initialize the project you must run the scripts/init_project bash script while inside
the q_flutter_started folder.

### Required parameters

Here is the list of required parameters:

* starterLocation - location of the q_flutter_starter on your device
* appName - project name
* package - package name for your production flavor

### Optional parameters

Here is the list of options parameters:

* sentryProject - if this parameter is set, sentry project with appName will be created on Sentry
* newProjectLocation - location of the new project location (enter directory path where new directory with your project will be created), if this parameter is not set, new project will be created in the folder one hierarchy level above of starterLocation parameter (e.g. starterLocation is /Users/test/Downloads/q_flutter_starter, newProjectLocation will be /Users/test/Downloads/ + appName)

### Example

Usage example:

```
bash scripts/init_project.sh --starterLocation . --appName "My Little App" --package "com.example.mylittleapp"
```

Example with sentryProject parameter:

```
bash scripts/init_project.sh --starterLocation . --appName "My Little App" --package "com.example.mylittleapp" --sentryProject
```

Example with newProjectLocation parameter:

```
bash scripts/init_project.sh --starterLocation . --appName "My Little App" --package "com.example.mylittleapp" --newProjectLocation /Users/<username>/Downloads
```

### Disclaimer

When you create the project, if you encounter this error while trying to run iOS app:

```
Error (Xcode): Unable to load contents of file list: '/Target Support Files/Pods-Runner/Pods-Runner-frameworks-Debug-dev-input-files.xcfilelist'

Error (Xcode): Unable to load contents of file list: '/Target Support Files/Pods-Runner/Pods-Runner-frameworks-Debug-dev-output-files.xcfilelist'
```

Try to follow this step https://stackoverflow.com/a/56966495 to fix it, basically it says you need
to open Xcode, open Build phases section, unfold `[CP] Embed Pods Frameworks` and remove the files
under `Input Files Lists` and `Output Files Lists` by selecting each of them and clicking on the `-`
button.

## Get started

- Create your abstract repository and implement it

```dart

final repositoryProvider = Provider<YourRepository>(
      (_) => YourRepositoryImplementation(),
);

abstract class YourRepository {
  EitherFailureOr<String> getYourString();
}

class YourRepositoryImplementation implements YourRepository {
  @override
  EitherFailureOr<String> getYourString() async {
    await Future.delayed(const Duration(seconds: 3));
    if (Random().nextBool()) {
      return const Right('Your string');
    } else {
      return Left(Failure.generic());
    }
  }
}
```

- Create your StateNotifier which extends BaseNotifier and add method to call your
  YourRepository.getYourString() method

```dart
class YourStateNotifier extends BaseStateNotifier<String> {
  final YourRepository _yourRepository;

  YourStateNotifier(this._yourRepository, super.ref);

  Future getYourString() =>
      execute(
        _yourRepository.getYourString(),
        withLoadingState: true,
        globalLoading: false,
        globalFailure: false,
      );
}
```

- Create provider for YourStateNotifier

```dart

final yourNotifierProvider = StateNotifierProvider<YourStateNotifier, BaseState<String>>(
      (ref) => YourStateNotifier(ref.watch(repositoryProvider), ref),
); 
```

- In your widget call your notifier getYourString() method through your provider and watch for the
  changes

```
    ref.read(yourNotifierProvider.notifier).getYourString();
    final state = ref.watch(yourNotifierProvider);
    state.maybeWhen(
      data: (yourString) => yourString,
      loading: () => 'Loading',
      initial: () => 'Initial',
      error: (failure) => failure.toString(),
      orElse: () => '',
    ),
```

That is all you need to get you started, to find out more, head over to the table of contents.

## Table of contents

- [Adding environmental variables](#adding-environmental-variables)
- [Packages used](#packages-used)
- [Real life example - BaseStateNotifier](#real-life-example---basestatenotifier)
    - [ExampleStateNotifier](#examplestatenotifier)
    - [ExamplePage](#examplepage)
- [Real life example - SimpleStateNotifier](#real-life-example---simplestatenotifier)
    - [ExampleSimpleStateNotifier](#examplesimplestatenotifier)
    - [ExampleSimplePage](#examplesimplepage)
- [BaseState<State>](#basestatestate)
- [BaseStateNotifier](#basestatenotifier)
- [SimpleStateNotifier](#simplestatenotifier)
- [Global loading](#global-loading)
- [Global failure](#global-failure)
- [Navigation](#navigation)
- [BaseWidget](#basewidget)
- [Switch navigation package to AutoRoute package](#switch-navigation-package-to-autoroute-package)
- [Switch navigation package to GoRouter package](#switch-navigation-package-to-go_router-package)
- [Logging](#logging)

## Adding environmental variables

Just modify the main/app_environment.dart file to suit your needs. Add your custom properties to the
AppEnvironment enum, and create the corresponding static getter in EnvInfo.

Example:

```

enum AppEnvironment {
  DEV(
    ...,
    myCustomProperty: 'PROPERTY_DEV'
  ),
  PROD(
    ...,
    myCustomProperty: 'PROPERTY_PROD'
  ),
  STAGING(
    ...,
    myCustomProperty: 'PROPERTY_STAGING'
  ),

  ...
  final String myCustomProperty;

  const AppEnvironment({
    ...,
    required this.myCustomProperty
  });
}

abstract class EnvInfo {
  ...
  static String get myCustomProperty => _environment.myCustomProperty;
}

```

Now you can easily access the created property anywhere in your code by calling:

```
final myProperty = EnvInfo.myCustomProperty
```

## Packages used

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
- [Freezed](https://pub.dev/packages/freezed)
- [Beamer](https://pub.dev/packages/beamer)
- [dartz](https://pub.dev/packages/dartz)
- [Equatable](https://pub.dev/packages/equatable)
- [Dart Code Metrics](https://pub.dev/packages/dart_code_metrics)
- [build_runner](https://pub.dev/packages/build_runner)
- [dio](https://pub.dev/packages/dio)
- [intl](https://pub.dev/packages/intl)
- [Retrofit](https://pub.dev/packages/retrofit)
- [Sentry Flutter](https://pub.dev/packages/sentry_flutter)
- [Flutter Flavorizr](https://pub.dev/packages/flutter_flavorizr)
- [flutter_lints](https://pub.dev/packages/flutter_lints)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [state_notifier_test](https://pub.dev/packages/state_notifier_test)
- [mocktail](https://pub.dev/packages/mocktail)
- [flutter_form_builder](https://pub.dev/packages/flutter_form_builder)
- [form_builder_validators](https://pub.dev/packages/form_builder_validators)

## Real life example - BaseStateNotifier

BaseStateNotifier is a generic notifier which every notifier should extend to avoid writing 
repetitive code and access global loading and failure handling. Route navigation is also abstracted 
and made easy to use and even switch navigation packages if necessary.

### ExampleStateNotifier

 ```dart

final exampleNotifierProvider = StateNotifierProvider<ExampleStateNotifier, BaseState<String>>(
      (ref) => ExampleStateNotifier(ref.watch(exampleRepositoryProvider), ref),
);

class ExampleStateNotifier extends BaseStateNotifier<String> {
  final ExampleRepository _exampleRepository;

  ExampleStateNotifier(this._exampleRepository, super.ref);

  Future getSomeStringFullExample() =>
      execute(
        //Function that is called. Needs to have the same success return type as State
        _exampleRepository.getSomeString(),

        //Set to true if you want to handle error globally (ex. Show error dialog above the entire app)
        globalFailure: true,

        //Set to true if you want to show BaseLoadingIndicator above the entire app
        globalLoading: false,

        //Set to true if you want to update state to BaseState.loading()
        withLoadingState: true,

        //Do some actions with data
        //If you return true, base state will be updated to BaseState.data(data)
        //If you return false, state will not be updated
        onDataReceived: (data) {
          // Custom handle data
          return true;
        },

        //Do some actions with failure
        //If you return true, base state will be updated to BaseState.error(failure)
        //If you return false, state will not be updated
        onFailureOccurred: (failure) {
          // Custom handle data
          return true;
        },
      );

  //Example of the API request with global loading indicator
  Future getSomeStringGlobalLoading() =>
      execute(
        _exampleRepository.getSomeString(),
        globalLoading: true,
        withLoadingState: false,
      );
}

```

### ExamplePage

 ```dart

class ExamplePage extends ConsumerWidget {
  static const routeName = '/';

  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.when(
                data: (sentence) => sentence,
                loading: () => 'Loading',
                initial: () => 'Initial',
                error: (failure) => failure.toString(),
              ),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringFullExample,
              child: const Text('Get string'),
            ),
            TextButton(
              onPressed: ref
                  .read(exampleNotifierProvider.notifier)
                  .getSomeStringGlobalLoading,
              child: const Text('Global loading example'),
            ),
            //Navigation example
            TextButton(
              onPressed: () => ref.pushNamed(ExamplePage2.routeName),
              child: const Text('Navigate'),
            ),
          ],
        ),
      ),
    );
  }
}

```

## Real life example - SimpleStateNotifier

If BaseStateNotifier restrain you in some way and its BaseState does not cover your use case, but
you want to use some benefits of BaseNotifier, then SimpleStateNotifier is here for you.

### ExampleSimpleStateNotifier

```dart

final exampleSimpleStateNotifierProvider = StateNotifierProvider<
    ExampleSimpleStateNotifier,
    ExampleSimpleState>(
      (ref) {
    return ExampleSimpleStateNotifier(
      ref.watch(exampleRepositoryProvider),
      ref,
    );
  },
);

class ExampleSimpleStateNotifier extends SimpleStateNotifier<ExampleSimpleState> {
  final ExampleRepository _exampleRepository;

  ExampleSimpleStateNotifier(this._exampleRepository, Ref ref)
      : super(ref, const ExampleSimpleState.initial());

  /// Example method when you want to get state updates when calling some repository method
  Future<void> getSomeStringSimpleExample() async {
    state = const ExampleSimpleState.fetching();
    final response = await _exampleRepository.getSomeOtherString();
    response.fold(
          (l) {
        state = ExampleSimpleState.error(l);
      },
          (r) {
        if (r.isEmpty) {
          state = const ExampleSimpleState.empty();
        } else {
          state = ExampleSimpleState.success(r);
        }
      },
    );
  }

  /// Example method when you want to use global loading and global failure methods 
  /// when calling some repository method
  Future<void> getSomeStringSimpleExampleGlobalLoading() async {
    showGlobalLoading();
    final response = await _exampleRepository.getSomeOtherString();
    response.fold(
          (l) {
        setGlobalFailure(l);
      },
          (r) {
        clearGlobalLoading();
        if (r.isEmpty) {
          state = const ExampleSimpleState.empty();
        } else {
          state = ExampleSimpleState.success(r);
        }
      },
    );
  }
}
```

### ExampleSimplePage

```dart
class ExampleSimplePage extends ConsumerStatefulWidget {
  static const routeName = '/simple-page';

  const ExampleSimplePage({super.key});

  @override
  ConsumerState<ExampleSimplePage> createState() => _ExampleSimplePageState();
}

class _ExampleSimplePageState extends ConsumerState<ExampleSimplePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exampleSimpleStateNotifierProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.when(
              initial: () => 'Initial',
              empty: () => 'Empty',
              fetching: () => 'Fetching',
              success: (string) => string,
              error: (failure) => failure.title,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: ref
                .read(exampleSimpleStateNotifierProvider.notifier)
                .getSomeStringSimpleExample,
            child: const Text('Simple state example'),
          ),
          TextButton(
            onPressed: ref
                .read(exampleSimpleStateNotifierProvider.notifier)
                .getSomeStringSimpleExampleGlobalLoading,
            child: const Text('Global loading example'),
          ),
          ElevatedButton(
            onPressed: ref.pop,
            child: const Text('Go back!'),
          ),
          TextButton(
            onPressed: () => ref.pushNamed(ExamplePage3.routeName),
            child: const Text('Navigate'),
          ),
        ],
      ),
    );
  }
}
```

## BaseState<State>

BaseState has 5 primary states:

1. **initial**

2. **loading**

3. **data(State)** - ex. Used for showing successful API call response

4**error(Failure)**

**State** has to be the same type as the return value from the function that is called

```dart

@freezed
class BaseState<State> with _$BaseState<State> {
  const factory BaseState.initial() = _Initial;

  const factory BaseState.loading() = _Loading;

  const factory BaseState.data(State data) = _Data;

  const factory BaseState.error(Failure failure) = _Error;
}
```

## BaseStateNotifier

Abstract StateNotifier class which provides some convenient methods to be used by subclassing it.
Among execute method which will be explained separately, it provides:

* **showGlobalLoading** & **clearGlobalLoading** for handling global loading

* **setGlobalFailure** for handling global failure (will automatically call **clearGlobalLoading**
  before showing global failure)

## SimpleStateNotifier

Abstract StateNotifier class which provides some convenient methods to be used by subclassing it. It
can be used when BaseState doesn't suit you and you need more states, the common thing it has
with **BaseStateNotifier** are **showGlobalLoading**, **clearGlobalLoading**
and **setGlobalFailure** methods.

### Execute method

The main **BaseStateNotifier** method which supports different options for handling the data,
failures and loading.

```dart
  @protected
  Future execute(EitherFailureOr<DataState> function, {
    PreHandleData<DataState>? onDataReceived,
    PreHandleFailure? onFailureOccurred,
    bool withLoadingState = true,
    bool globalLoading = false,
    bool globalFailure = true,
  });
```

* **function** parameter receives method to execute with return value EitherFailureOr<DataState>.

* **withLoadingState** bool parameter says while calling and waiting **function** to finish, loading
  state should be set.

* **globalLoading** bool parameter says while calling and waiting **function**
  to finish, loading over the the whole app should be shown.

* **globalFailure** bool parameter says if **function** returns Failure, should it be shown globally
  over the whole app or not. &nbsp;

To filter and control which data will update the state, **onDataReceived** callback can be passed.
Alternatively, if callback always return false, custom data handling can be implemented. &nbsp;

To filter and control which failure will update the state or be shown globally, **
onFailureOccurred**
callback can be passed. Similar to **onDataReceived** if always returned false, custom failure
handling can be implemented.

### Execute streamed method

Similar to **BaseStateNotifier**'s **execute** method is the **executeStreamed** method which in the core 
performs the same job as the execute method with a slight difference in that it requires a **function** 
parameter's return type to be of type **Stream** which allows us to return multiple results from the repository
and by doing so we can use this functionality to create an easy to use caching mechanism by yielding
cached data + network data.

```
  @protected
  Future<void> executeStreamed(
    StreamFailureOr<DataState> function, {
    PreHandleData<DataState>? onDataReceived,
    PreHandleFailure? onFailureOccurred,
    bool withLoadingState = true,
    bool globalLoading = false,
    bool globalFailure = true,
  });
```

#### Example usage (if you want to know what is the source of yielded data eg. cache or network) - recommended

In your state notifier:

```
  class ExampleCacheStateNotifier extends BaseStateNotifier<Result<String>> {
  //...
  Future getSomeStringsStreamed() => executeStreamed(
     _exampleRepository.getSomeStringsStreamed(),
  );
```

In repository:

```
  @override
  StreamFailureOrResult<String> getSomeResultStringsStreamed() async* {
    yield Right(Result.cache('Some sentence'));
    //...
    yield Right(Result.network('Some sentence'));
  }
```

#### Example usage (if you don't need to know what is the source of yielded data)

In your state notifier:

```
  class ExampleStateNotifier extends BaseStateNotifier<String> {
  //...
  Future getSomeStringsStreamed() => executeStreamed(
        _exampleRepository.getSomeStringsStreamed(),
  );
```

In repository:

```
  @override
  StreamFailureOr<String> getSomeStringsStreamed() async* {
    yield const Right('Some sentence from cache');
    //...
    yield const Right('Some sentence from network');
  }
```

## Global loading

**globalLoadingProvider** can be used to show the loading indicator without updating
**BaseStateNotifier** state.

```dart

final globalLoadingProvider = StateProvider<bool>((_) => false);
```

### Loading example

**BaseLoadingIndicator** can be shown by setting **globalLoading** inside of execute method to
**true**

```dart
//...
Future getSomeString() =>
    execute(
      _exampleRepository.getSomeString(),
      globalLoading: true,
    );
//...
```

You can also change **BaseNotifier** state to BaseState.loading by setting
**withLoadingState** to **true**

```dart
//...
Future getSomeString() =>
    execute(
      _exampleRepository.getSomeString(),
      globalLoading: true,
      withLoadingState: true,
    );
//...
```

## Global failure

**globalFailureProvider** can be used to show the failure that happened in the application without
updating **BaseStateNotifier** state.

```dart

final globalFailureProvider = StateProvider<Failure?>((_) => null);
```

### Global failure listener

```dart
void globalFailureListener() {
  listen<Failure?>(globalFailureProvider, (_, failure) {
    if (failure == null) return;
    //Show global error
    logError('''showing ${failure.isCritical ? '' : 'non-'}critical failure with title ${failure.title},
          error: ${failure.error},
          stackTrace: ${failure.stackTrace}
      ''');
  });
}
```

### Failure example

**globalFailureProvider** listener will be triggered by setting **globalFailure** inside of execute
method to **true** when failure happens. If set to false, instead of updating globalFailureProvider,
**BaseStateNotifier** state will be set to error so the failure can be shown directly on the screen,
not in the overlay as a toast or a dialog.

```dart
//...
Future getSomeString() =>
    execute(
      _exampleRepository.getSomeString(),
      globalFailure: false,
    );
//...
```

## Navigation

**globalNavigationProvider** with **RouteAction** type can be used to execute push, pop and similar
navigation actions. Navigation can be used directly by updating **globalNavigationProvider** or by
using extension on WidgetRef class which initially provides **pushNamed**,
**pushReplacementNamed** and **pop** methods.
**BaseWidget** registers listener for **globalNavigationProvider** and therefore any change
triggers **execute** method of **RouteAction** object.

### Global navigation listener

```dart
void globalNavigationListener() {
  listen<RouteAction?>(
    globalNavigationProvider,
        (_, state) => state?.execute(read(baseRouterProvider)),
  );
}
```

To navigate from current to the next page it can be done like this:

```
ref.pushNamed(nextPageRouteName);
```

or to pop back to previous page:

```
ref.pop();
```

With pushNamed and pushReplacementNamed methods, optional **data** parameter can be passed 
containing some data that you might want to pass to the next screen. To read that data on 
the next screen (data can be shared within the same BeamLocation) **getData** method can be 
called on the BaseRouter class:
```
ref.read(baseRouterProvider).getData
```

If more navigation actions are necessary, RouteAction can be subclassed with desired action and new
method can be added into BaseStateNotifier that will use that class. Also, BaseRouter can be
expanded with new navigation method and then implemented in the descendant class which will be used
in RouteAction descendant class.

Default navigation package being used is **Beamer** and in **baseRouterProvider** its BaseRouter
subclass BeamerRouter is being instantiated.

If necessary, by making few changes navigation package can be easily switched to **AutoRoute**,
**GoRouter** or probably any other navigation package but here short notes will be provided for only
two mentioned alternatives to Beamer.

## BaseWidget

The entire app is wrapped in **BaseWidget** which listens to:

* **globalFailureProvider**

* **globalNavigationProvider**

* **globalLoadingProvider**.

```dart

class BaseWidget extends ConsumerWidget {
  final Widget child;

  const BaseWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if you need context to showDialog or bottomSheet, use BaseRouter's navigatorContext because main context
    // won't work as BaseWidget is the first widget in builder method of MaterialApp.router so Navigator is not ready yet.
    // Be careful not to use it directly in build method (it is not ready yet), but in button callback or within 
    // WidgetsBinding.instance.addPostFrameCallback.
    // final navigatorContext = ref.read(baseRouterProvider).navigatorContext;
    ref.globalFailureListener();
    ref.globalNavigationListener();
    final showLoading = ref.watch(globalLoadingProvider);
    return Stack(
      children: [
        child,
        if (showLoading) const BaseLoadingIndicator(),
      ],
    );
  }
}
```

## Switch navigation package to AutoRoute package

1. add auto_route dependency to pubspec.yaml
2. create app_router.dart file, define AppRouter class with options defined in its documentation
3. (including generating .gr.dart file by running **flutter packages pub run build_runner build**
   in terminal)
4. create **AppRouterRouter** class in **base_router.dart** and override BaseRouter's navigation
   methods, it can look something like this:

  ```
  class AppRouterRouter extends BaseRouter {
    AppRouterRouter({required super.routerDelegate, required super.routeInformationParser, super.router});

    @override
    void pushNamed(String routeName, {dynamic data}) {
      (router as AppRouter).pushNamed(routeName);
    }
  
    ...
  }
  ```

5. update **baseRouterProvider** in **base_router_provider.dart** to use **AppRouterRouter**
   class instead of **BeamerRouter**
6. remove **BeamerProvider** widget from **main.dart**

&nbsp;

## Switch navigation package to go_router package:

1. add go_router dependency to pubspec.yaml

2. create **GoRouterRouter** class in **base_router.dart** and override BaseRouter's navigation
   methods, it can look something like this:
      ```
      class GoRouterRouter extends BaseRouter {
        GoRouterRouter({
          required super.routerDelegate,
          required super.routeInformationParser,
          super.routeInformationProvider,
          super.router,
        });
      
        @override
        void pushNamed(String routeName, {dynamic data}) {
          (router as GoRouter).push(routeName, extra: data);
        }
      
        ...
      }
      ```
3. update **baseRouterProvider** in **base_router_provider.dart** to use **GoRouterRouter** class
   instead of **BeamerRouter**

  ```
  final baseRouterProvider = StateProvider<BaseRouter>((ref) {
    final goRouter = GoRouter(
      routes: <GoRoute>[
        ...
      ],
    );
    return GoRouterRouter(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      router: goRouter,
    );
  });
  ```

4. remove **BeamerProvider** widget from **main.dart**

## Logging

We are using [loggy](https://pub.dev/packages/loggy) package for logging everything, including
network request.

It prints out very readable logs and does not log anything to the console in the production
environment. You can log different severity levels like warnings, errors and info.

```
  logDebug('This is debug message');
  logInfo('This is info message');
  logWarning('This is warning message');
  logError('This is error message');
```

Additional benefit of using loggy package is showing log directly inside the Flutter application.

You can show the log bottom sheet simply by shaking your device or by calling:
```QLogger.showLogger(context);``` in the code.


<img src="./assets/readme_images/log_ screenshot.png" width="30%" height="30%"/>


