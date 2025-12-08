// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../v2board_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_V2BoardUser _$V2BoardUserFromJson(Map<String, dynamic> json) => _V2BoardUser(
  id: (json['id'] as num?)?.toInt() ?? 0,
  email: json['email'] as String?,
  transferEnable: (json['transfer_enable'] as num?)?.toInt(),
  uploadTraffic: (json['u'] as num?)?.toInt(),
  downloadTraffic: (json['d'] as num?)?.toInt(),
  expiredAt: (json['expired_at'] as num?)?.toInt(),
  planId: (json['plan_id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  balance: (json['balance'] as num?)?.toInt() ?? 0,
  plan: json['plan'] == null
      ? null
      : V2BoardPlan.fromJson(json['plan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$V2BoardUserToJson(_V2BoardUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'transfer_enable': instance.transferEnable,
      'u': instance.uploadTraffic,
      'd': instance.downloadTraffic,
      'expired_at': instance.expiredAt,
      'plan_id': instance.planId,
      'uuid': instance.uuid,
      'avatar_url': instance.avatarUrl,
      'balance': instance.balance,
      'plan': instance.plan,
    };

_V2BoardPlan _$V2BoardPlanFromJson(Map<String, dynamic> json) => _V2BoardPlan(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  content: json['content'] as String?,
  groupId: (json['group_id'] as num?)?.toInt(),
  transferEnable: (json['transfer_enable'] as num?)?.toInt(),
  speedLimit: (json['speed_limit'] as num?)?.toInt(),
  deviceLimit: (json['device_limit'] as num?)?.toInt(),
  monthPrice: (json['month_price'] as num?)?.toInt(),
  quarterPrice: (json['quarter_price'] as num?)?.toInt(),
  halfYearPrice: (json['half_year_price'] as num?)?.toInt(),
  yearPrice: (json['year_price'] as num?)?.toInt(),
  twoYearPrice: (json['two_year_price'] as num?)?.toInt(),
  threeYearPrice: (json['three_year_price'] as num?)?.toInt(),
  onetimePrice: (json['onetime_price'] as num?)?.toInt(),
  resetPrice: (json['reset_price'] as num?)?.toInt(),
  show: (json['show'] as num?)?.toInt(),
  sort: (json['sort'] as num?)?.toInt(),
  renew: (json['renew'] as num?)?.toInt(),
);

Map<String, dynamic> _$V2BoardPlanToJson(_V2BoardPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'group_id': instance.groupId,
      'transfer_enable': instance.transferEnable,
      'speed_limit': instance.speedLimit,
      'device_limit': instance.deviceLimit,
      'month_price': instance.monthPrice,
      'quarter_price': instance.quarterPrice,
      'half_year_price': instance.halfYearPrice,
      'year_price': instance.yearPrice,
      'two_year_price': instance.twoYearPrice,
      'three_year_price': instance.threeYearPrice,
      'onetime_price': instance.onetimePrice,
      'reset_price': instance.resetPrice,
      'show': instance.show,
      'sort': instance.sort,
      'renew': instance.renew,
    };

_V2BoardOrder _$V2BoardOrderFromJson(Map<String, dynamic> json) =>
    _V2BoardOrder(
      tradeNo: json['trade_no'] as String?,
      planId: (json['plan_id'] as num?)?.toInt(),
      cycle: json['cycle'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      createdAt: (json['created_at'] as num?)?.toInt(),
      plan: json['plan'] == null
          ? null
          : V2BoardPlan.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$V2BoardOrderToJson(_V2BoardOrder instance) =>
    <String, dynamic>{
      'trade_no': instance.tradeNo,
      'plan_id': instance.planId,
      'cycle': instance.cycle,
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'created_at': instance.createdAt,
      'plan': instance.plan,
    };

_V2BoardSubscription _$V2BoardSubscriptionFromJson(Map<String, dynamic> json) =>
    _V2BoardSubscription(
      subscribeUrl: json['subscribe_url'] as String?,
      token: json['token'] as String?,
      plan: json['plan'] == null
          ? null
          : V2BoardPlan.fromJson(json['plan'] as Map<String, dynamic>),
      uploadTraffic: (json['u'] as num?)?.toInt(),
      downloadTraffic: (json['d'] as num?)?.toInt(),
      transferEnable: (json['transfer_enable'] as num?)?.toInt(),
      expiredAt: (json['expired_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$V2BoardSubscriptionToJson(
  _V2BoardSubscription instance,
) => <String, dynamic>{
  'subscribe_url': instance.subscribeUrl,
  'token': instance.token,
  'plan': instance.plan,
  'u': instance.uploadTraffic,
  'd': instance.downloadTraffic,
  'transfer_enable': instance.transferEnable,
  'expired_at': instance.expiredAt,
};

_V2BoardNotice _$V2BoardNoticeFromJson(Map<String, dynamic> json) =>
    _V2BoardNotice(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
      imgUrl: json['imgUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$V2BoardNoticeToJson(_V2BoardNotice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'imgUrl': instance.imgUrl,
      'tags': instance.tags,
    };

_V2BoardTicket _$V2BoardTicketFromJson(Map<String, dynamic> json) =>
    _V2BoardTicket(
      id: (json['id'] as num).toInt(),
      subject: json['subject'] as String?,
      priority: (json['level'] as num?)?.toInt(),
      statusCode: (json['status'] as num?)?.toInt(),
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
      replyStatus: (json['reply_status'] as num?)?.toInt(),
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => V2BoardTicketMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$V2BoardTicketToJson(_V2BoardTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'level': instance.priority,
      'status': instance.statusCode,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'reply_status': instance.replyStatus,
      'message': instance.message,
    };

_V2BoardTicketMessage _$V2BoardTicketMessageFromJson(
  Map<String, dynamic> json,
) => _V2BoardTicketMessage(
  id: (json['id'] as num).toInt(),
  ticketId: (json['ticket_id'] as num?)?.toInt(),
  message: json['message'] as String?,
  isMe: json['is_me'] as bool?,
  createdAt: (json['created_at'] as num?)?.toInt(),
);

Map<String, dynamic> _$V2BoardTicketMessageToJson(
  _V2BoardTicketMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'ticket_id': instance.ticketId,
  'message': instance.message,
  'is_me': instance.isMe,
  'created_at': instance.createdAt,
};
