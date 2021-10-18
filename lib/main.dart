import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

// SCREENS
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
          child: OutlinedButton(
        onPressed: () => Beamer.of(context).beamToNamed("/posts"),
        child: const Text("Go to posts"),
      )),
    );
  }
}

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Screen'),
      ),
      body: Center(
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 1,
              child: Text('Delete'),
            ),
          ],
          onSelected: (int value) => Beamer.of(context).beamToNamed("/home"),
        ),
      ),
    );
  }
}

// LOCATIONS
class _HomeBeamLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ["/home"];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('home'),
          child: const HomeScreen(),
        ),
      ];
}

class _PostBeamLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ["/posts"];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('posts'),
          child: const PostsScreen(),
        ),
      ];
}

// APP
class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    initialPath: "/home",
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: BeamerLocationBuilder(beamLocations: [
      _HomeBeamLocation(),
      _PostBeamLocation(),
    ]),
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}

void main() => runApp(MyApp());
