part of 'settings.bloc.dart';
/// I go with named Event Classes by What 'i' would tell it to do if I had a magic wand.
/// 'MagicWord'Event
/// Corny, but clear.
class SettingsEvent extends BlocEvent{
  final SettingsEventType eventType;
  SettingsEvent(this.eventType);
}

class InitializedSettingsEvent extends SettingsEvent{
  final double pitch;
  final double rate;
  final String language;
  InitializedSettingsEvent(this.pitch, this.rate, this.language): super(SettingsEventType.init);
}

class SavePitchEvent extends SettingsEvent{
  final double pitch;
  SavePitchEvent(this.pitch): super(SettingsEventType.save_pitch);
}

class SaveRateEvent extends SettingsEvent{
  final double rate;
  SaveRateEvent(this.rate): super(SettingsEventType.save_rate);
}

class SaveLanguageEvent extends SettingsEvent{
  final String language;
  SaveLanguageEvent(this.language): super(SettingsEventType.save_language);
}


enum SettingsEventType {
  init,
  save_rate,
  save_pitch,
  save_language
}