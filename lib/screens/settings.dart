import 'package:bloc_shared_prefs/bloc/bloc/bloc_state_builder.dart';
import 'package:bloc_shared_prefs/bloc/custom/settings_bloc/settings.bloc.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String dropDownValue;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocEventStateBuilder<SettingsState>(
        bloc: preferencesBloc,
        builder: (BuildContext context, SettingsState state) {
          return SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Slider(
                  label: (state.ttsPitch / 100).toString(),
                  divisions: 20,
                  value: state.ttsPitch,
                  onChanged: (double newValue) {
                    preferencesBloc.emitEvent(
                      SavePitchEvent(newValue),
                    );
                  },
                  max: 100.0,
                  min: 0.0,
                ),
                Slider(
                  label: (state.ttsRate / 100).toString(),
                  divisions: 20,
                  value: state.ttsRate,
                  onChanged: (double newValue) {
                    preferencesBloc.emitEvent(
                      SaveRateEvent(newValue),
                    );
                  },
                  max: 100.0,
                  min: 0.0,
                ),
                DropdownButton<String>(
                  value: state.appLanguage,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (dynamic newValue) {
                    preferencesBloc.emitEvent(
                      SaveLanguageEvent(newValue),
                    );
                  },
                  items: state.languageSelection.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(
                        state.languageSelection[key],
                      ),
                    );
                  }).toList(),
                ),
                Text(
                  state.ttsPitch.toString(),
                ),
                Text(
                  state.ttsRate.toString(),
                ),
                Text(state.appLanguage)
              ],
            ),
          );
        },
      ),
    );
  }
}
