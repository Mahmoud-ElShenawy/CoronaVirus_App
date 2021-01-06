import 'package:coronavirus_app/view_models/country_view_model.dart';
import 'package:coronavirus_app/view_models/global_view_model.dart';
import 'package:coronavirus_app/views/screens/tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => GlobalViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoronaVirus App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: TrackScreen(),
      ),
    );
  }
}
