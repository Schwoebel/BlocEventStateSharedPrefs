part of 'settings.bloc.dart';

class SettingsState extends BlocState{
  final double ttsRate;
  final double ttsPitch;
  final String appLanguage;
  final Map<String, String> language_selection = {'en-US': 'American English', 'sv-SE': 'Svenska', 'en-GB': 'British English'};
  SettingsState(
    {this.ttsPitch= 1.0,
      this.ttsRate= 1.0,
      this.appLanguage= 'sv-SE',
    });

  factory SettingsState.updated({updateLanguage = 'sv-SE', updatePitch = 1.0, updatedRate = 1.0}){
    return SettingsState(ttsRate:updatedRate,ttsPitch:updatePitch, appLanguage: updateLanguage);
  }
}


