import '../../config/app_constants.dart';

class MessageModel {
  late String message;
  late MESSAGE_OWNER messageOwner;
  late String audioFilePath;
  late String timeOfSending;

  MessageModel({
    required this.message,
    required this.messageOwner,
    required this.audioFilePath,
    required this.timeOfSending,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageOwner = json['messageOwner'];
    audioFilePath = json['audioFilePath'];
    timeOfSending = json['timeOfSending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['messageOwner'] = messageOwner;
    data['audioFilePath'] = audioFilePath;
    data['timeOfSending'] = timeOfSending;
    return data;
  }
}
