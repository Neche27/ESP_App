class Client_JSON {
  final String temp;
  final String hum;

  Client_JSON(this.temp, this.hum);

  Client_JSON.fromJson(Map<String, dynamic> json)
      : temp = json['temperature'] as String,
        hum = json['humidity'] as String;

  Map<String, dynamic> toJson() => {
        'temperature': temp,
        'humidity': hum,
      };
}