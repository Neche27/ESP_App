class ButtonJson{
  final String temp;
  final String hum;
  final List buttons;

  ButtonJson(this.temp, this.hum, this.buttons);

  ButtonJson.fromJson(Map<String, dynamic> json)
      : temp = json['temperature'] as String,
        hum = json['humidity'] as String,
        buttons = json['Buttons'] as List;

  Map<String, dynamic> toJson() => {
        'temperature': temp,
        'humidity': hum,
        'Buttons' : buttons,
      };
}