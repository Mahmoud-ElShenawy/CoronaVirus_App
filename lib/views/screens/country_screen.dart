import 'package:coronavirus_app/models/country_model.dart';
import 'package:coronavirus_app/models/country_summary_model.dart';
import 'package:coronavirus_app/view_models/country_view_model.dart';
import 'package:coronavirus_app/views/widgets/country_loading.dart';
import 'package:coronavirus_app/views/widgets/country_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:coronavirus_app/style/theme.dart' as Theme;

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final TextEditingController _typeAheadController = TextEditingController();
  Future<List<CountryModel>> _countryList;
  Future<List<CountrySummaryModel>> _summaryList;

  @override
  void initState() {
    super.initState();
    this._typeAheadController.text = 'EGYPT';
    _countryList = Provider.of<CountryViewModel>(context, listen: false).fetchCountryList();
    _summaryList = Provider.of<CountryViewModel>(context, listen: false)
        .fetchCountrySummaryList('egypt');
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: FutureBuilder(
        future: _countryList,
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text(
                'Sorry, There is Error',
              ),
            );
          }
          switch (snapShot.connectionState) {
            case ConnectionState.waiting:
              return CountryLoading(
                inputTextLoading: true,
              );
            default:
              return !snapShot.hasData
                  ? Center(
                      child: Text(
                        'Empty Data',
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 4,
                          ),
                          child: Center(
                            child: Text(
                              'Please, Type The Country Name',
                              style: TextStyle(
                                color: Theme.Colors.kAmberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            autocorrect: true,
                            controller: this._typeAheadController,
                            decoration: InputDecoration(
                              hintText: 'Type Here The Country Name',
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Theme.Colors.kGrey200,
                              contentPadding: const EdgeInsets.all(20),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                                child: Icon(
                                  Icons.search,
                                  color: Theme.Colors.kAmber900,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return Provider.of<CountryViewModel>(context, listen: false)
                                .fetchSuggestions(snapShot.data, pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(
                                suggestion,
                              ),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            this._typeAheadController.text = suggestion;
                            setState(() {
                              _summaryList =
                                  Provider.of<CountryViewModel>(context, listen: false)
                                      .fetchCountrySummaryList(snapShot.data
                                          .firstWhere((element) =>
                                              element.country == suggestion)
                                          .slug);
                            });
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FutureBuilder(
                          future: _summaryList,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Sorry, There is Error',
                                ),
                              );
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CountryLoading(
                                  inputTextLoading: false,
                                );
                              default:
                                return !snapshot.hasData
                                    ? Center(
                                        child: Text(
                                          'Empty Data',
                                        ),
                                      )
                                    : CountryStatistics(summaryList: snapshot.data,);
                            }
                          },
                        ),
                      ],
                    );
          }
        },
      ),
    );
  }
}
