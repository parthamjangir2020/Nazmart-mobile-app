// To parse this JSON data, do
//
//     final ticketMessagesModel = ticketMessagesModelFromJson(jsonString);

import 'dart:convert';

List<TicketMessagesModel> ticketMessagesModelFromJson(String str) =>
    List<TicketMessagesModel>.from(
        json.decode(str).map((x) => TicketMessagesModel.fromJson(x)));

String ticketMessagesModelToJson(List<TicketMessagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketMessagesModel {
  TicketMessagesModel({
    this.id,
    this.message,
    this.notify,
    this.attachment,
    this.type,
    this.supportTicketId,
  });

  int? id;
  String? message;
  String? notify;
  String? attachment;
  String? type;
  int? supportTicketId;

  factory TicketMessagesModel.fromJson(Map<String, dynamic> json) =>
      TicketMessagesModel(
        id: json["id"],
        message: json["message"],
        notify: json["notify"],
        attachment: json["attachment"],
        type: json["type"],
        supportTicketId: json["support_ticket_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "notify": notify,
        "attachment": attachment,
        "type": type,
        "support_ticket_id": supportTicketId,
      };
}
