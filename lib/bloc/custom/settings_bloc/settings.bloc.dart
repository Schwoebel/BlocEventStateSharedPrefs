import 'dart:async';
import 'package:bloc_shared_prefs/bloc/bloc/bloc_event_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.event.dart';
part 'settings.state.dart';

/// I like to Use enums for keys, event if the keys look odd they will
/// always be consistent

enum SettingsKeys { text_to_speech_rate, text_to_speech_pitch, app_language }

/// this makes this Bloc accessible anywhere
/// So once the settings are put in you just call preferencesBlod somewhere else in
/// your app and the settings are available
SettingsBloc preferencesBloc = SettingsBloc();

///Default for your app
const Map<SettingsKeys, dynamic> defaults = {
  SettingsKeys.app_language: 'sv-SE',
  SettingsKeys.text_to_speech_rate: 1.0,
  SettingsKeys.text_to_speech_pitch: 1.0
};

class SettingsBloc extends BlocEventStateBase<SettingsEvent, SettingsState> {
  SettingsBloc() {
    _loadAppDefaults();
    _loadSharedPreferences();
  }

  @override
  SettingsState get initialState => SettingsState();

  @override
  Stream<SettingsState> eventHandler(
      SettingsEvent event, SettingsState currentState) async* {
    if (event is SavePitchEvent) {
      await _updateSharedPreference(
          SettingsKeys.text_to_speech_pitch.toString(), event.pitch);
    } else if (event is SaveRateEvent) {
      await _updateSharedPreference(
          SettingsKeys.text_to_speech_rate.toString(), event.rate);
    } else if (event is SaveLanguageEvent) {
      await _updateSharedPreference(
          SettingsKeys.app_language.toString(), event.language);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    yield SettingsState.updated(
      updateLanguage: prefs.getString(
        SettingsKeys.app_language.toString(),
      ),
      updatePitch: prefs.getDouble(
        SettingsKeys.text_to_speech_pitch.toString(),
      ),
      updatedRate: prefs.getDouble(
        SettingsKeys.text_to_speech_rate.toString(),
      ),
    );
  }

  SettingsBloc._internal();

  @override
  void dispose() {
    super.dispose();
  }
  /// This inserts your defaults into SharePreferences
  Future<void> _loadAppDefaults() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    defaults.forEach(
      (SettingsKeys key, dynamic value) async {
        final _sharedPreference = sharedPrefs.get(
          key.toString(),
        );
        if (_sharedPreference == null)
          await _updateSharedPreference(key.toString(), value);
      },
    );
  }
  /// this takes the settings from SharePreferences and makes them
  /// available to the bloc
  Future<void> _loadSharedPreferences() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final _ttsPitchPref = sharedPrefs.getDouble(
      SettingsKeys.text_to_speech_pitch.toString(),
    );
    final _ttsRatePref = sharedPrefs.getDouble(
      SettingsKeys.text_to_speech_rate.toString(),
    );
    final _appLanguagePref = sharedPrefs.getString(
      SettingsKeys.app_language.toString(),
    );
    emitEvent(
      InitializedSettingsEvent(_ttsPitchPref, _ttsRatePref, _appLanguagePref),
    );
  }

  /// This doesn't account for all types except for the settings I want or use
  Future<void> _updateSharedPreference(String key, dynamic value) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else {
      sharedPrefs.setString(key, value);
    }
  }
}
