// V2Board API Models
// Data structures for V2Board API responses

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'generated/v2board_models.freezed.dart';
part 'generated/v2board_models.g.dart';

/// User info from V2Board
@freezed
abstract class V2BoardUser with _$V2BoardUser {
  const factory V2BoardUser({
    @Default(0) int id,
    String? email,
    @JsonKey(name: 'transfer_enable') int? transferEnable,
    @JsonKey(name: 'u') int? uploadTraffic,
    @JsonKey(name: 'd') int? downloadTraffic,
    @JsonKey(name: 'expired_at') int? expiredAt,
    @JsonKey(name: 'plan_id') int? planId,
    @JsonKey(name: 'uuid') String? uuid,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @Default(0) int balance,
    V2BoardPlan? plan,
  }) = _V2BoardUser;

  factory V2BoardUser.fromJson(Map<String, dynamic> json) =>
      _$V2BoardUserFromJson(json);
}

extension V2BoardUserExtension on V2BoardUser {
  /// Get used traffic in bytes
  int get usedTraffic => (uploadTraffic ?? 0) + (downloadTraffic ?? 0);

  /// Get total traffic in bytes
  int get totalTraffic => transferEnable ?? 0;

  /// Get remaining traffic in bytes
  int get remainingTraffic => totalTraffic - usedTraffic;

  /// Get traffic usage percentage (0-100)
  double get trafficUsagePercent {
    if (totalTraffic == 0) return 0;
    return (usedTraffic / totalTraffic * 100).clamp(0, 100);
  }

  /// Check if expired
  bool get isExpired {
    if (expiredAt == null) return false;
    return DateTime.fromMillisecondsSinceEpoch(expiredAt! * 1000)
        .isBefore(DateTime.now());
  }

  /// Get expiry date
  DateTime? get expiryDate {
    if (expiredAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(expiredAt! * 1000);
  }

  /// Get days until expiry
  int? get daysUntilExpiry {
    final expiry = expiryDate;
    if (expiry == null) return null;
    return expiry.difference(DateTime.now()).inDays;
  }

  /// Format traffic as human readable string
  String formatTraffic(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int unitIndex = 0;
    double value = bytes.toDouble();
    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }
    return '${value.toStringAsFixed(2)} ${units[unitIndex]}';
  }
}

/// Subscription plan details
@freezed
abstract class V2BoardPlan with _$V2BoardPlan {
  const factory V2BoardPlan({
    required int id,
    String? name,
    String? content,
    @JsonKey(name: 'group_id') int? groupId,
    @JsonKey(name: 'transfer_enable') int? transferEnable,
    @JsonKey(name: 'speed_limit') int? speedLimit,
    @JsonKey(name: 'device_limit') int? deviceLimit,
    @JsonKey(name: 'month_price') int? monthPrice,
    @JsonKey(name: 'quarter_price') int? quarterPrice,
    @JsonKey(name: 'half_year_price') int? halfYearPrice,
    @JsonKey(name: 'year_price') int? yearPrice,
    @JsonKey(name: 'two_year_price') int? twoYearPrice,
    @JsonKey(name: 'three_year_price') int? threeYearPrice,
    @JsonKey(name: 'onetime_price') int? onetimePrice,
    @JsonKey(name: 'reset_price') int? resetPrice,
    int? show,
    int? sort,
    int? renew,
  }) = _V2BoardPlan;

  factory V2BoardPlan.fromJson(Map<String, dynamic> json) =>
      _$V2BoardPlanFromJson(json);
}

extension V2BoardPlanExtension on V2BoardPlan {
  /// Get formatted price in points
  String formatPrice(int? priceInCents) {
    if (priceInCents == null) return '-';
    return '$priceInCents 點';
  }
  
  /// Get available price cycles
  List<MapEntry<String, int>> get availableCycles {
    final cycles = <MapEntry<String, int>>[];
    if (monthPrice != null) cycles.add(MapEntry('month_price', monthPrice!));
    if (quarterPrice != null) cycles.add(MapEntry('quarter_price', quarterPrice!));
    if (halfYearPrice != null) cycles.add(MapEntry('half_year_price', halfYearPrice!));
    if (yearPrice != null) cycles.add(MapEntry('year_price', yearPrice!));
    if (twoYearPrice != null) cycles.add(MapEntry('two_year_price', twoYearPrice!));
    if (threeYearPrice != null) cycles.add(MapEntry('three_year_price', threeYearPrice!));
    if (onetimePrice != null) cycles.add(MapEntry('onetime_price', onetimePrice!));
    return cycles;
  }
  
  /// Get cycle display name
  String getCycleName(String cycle) {
    switch (cycle) {
      case 'month_price': return '月付';
      case 'quarter_price': return '季付';
      case 'half_year_price': return '半年付';
      case 'year_price': return '年付';
      case 'two_year_price': return '兩年付';
      case 'three_year_price': return '三年付';
      case 'onetime_price': return '一次性';
      default: return cycle;
    }
  }
}

/// Order info
@freezed
abstract class V2BoardOrder with _$V2BoardOrder {
  const factory V2BoardOrder({
    @JsonKey(name: 'trade_no') String? tradeNo,
    @JsonKey(name: 'plan_id') int? planId,
    String? cycle,
    @JsonKey(name: 'total_amount') int? totalAmount,
    int? status,
    @JsonKey(name: 'created_at') int? createdAt,
    V2BoardPlan? plan,
  }) = _V2BoardOrder;

  factory V2BoardOrder.fromJson(Map<String, dynamic> json) =>
      _$V2BoardOrderFromJson(json);
}

extension V2BoardOrderExtension on V2BoardOrder {
  String get statusText {
    switch (status) {
      case 0:
        return '待支付';
      case 1:
        return '開通中';
      case 2:
        return '已取消';
      case 3:
        return '已完成';
      case 4:
        return '已折抵';
      default:
        return '未知';
    }
  }
  
  Color get statusColor {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.green;
      case 4:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

/// Subscription info
@freezed
abstract class V2BoardSubscription with _$V2BoardSubscription {
  const factory V2BoardSubscription({
    @JsonKey(name: 'subscribe_url') String? subscribeUrl,
    String? token,
    @JsonKey(name: 'plan') V2BoardPlan? plan,
    @JsonKey(name: 'u') int? uploadTraffic,
    @JsonKey(name: 'd') int? downloadTraffic,
    @JsonKey(name: 'transfer_enable') int? transferEnable,
    @JsonKey(name: 'expired_at') int? expiredAt,
  }) = _V2BoardSubscription;

  factory V2BoardSubscription.fromJson(Map<String, dynamic> json) =>
      _$V2BoardSubscriptionFromJson(json);
}

/// Notice/Announcement
@freezed
abstract class V2BoardNotice with _$V2BoardNotice {
  const factory V2BoardNotice({
    required int id,
    String? title,
    String? content,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'updated_at') int? updatedAt,
    String? imgUrl,
    List<String>? tags,
  }) = _V2BoardNotice;

  factory V2BoardNotice.fromJson(Map<String, dynamic> json) =>
      _$V2BoardNoticeFromJson(json);
}

extension V2BoardNoticeExtension on V2BoardNotice {
  DateTime? get createdDate {
    if (createdAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt! * 1000);
  }
}

/// Ticket status enum
enum TicketStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  processing,
  @JsonValue(2)
  closed,
  @JsonValue(3)
  replied,
}

/// Ticket
@freezed
abstract class V2BoardTicket with _$V2BoardTicket {
  const factory V2BoardTicket({
    required int id,
    String? subject,
    @JsonKey(name: 'level') int? priority,
    @JsonKey(name: 'status') int? statusCode,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'updated_at') int? updatedAt,
    @JsonKey(name: 'reply_status') int? replyStatus,
    List<V2BoardTicketMessage>? message,
  }) = _V2BoardTicket;

  factory V2BoardTicket.fromJson(Map<String, dynamic> json) =>
      _$V2BoardTicketFromJson(json);
}

extension V2BoardTicketExtension on V2BoardTicket {
  TicketStatus get status {
    switch (statusCode) {
      case 0:
        return TicketStatus.pending;
      case 1:
        return TicketStatus.processing;
      case 2:
        return TicketStatus.closed;
      case 3:
        return TicketStatus.replied;
      default:
        return TicketStatus.pending;
    }
  }

  String get statusText {
    switch (status) {
      case TicketStatus.pending:
        return '待处理';
      case TicketStatus.processing:
        return '处理中';
      case TicketStatus.closed:
        return '已关闭';
      case TicketStatus.replied:
        return '已回复';
    }
  }

  DateTime? get createdDate {
    if (createdAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt! * 1000);
  }
}

/// Ticket message
@freezed
abstract class V2BoardTicketMessage with _$V2BoardTicketMessage {
  const factory V2BoardTicketMessage({
    required int id,
    @JsonKey(name: 'ticket_id') int? ticketId,
    String? message,
    @JsonKey(name: 'is_me') bool? isMe,
    @JsonKey(name: 'created_at') int? createdAt,
  }) = _V2BoardTicketMessage;

  factory V2BoardTicketMessage.fromJson(Map<String, dynamic> json) =>
      _$V2BoardTicketMessageFromJson(json);
}

/// Auth response with token - simple class, no Freezed needed
class V2BoardAuthResponse {
  final String? authData;
  final String? token;
  
  V2BoardAuthResponse({this.authData, this.token});
  
  factory V2BoardAuthResponse.fromJson(Map<String, dynamic> json) {
    return V2BoardAuthResponse(
      authData: json['auth_data'] as String?,
      token: json['token'] as String?,
    );
  }
}
