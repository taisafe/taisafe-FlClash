// V2Board API Models
// Data structures for V2Board API responses

import 'package:freezed_annotation/freezed_annotation.dart';

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
    int? groupId,
    @JsonKey(name: 'transfer_enable') int? transferEnable,
    @JsonKey(name: 'speed_limit') int? speedLimit,
  }) = _V2BoardPlan;

  factory V2BoardPlan.fromJson(Map<String, dynamic> json) =>
      _$V2BoardPlanFromJson(json);
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
