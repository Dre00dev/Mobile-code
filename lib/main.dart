//imports
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:mobilecode/routes.dart';
import 'package:mobilecode/services/firestore.dart';
import 'package:mobilecode/shared/loading.dart';
import 'package:mobilecode/theme.dart';
import 'package:mobilecode/services/models.dart';
import 'package:mobilecode/shared/error.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}


/// stateful so that it only creates future once
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// We should not call initializeApp directly in the build
  
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors -- commented out because richtext error maybe need to define text direction ???
        
          //you should prob just u
          //use errorScreen

        if(snapshot.hasError){
        return const MaterialApp(
          home:ErrorScreen(),
        );
        }
        
        //if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasError){
        //  return const LoadingScreen();
        //}
        
        // Once loaded, shows application
        if (snapshot.connectionState == ConnectionState.done) {
          //instead of using a streambuilder on many pages provider makes it easier
          return StreamProvider(
            create:(_) => FirestoreService().streamReport(),  //create returns stream of report 
            catchError: (_, error) => Report(),
            initialData: Report(),    //uses constructor to make default report  
            //access realtime data from report via the following declaration in each file
            //Report report = Provider.of<Report>(context)  //see models.dart if anything
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: appRoutes,
              theme: appTheme,
            ),
          );
        }
        //else show a message while it loads 
        return const MaterialApp( //exception caused by widget library  -- alleviated by putting in a material app
          home:LoadingScreen(),
        );

      },
    );
  }
}