// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../v2board_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$V2BoardUser {

 int get id; String? get email;@JsonKey(name: 'transfer_enable') int? get transferEnable;@JsonKey(name: 'u') int? get uploadTraffic;@JsonKey(name: 'd') int? get downloadTraffic;@JsonKey(name: 'expired_at') int? get expiredAt;@JsonKey(name: 'plan_id') int? get planId;@JsonKey(name: 'uuid') String? get uuid;@JsonKey(name: 'avatar_url') String? get avatarUrl; V2BoardPlan? get plan;
/// Create a copy of V2BoardUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2BoardUserCopyWith<V2BoardUser> get copyWith => _$V2BoardUserCopyWithImpl<V2BoardUser>(this as V2BoardUser, _$identity);

  /// Serializes this V2BoardUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2BoardUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.uploadTraffic, uploadTraffic) || other.uploadTraffic == uploadTraffic)&&(identical(other.downloadTraffic, downloadTraffic) || other.downloadTraffic == downloadTraffic)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,transferEnable,uploadTraffic,downloadTraffic,expiredAt,planId,uuid,avatarUrl,plan);

@override
String toString() {
  return 'V2BoardUser(id: $id, email: $email, transferEnable: $transferEnable, uploadTraffic: $uploadTraffic, downloadTraffic: $downloadTraffic, expiredAt: $expiredAt, planId: $planId, uuid: $uuid, avatarUrl: $avatarUrl, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $V2BoardUserCopyWith<$Res>  {
  factory $V2BoardUserCopyWith(V2BoardUser value, $Res Function(V2BoardUser) _then) = _$V2BoardUserCopyWithImpl;
@useResult
$Res call({
 int id, String? email,@JsonKey(name: 'transfer_enable') int? transferEnable,@JsonKey(name: 'u') int? uploadTraffic,@JsonKey(name: 'd') int? downloadTraffic,@JsonKey(name: 'expired_at') int? expiredAt,@JsonKey(name: 'plan_id') int? planId,@JsonKey(name: 'uuid') String? uuid,@JsonKey(name: 'avatar_url') String? avatarUrl, V2BoardPlan? plan
});


$V2BoardPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class _$V2BoardUserCopyWithImpl<$Res>
    implements $V2BoardUserCopyWith<$Res> {
  _$V2BoardUserCopyWithImpl(this._self, this._then);

  final V2BoardUser _self;
  final $Res Function(V2BoardUser) _then;

/// Create a copy of V2BoardUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? transferEnable = freezed,Object? uploadTraffic = freezed,Object? downloadTraffic = freezed,Object? expiredAt = freezed,Object? planId = freezed,Object? uuid = freezed,Object? avatarUrl = freezed,Object? plan = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,transferEnable: freezed == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int?,uploadTraffic: freezed == uploadTraffic ? _self.uploadTraffic : uploadTraffic // ignore: cast_nullable_to_non_nullable
as int?,downloadTraffic: freezed == downloadTraffic ? _self.downloadTraffic : downloadTraffic // ignore: cast_nullable_to_non_nullable
as int?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as V2BoardPlan?,
  ));
}
/// Create a copy of V2BoardUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$V2BoardPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $V2BoardPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [V2BoardUser].
extension V2BoardUserPatterns on V2BoardUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2BoardUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2BoardUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2BoardUser value)  $default,){
final _that = this;
switch (_that) {
case _V2BoardUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2BoardUser value)?  $default,){
final _that = this;
switch (_that) {
case _V2BoardUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? email, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'u')  int? uploadTraffic, @JsonKey(name: 'd')  int? downloadTraffic, @JsonKey(name: 'expired_at')  int? expiredAt, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'uuid')  String? uuid, @JsonKey(name: 'avatar_url')  String? avatarUrl,  V2BoardPlan? plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2BoardUser() when $default != null:
return $default(_that.id,_that.email,_that.transferEnable,_that.uploadTraffic,_that.downloadTraffic,_that.expiredAt,_that.planId,_that.uuid,_that.avatarUrl,_that.plan);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? email, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'u')  int? uploadTraffic, @JsonKey(name: 'd')  int? downloadTraffic, @JsonKey(name: 'expired_at')  int? expiredAt, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'uuid')  String? uuid, @JsonKey(name: 'avatar_url')  String? avatarUrl,  V2BoardPlan? plan)  $default,) {final _that = this;
switch (_that) {
case _V2BoardUser():
return $default(_that.id,_that.email,_that.transferEnable,_that.uploadTraffic,_that.downloadTraffic,_that.expiredAt,_that.planId,_that.uuid,_that.avatarUrl,_that.plan);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? email, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'u')  int? uploadTraffic, @JsonKey(name: 'd')  int? downloadTraffic, @JsonKey(name: 'expired_at')  int? expiredAt, @JsonKey(name: 'plan_id')  int? planId, @JsonKey(name: 'uuid')  String? uuid, @JsonKey(name: 'avatar_url')  String? avatarUrl,  V2BoardPlan? plan)?  $default,) {final _that = this;
switch (_that) {
case _V2BoardUser() when $default != null:
return $default(_that.id,_that.email,_that.transferEnable,_that.uploadTraffic,_that.downloadTraffic,_that.expiredAt,_that.planId,_that.uuid,_that.avatarUrl,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2BoardUser implements V2BoardUser {
  const _V2BoardUser({this.id = 0, this.email, @JsonKey(name: 'transfer_enable') this.transferEnable, @JsonKey(name: 'u') this.uploadTraffic, @JsonKey(name: 'd') this.downloadTraffic, @JsonKey(name: 'expired_at') this.expiredAt, @JsonKey(name: 'plan_id') this.planId, @JsonKey(name: 'uuid') this.uuid, @JsonKey(name: 'avatar_url') this.avatarUrl, this.plan});
  factory _V2BoardUser.fromJson(Map<String, dynamic> json) => _$V2BoardUserFromJson(json);

@override@JsonKey() final  int id;
@override final  String? email;
@override@JsonKey(name: 'transfer_enable') final  int? transferEnable;
@override@JsonKey(name: 'u') final  int? uploadTraffic;
@override@JsonKey(name: 'd') final  int? downloadTraffic;
@override@JsonKey(name: 'expired_at') final  int? expiredAt;
@override@JsonKey(name: 'plan_id') final  int? planId;
@override@JsonKey(name: 'uuid') final  String? uuid;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override final  V2BoardPlan? plan;

/// Create a copy of V2BoardUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2BoardUserCopyWith<_V2BoardUser> get copyWith => __$V2BoardUserCopyWithImpl<_V2BoardUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2BoardUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2BoardUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.uploadTraffic, uploadTraffic) || other.uploadTraffic == uploadTraffic)&&(identical(other.downloadTraffic, downloadTraffic) || other.downloadTraffic == downloadTraffic)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,transferEnable,uploadTraffic,downloadTraffic,expiredAt,planId,uuid,avatarUrl,plan);

@override
String toString() {
  return 'V2BoardUser(id: $id, email: $email, transferEnable: $transferEnable, uploadTraffic: $uploadTraffic, downloadTraffic: $downloadTraffic, expiredAt: $expiredAt, planId: $planId, uuid: $uuid, avatarUrl: $avatarUrl, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$V2BoardUserCopyWith<$Res> implements $V2BoardUserCopyWith<$Res> {
  factory _$V2BoardUserCopyWith(_V2BoardUser value, $Res Function(_V2BoardUser) _then) = __$V2BoardUserCopyWithImpl;
@override @useResult
$Res call({
 int id, String? email,@JsonKey(name: 'transfer_enable') int? transferEnable,@JsonKey(name: 'u') int? uploadTraffic,@JsonKey(name: 'd') int? downloadTraffic,@JsonKey(name: 'expired_at') int? expiredAt,@JsonKey(name: 'plan_id') int? planId,@JsonKey(name: 'uuid') String? uuid,@JsonKey(name: 'avatar_url') String? avatarUrl, V2BoardPlan? plan
});


@override $V2BoardPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class __$V2BoardUserCopyWithImpl<$Res>
    implements _$V2BoardUserCopyWith<$Res> {
  __$V2BoardUserCopyWithImpl(this._self, this._then);

  final _V2BoardUser _self;
  final $Res Function(_V2BoardUser) _then;

/// Create a copy of V2BoardUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? transferEnable = freezed,Object? uploadTraffic = freezed,Object? downloadTraffic = freezed,Object? expiredAt = freezed,Object? planId = freezed,Object? uuid = freezed,Object? avatarUrl = freezed,Object? plan = freezed,}) {
  return _then(_V2BoardUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,transferEnable: freezed == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int?,uploadTraffic: freezed == uploadTraffic ? _self.uploadTraffic : uploadTraffic // ignore: cast_nullable_to_non_nullable
as int?,downloadTraffic: freezed == downloadTraffic ? _self.downloadTraffic : downloadTraffic // ignore: cast_nullable_to_non_nullable
as int?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as V2BoardPlan?,
  ));
}

/// Create a copy of V2BoardUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$V2BoardPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $V2BoardPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// @nodoc
mixin _$V2BoardPlan {

 int get id; String? get name; int? get groupId;@JsonKey(name: 'transfer_enable') int? get transferEnable;@JsonKey(name: 'speed_limit') int? get speedLimit;
/// Create a copy of V2BoardPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2BoardPlanCopyWith<V2BoardPlan> get copyWith => _$V2BoardPlanCopyWithImpl<V2BoardPlan>(this as V2BoardPlan, _$identity);

  /// Serializes this V2BoardPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2BoardPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.speedLimit, speedLimit) || other.speedLimit == speedLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,groupId,transferEnable,speedLimit);

@override
String toString() {
  return 'V2BoardPlan(id: $id, name: $name, groupId: $groupId, transferEnable: $transferEnable, speedLimit: $speedLimit)';
}


}

/// @nodoc
abstract mixin class $V2BoardPlanCopyWith<$Res>  {
  factory $V2BoardPlanCopyWith(V2BoardPlan value, $Res Function(V2BoardPlan) _then) = _$V2BoardPlanCopyWithImpl;
@useResult
$Res call({
 int id, String? name, int? groupId,@JsonKey(name: 'transfer_enable') int? transferEnable,@JsonKey(name: 'speed_limit') int? speedLimit
});




}
/// @nodoc
class _$V2BoardPlanCopyWithImpl<$Res>
    implements $V2BoardPlanCopyWith<$Res> {
  _$V2BoardPlanCopyWithImpl(this._self, this._then);

  final V2BoardPlan _self;
  final $Res Function(V2BoardPlan) _then;

/// Create a copy of V2BoardPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? groupId = freezed,Object? transferEnable = freezed,Object? speedLimit = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,transferEnable: freezed == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int?,speedLimit: freezed == speedLimit ? _self.speedLimit : speedLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [V2BoardPlan].
extension V2BoardPlanPatterns on V2BoardPlan {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2BoardPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2BoardPlan() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2BoardPlan value)  $default,){
final _that = this;
switch (_that) {
case _V2BoardPlan():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2BoardPlan value)?  $default,){
final _that = this;
switch (_that) {
case _V2BoardPlan() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  int? groupId, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'speed_limit')  int? speedLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2BoardPlan() when $default != null:
return $default(_that.id,_that.name,_that.groupId,_that.transferEnable,_that.speedLimit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  int? groupId, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'speed_limit')  int? speedLimit)  $default,) {final _that = this;
switch (_that) {
case _V2BoardPlan():
return $default(_that.id,_that.name,_that.groupId,_that.transferEnable,_that.speedLimit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  int? groupId, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'speed_limit')  int? speedLimit)?  $default,) {final _that = this;
switch (_that) {
case _V2BoardPlan() when $default != null:
return $default(_that.id,_that.name,_that.groupId,_that.transferEnable,_that.speedLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2BoardPlan implements V2BoardPlan {
  const _V2BoardPlan({required this.id, this.name, this.groupId, @JsonKey(name: 'transfer_enable') this.transferEnable, @JsonKey(name: 'speed_limit') this.speedLimit});
  factory _V2BoardPlan.fromJson(Map<String, dynamic> json) => _$V2BoardPlanFromJson(json);

@override final  int id;
@override final  String? name;
@override final  int? groupId;
@override@JsonKey(name: 'transfer_enable') final  int? transferEnable;
@override@JsonKey(name: 'speed_limit') final  int? speedLimit;

/// Create a copy of V2BoardPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2BoardPlanCopyWith<_V2BoardPlan> get copyWith => __$V2BoardPlanCopyWithImpl<_V2BoardPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2BoardPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2BoardPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.speedLimit, speedLimit) || other.speedLimit == speedLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,groupId,transferEnable,speedLimit);

@override
String toString() {
  return 'V2BoardPlan(id: $id, name: $name, groupId: $groupId, transferEnable: $transferEnable, speedLimit: $speedLimit)';
}


}

/// @nodoc
abstract mixin class _$V2BoardPlanCopyWith<$Res> implements $V2BoardPlanCopyWith<$Res> {
  factory _$V2BoardPlanCopyWith(_V2BoardPlan value, $Res Function(_V2BoardPlan) _then) = __$V2BoardPlanCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, int? groupId,@JsonKey(name: 'transfer_enable') int? transferEnable,@JsonKey(name: 'speed_limit') int? speedLimit
});




}
/// @nodoc
class __$V2BoardPlanCopyWithImpl<$Res>
    implements _$V2BoardPlanCopyWith<$Res> {
  __$V2BoardPlanCopyWithImpl(this._self, this._then);

  final _V2BoardPlan _self;
  final $Res Function(_V2BoardPlan) _then;

/// Create a copy of V2BoardPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? groupId = freezed,Object? transferEnable = freezed,Object? speedLimit = freezed,}) {
  return _then(_V2BoardPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,transferEnable: freezed == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int?,speedLimit: freezed == speedLimit ? _self.speedLimit : speedLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$V2BoardSubscription {

@JsonKey(name: 'subscribe_url') String? get subscribeUrl; String? get token;@JsonKey(name: 'plan') V2BoardPlan? get plan;@JsonKey(name: 'u') int? get uploadTraffic;@JsonKey(name: 'd') int? get downloadTraffic;@JsonKey(name: 'transfer_enable') int? get transferEnable;@JsonKey(name: 'expired_at') int? get expiredAt;
/// Create a copy of V2BoardSubscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2BoardSubscriptionCopyWith<V2BoardSubscription> get copyWith => _$V2BoardSubscriptionCopyWithImpl<V2BoardSubscription>(this as V2BoardSubscription, _$identity);

  /// Serializes this V2BoardSubscription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2BoardSubscription&&(identical(other.subscribeUrl, subscribeUrl) || other.subscribeUrl == subscribeUrl)&&(identical(other.token, token) || other.token == token)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.uploadTraffic, uploadTraffic) || other.uploadTraffic == uploadTraffic)&&(identical(other.downloadTraffic, downloadTraffic) || other.downloadTraffic == downloadTraffic)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscribeUrl,token,plan,uploadTraffic,downloadTraffic,transferEnable,expiredAt);

@override
String toString() {
  return 'V2BoardSubscription(subscribeUrl: $subscribeUrl, token: $token, plan: $plan, uploadTraffic: $uploadTraffic, downloadTraffic: $downloadTraffic, transferEnable: $transferEnable, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class $V2BoardSubscriptionCopyWith<$Res>  {
  factory $V2BoardSubscriptionCopyWith(V2BoardSubscription value, $Res Function(V2BoardSubscription) _then) = _$V2BoardSubscriptionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subscribe_url') String? subscribeUrl, String? token,@JsonKey(name: 'plan') V2BoardPlan? plan,@JsonKey(name: 'u') int? uploadTraffic,@JsonKey(name: 'd') int? downloadTraffic,@JsonKey(name: 'transfer_enable') int? transferEnable,@JsonKey(name: 'expired_at') int? expiredAt
});


$V2BoardPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class _$V2BoardSubscriptionCopyWithImpl<$Res>
    implements $V2BoardSubscriptionCopyWith<$Res> {
  _$V2BoardSubscriptionCopyWithImpl(this._self, this._then);

  final V2BoardSubscription _self;
  final $Res Function(V2BoardSubscription) _then;

/// Create a copy of V2BoardSubscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscribeUrl = freezed,Object? token = freezed,Object? plan = freezed,Object? uploadTraffic = freezed,Object? downloadTraffic = freezed,Object? transferEnable = freezed,Object? expiredAt = freezed,}) {
  return _then(_self.copyWith(
subscribeUrl: freezed == subscribeUrl ? _self.subscribeUrl : subscribeUrl // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as V2BoardPlan?,uploadTraffic: freezed == uploadTraffic ? _self.uploadTraffic : uploadTraffic // ignore: cast_nullable_to_non_nullable
as int?,downloadTraffic: freezed == downloadTraffic ? _self.downloadTraffic : downloadTraffic // ignore: cast_nullable_to_non_nullable
as int?,transferEnable: freezed == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of V2BoardSubscription
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$V2BoardPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $V2BoardPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [V2BoardSubscription].
extension V2BoardSubscriptionPatterns on V2BoardSubscription {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2BoardSubscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2BoardSubscription() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2BoardSubscription value)  $default,){
final _that = this;
switch (_that) {
case _V2BoardSubscription():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2BoardSubscription value)?  $default,){
final _that = this;
switch (_that) {
case _V2BoardSubscription() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'subscribe_url')  String? subscribeUrl,  String? token, @JsonKey(name: 'plan')  V2BoardPlan? plan, @JsonKey(name: 'u')  int? uploadTraffic, @JsonKey(name: 'd')  int? downloadTraffic, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'expired_at')  int? expiredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2BoardSubscription() when $default != null:
return $default(_that.subscribeUrl,_that.token,_that.plan,_that.uploadTraffic,_that.downloadTraffic,_that.transferEnable,_that.expiredAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'subscribe_url')  String? subscribeUrl,  String? token, @JsonKey(name: 'plan')  V2BoardPlan? plan, @JsonKey(name: 'u')  int? uploadTraffic, @JsonKey(name: 'd')  int? downloadTraffic, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'expired_at')  int? expiredAt)  $default,) {final _that = this;
switch (_that) {
case _V2BoardSubscription():
return $default(_that.subscribeUrl,_that.token,_that.plan,_that.uploadTraffic,_that.downloadTraffic,_that.transferEnable,_that.expiredAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'subscribe_url')  String? subscribeUrl,  String? token, @JsonKey(name: 'plan')  V2BoardPlan? plan, @JsonKey(name: 'u')  int? uploadTraffic, @JsonKey(name: 'd')  int? downloadTraffic, @JsonKey(name: 'transfer_enable')  int? transferEnable, @JsonKey(name: 'expired_at')  int? expiredAt)?  $default,) {final _that = this;
switch (_that) {
case _V2BoardSubscription() when $default != null:
return $default(_that.subscribeUrl,_that.token,_that.plan,_that.uploadTraffic,_that.downloadTraffic,_that.transferEnable,_that.expiredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2BoardSubscription implements V2BoardSubscription {
  const _V2BoardSubscription({@JsonKey(name: 'subscribe_url') this.subscribeUrl, this.token, @JsonKey(name: 'plan') this.plan, @JsonKey(name: 'u') this.uploadTraffic, @JsonKey(name: 'd') this.downloadTraffic, @JsonKey(name: 'transfer_enable') this.transferEnable, @JsonKey(name: 'expired_at') this.expiredAt});
  factory _V2BoardSubscription.fromJson(Map<String, dynamic> json) => _$V2BoardSubscriptionFromJson(json);

@override@JsonKey(name: 'subscribe_url') final  String? subscribeUrl;
@override final  String? token;
@override@JsonKey(name: 'plan') final  V2BoardPlan? plan;
@override@JsonKey(name: 'u') final  int? uploadTraffic;
@override@JsonKey(name: 'd') final  int? downloadTraffic;
@override@JsonKey(name: 'transfer_enable') final  int? transferEnable;
@override@JsonKey(name: 'expired_at') final  int? expiredAt;

/// Create a copy of V2BoardSubscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2BoardSubscriptionCopyWith<_V2BoardSubscription> get copyWith => __$V2BoardSubscriptionCopyWithImpl<_V2BoardSubscription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2BoardSubscriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2BoardSubscription&&(identical(other.subscribeUrl, subscribeUrl) || other.subscribeUrl == subscribeUrl)&&(identical(other.token, token) || other.token == token)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.uploadTraffic, uploadTraffic) || other.uploadTraffic == uploadTraffic)&&(identical(other.downloadTraffic, downloadTraffic) || other.downloadTraffic == downloadTraffic)&&(identical(other.transferEnable, transferEnable) || other.transferEnable == transferEnable)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscribeUrl,token,plan,uploadTraffic,downloadTraffic,transferEnable,expiredAt);

@override
String toString() {
  return 'V2BoardSubscription(subscribeUrl: $subscribeUrl, token: $token, plan: $plan, uploadTraffic: $uploadTraffic, downloadTraffic: $downloadTraffic, transferEnable: $transferEnable, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$V2BoardSubscriptionCopyWith<$Res> implements $V2BoardSubscriptionCopyWith<$Res> {
  factory _$V2BoardSubscriptionCopyWith(_V2BoardSubscription value, $Res Function(_V2BoardSubscription) _then) = __$V2BoardSubscriptionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subscribe_url') String? subscribeUrl, String? token,@JsonKey(name: 'plan') V2BoardPlan? plan,@JsonKey(name: 'u') int? uploadTraffic,@JsonKey(name: 'd') int? downloadTraffic,@JsonKey(name: 'transfer_enable') int? transferEnable,@JsonKey(name: 'expired_at') int? expiredAt
});


@override $V2BoardPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class __$V2BoardSubscriptionCopyWithImpl<$Res>
    implements _$V2BoardSubscriptionCopyWith<$Res> {
  __$V2BoardSubscriptionCopyWithImpl(this._self, this._then);

  final _V2BoardSubscription _self;
  final $Res Function(_V2BoardSubscription) _then;

/// Create a copy of V2BoardSubscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subscribeUrl = freezed,Object? token = freezed,Object? plan = freezed,Object? uploadTraffic = freezed,Object? downloadTraffic = freezed,Object? transferEnable = freezed,Object? expiredAt = freezed,}) {
  return _then(_V2BoardSubscription(
subscribeUrl: freezed == subscribeUrl ? _self.subscribeUrl : subscribeUrl // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as V2BoardPlan?,uploadTraffic: freezed == uploadTraffic ? _self.uploadTraffic : uploadTraffic // ignore: cast_nullable_to_non_nullable
as int?,downloadTraffic: freezed == downloadTraffic ? _self.downloadTraffic : downloadTraffic // ignore: cast_nullable_to_non_nullable
as int?,transferEnable: freezed == transferEnable ? _self.transferEnable : transferEnable // ignore: cast_nullable_to_non_nullable
as int?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of V2BoardSubscription
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$V2BoardPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $V2BoardPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// @nodoc
mixin _$V2BoardNotice {

 int get id; String? get title; String? get content;@JsonKey(name: 'created_at') int? get createdAt;@JsonKey(name: 'updated_at') int? get updatedAt; String? get imgUrl; List<String>? get tags;
/// Create a copy of V2BoardNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2BoardNoticeCopyWith<V2BoardNotice> get copyWith => _$V2BoardNoticeCopyWithImpl<V2BoardNotice>(this as V2BoardNotice, _$identity);

  /// Serializes this V2BoardNotice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2BoardNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt,updatedAt,imgUrl,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'V2BoardNotice(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, imgUrl: $imgUrl, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $V2BoardNoticeCopyWith<$Res>  {
  factory $V2BoardNoticeCopyWith(V2BoardNotice value, $Res Function(V2BoardNotice) _then) = _$V2BoardNoticeCopyWithImpl;
@useResult
$Res call({
 int id, String? title, String? content,@JsonKey(name: 'created_at') int? createdAt,@JsonKey(name: 'updated_at') int? updatedAt, String? imgUrl, List<String>? tags
});




}
/// @nodoc
class _$V2BoardNoticeCopyWithImpl<$Res>
    implements $V2BoardNoticeCopyWith<$Res> {
  _$V2BoardNoticeCopyWithImpl(this._self, this._then);

  final V2BoardNotice _self;
  final $Res Function(V2BoardNotice) _then;

/// Create a copy of V2BoardNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? content = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? imgUrl = freezed,Object? tags = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int?,imgUrl: freezed == imgUrl ? _self.imgUrl : imgUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [V2BoardNotice].
extension V2BoardNoticePatterns on V2BoardNotice {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2BoardNotice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2BoardNotice() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2BoardNotice value)  $default,){
final _that = this;
switch (_that) {
case _V2BoardNotice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2BoardNotice value)?  $default,){
final _that = this;
switch (_that) {
case _V2BoardNotice() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? title,  String? content, @JsonKey(name: 'created_at')  int? createdAt, @JsonKey(name: 'updated_at')  int? updatedAt,  String? imgUrl,  List<String>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2BoardNotice() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.imgUrl,_that.tags);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? title,  String? content, @JsonKey(name: 'created_at')  int? createdAt, @JsonKey(name: 'updated_at')  int? updatedAt,  String? imgUrl,  List<String>? tags)  $default,) {final _that = this;
switch (_that) {
case _V2BoardNotice():
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.imgUrl,_that.tags);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? title,  String? content, @JsonKey(name: 'created_at')  int? createdAt, @JsonKey(name: 'updated_at')  int? updatedAt,  String? imgUrl,  List<String>? tags)?  $default,) {final _that = this;
switch (_that) {
case _V2BoardNotice() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.imgUrl,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2BoardNotice implements V2BoardNotice {
  const _V2BoardNotice({required this.id, this.title, this.content, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, this.imgUrl, final  List<String>? tags}): _tags = tags;
  factory _V2BoardNotice.fromJson(Map<String, dynamic> json) => _$V2BoardNoticeFromJson(json);

@override final  int id;
@override final  String? title;
@override final  String? content;
@override@JsonKey(name: 'created_at') final  int? createdAt;
@override@JsonKey(name: 'updated_at') final  int? updatedAt;
@override final  String? imgUrl;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of V2BoardNotice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2BoardNoticeCopyWith<_V2BoardNotice> get copyWith => __$V2BoardNoticeCopyWithImpl<_V2BoardNotice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2BoardNoticeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2BoardNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt,updatedAt,imgUrl,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'V2BoardNotice(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, imgUrl: $imgUrl, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$V2BoardNoticeCopyWith<$Res> implements $V2BoardNoticeCopyWith<$Res> {
  factory _$V2BoardNoticeCopyWith(_V2BoardNotice value, $Res Function(_V2BoardNotice) _then) = __$V2BoardNoticeCopyWithImpl;
@override @useResult
$Res call({
 int id, String? title, String? content,@JsonKey(name: 'created_at') int? createdAt,@JsonKey(name: 'updated_at') int? updatedAt, String? imgUrl, List<String>? tags
});




}
/// @nodoc
class __$V2BoardNoticeCopyWithImpl<$Res>
    implements _$V2BoardNoticeCopyWith<$Res> {
  __$V2BoardNoticeCopyWithImpl(this._self, this._then);

  final _V2BoardNotice _self;
  final $Res Function(_V2BoardNotice) _then;

/// Create a copy of V2BoardNotice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? content = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? imgUrl = freezed,Object? tags = freezed,}) {
  return _then(_V2BoardNotice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int?,imgUrl: freezed == imgUrl ? _self.imgUrl : imgUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$V2BoardTicket {

 int get id; String? get subject;@JsonKey(name: 'level') int? get priority;@JsonKey(name: 'status') int? get statusCode;@JsonKey(name: 'created_at') int? get createdAt;@JsonKey(name: 'updated_at') int? get updatedAt;@JsonKey(name: 'reply_status') int? get replyStatus; List<V2BoardTicketMessage>? get message;
/// Create a copy of V2BoardTicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2BoardTicketCopyWith<V2BoardTicket> get copyWith => _$V2BoardTicketCopyWithImpl<V2BoardTicket>(this as V2BoardTicket, _$identity);

  /// Serializes this V2BoardTicket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2BoardTicket&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.replyStatus, replyStatus) || other.replyStatus == replyStatus)&&const DeepCollectionEquality().equals(other.message, message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,priority,statusCode,createdAt,updatedAt,replyStatus,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'V2BoardTicket(id: $id, subject: $subject, priority: $priority, statusCode: $statusCode, createdAt: $createdAt, updatedAt: $updatedAt, replyStatus: $replyStatus, message: $message)';
}


}

/// @nodoc
abstract mixin class $V2BoardTicketCopyWith<$Res>  {
  factory $V2BoardTicketCopyWith(V2BoardTicket value, $Res Function(V2BoardTicket) _then) = _$V2BoardTicketCopyWithImpl;
@useResult
$Res call({
 int id, String? subject,@JsonKey(name: 'level') int? priority,@JsonKey(name: 'status') int? statusCode,@JsonKey(name: 'created_at') int? createdAt,@JsonKey(name: 'updated_at') int? updatedAt,@JsonKey(name: 'reply_status') int? replyStatus, List<V2BoardTicketMessage>? message
});




}
/// @nodoc
class _$V2BoardTicketCopyWithImpl<$Res>
    implements $V2BoardTicketCopyWith<$Res> {
  _$V2BoardTicketCopyWithImpl(this._self, this._then);

  final V2BoardTicket _self;
  final $Res Function(V2BoardTicket) _then;

/// Create a copy of V2BoardTicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = freezed,Object? priority = freezed,Object? statusCode = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? replyStatus = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int?,replyStatus: freezed == replyStatus ? _self.replyStatus : replyStatus // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as List<V2BoardTicketMessage>?,
  ));
}

}


/// Adds pattern-matching-related methods to [V2BoardTicket].
extension V2BoardTicketPatterns on V2BoardTicket {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2BoardTicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2BoardTicket() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2BoardTicket value)  $default,){
final _that = this;
switch (_that) {
case _V2BoardTicket():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2BoardTicket value)?  $default,){
final _that = this;
switch (_that) {
case _V2BoardTicket() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? subject, @JsonKey(name: 'level')  int? priority, @JsonKey(name: 'status')  int? statusCode, @JsonKey(name: 'created_at')  int? createdAt, @JsonKey(name: 'updated_at')  int? updatedAt, @JsonKey(name: 'reply_status')  int? replyStatus,  List<V2BoardTicketMessage>? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2BoardTicket() when $default != null:
return $default(_that.id,_that.subject,_that.priority,_that.statusCode,_that.createdAt,_that.updatedAt,_that.replyStatus,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? subject, @JsonKey(name: 'level')  int? priority, @JsonKey(name: 'status')  int? statusCode, @JsonKey(name: 'created_at')  int? createdAt, @JsonKey(name: 'updated_at')  int? updatedAt, @JsonKey(name: 'reply_status')  int? replyStatus,  List<V2BoardTicketMessage>? message)  $default,) {final _that = this;
switch (_that) {
case _V2BoardTicket():
return $default(_that.id,_that.subject,_that.priority,_that.statusCode,_that.createdAt,_that.updatedAt,_that.replyStatus,_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? subject, @JsonKey(name: 'level')  int? priority, @JsonKey(name: 'status')  int? statusCode, @JsonKey(name: 'created_at')  int? createdAt, @JsonKey(name: 'updated_at')  int? updatedAt, @JsonKey(name: 'reply_status')  int? replyStatus,  List<V2BoardTicketMessage>? message)?  $default,) {final _that = this;
switch (_that) {
case _V2BoardTicket() when $default != null:
return $default(_that.id,_that.subject,_that.priority,_that.statusCode,_that.createdAt,_that.updatedAt,_that.replyStatus,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2BoardTicket implements V2BoardTicket {
  const _V2BoardTicket({required this.id, this.subject, @JsonKey(name: 'level') this.priority, @JsonKey(name: 'status') this.statusCode, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'reply_status') this.replyStatus, final  List<V2BoardTicketMessage>? message}): _message = message;
  factory _V2BoardTicket.fromJson(Map<String, dynamic> json) => _$V2BoardTicketFromJson(json);

@override final  int id;
@override final  String? subject;
@override@JsonKey(name: 'level') final  int? priority;
@override@JsonKey(name: 'status') final  int? statusCode;
@override@JsonKey(name: 'created_at') final  int? createdAt;
@override@JsonKey(name: 'updated_at') final  int? updatedAt;
@override@JsonKey(name: 'reply_status') final  int? replyStatus;
 final  List<V2BoardTicketMessage>? _message;
@override List<V2BoardTicketMessage>? get message {
  final value = _message;
  if (value == null) return null;
  if (_message is EqualUnmodifiableListView) return _message;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of V2BoardTicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2BoardTicketCopyWith<_V2BoardTicket> get copyWith => __$V2BoardTicketCopyWithImpl<_V2BoardTicket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2BoardTicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2BoardTicket&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.replyStatus, replyStatus) || other.replyStatus == replyStatus)&&const DeepCollectionEquality().equals(other._message, _message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,priority,statusCode,createdAt,updatedAt,replyStatus,const DeepCollectionEquality().hash(_message));

@override
String toString() {
  return 'V2BoardTicket(id: $id, subject: $subject, priority: $priority, statusCode: $statusCode, createdAt: $createdAt, updatedAt: $updatedAt, replyStatus: $replyStatus, message: $message)';
}


}

/// @nodoc
abstract mixin class _$V2BoardTicketCopyWith<$Res> implements $V2BoardTicketCopyWith<$Res> {
  factory _$V2BoardTicketCopyWith(_V2BoardTicket value, $Res Function(_V2BoardTicket) _then) = __$V2BoardTicketCopyWithImpl;
@override @useResult
$Res call({
 int id, String? subject,@JsonKey(name: 'level') int? priority,@JsonKey(name: 'status') int? statusCode,@JsonKey(name: 'created_at') int? createdAt,@JsonKey(name: 'updated_at') int? updatedAt,@JsonKey(name: 'reply_status') int? replyStatus, List<V2BoardTicketMessage>? message
});




}
/// @nodoc
class __$V2BoardTicketCopyWithImpl<$Res>
    implements _$V2BoardTicketCopyWith<$Res> {
  __$V2BoardTicketCopyWithImpl(this._self, this._then);

  final _V2BoardTicket _self;
  final $Res Function(_V2BoardTicket) _then;

/// Create a copy of V2BoardTicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = freezed,Object? priority = freezed,Object? statusCode = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? replyStatus = freezed,Object? message = freezed,}) {
  return _then(_V2BoardTicket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int?,replyStatus: freezed == replyStatus ? _self.replyStatus : replyStatus // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self._message : message // ignore: cast_nullable_to_non_nullable
as List<V2BoardTicketMessage>?,
  ));
}


}


/// @nodoc
mixin _$V2BoardTicketMessage {

 int get id;@JsonKey(name: 'ticket_id') int? get ticketId; String? get message;@JsonKey(name: 'is_me') bool? get isMe;@JsonKey(name: 'created_at') int? get createdAt;
/// Create a copy of V2BoardTicketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2BoardTicketMessageCopyWith<V2BoardTicketMessage> get copyWith => _$V2BoardTicketMessageCopyWithImpl<V2BoardTicketMessage>(this as V2BoardTicketMessage, _$identity);

  /// Serializes this V2BoardTicketMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2BoardTicketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.message, message) || other.message == message)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketId,message,isMe,createdAt);

@override
String toString() {
  return 'V2BoardTicketMessage(id: $id, ticketId: $ticketId, message: $message, isMe: $isMe, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $V2BoardTicketMessageCopyWith<$Res>  {
  factory $V2BoardTicketMessageCopyWith(V2BoardTicketMessage value, $Res Function(V2BoardTicketMessage) _then) = _$V2BoardTicketMessageCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'ticket_id') int? ticketId, String? message,@JsonKey(name: 'is_me') bool? isMe,@JsonKey(name: 'created_at') int? createdAt
});




}
/// @nodoc
class _$V2BoardTicketMessageCopyWithImpl<$Res>
    implements $V2BoardTicketMessageCopyWith<$Res> {
  _$V2BoardTicketMessageCopyWithImpl(this._self, this._then);

  final V2BoardTicketMessage _self;
  final $Res Function(V2BoardTicketMessage) _then;

/// Create a copy of V2BoardTicketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketId = freezed,Object? message = freezed,Object? isMe = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketId: freezed == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,isMe: freezed == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [V2BoardTicketMessage].
extension V2BoardTicketMessagePatterns on V2BoardTicketMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2BoardTicketMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2BoardTicketMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2BoardTicketMessage value)  $default,){
final _that = this;
switch (_that) {
case _V2BoardTicketMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2BoardTicketMessage value)?  $default,){
final _that = this;
switch (_that) {
case _V2BoardTicketMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_id')  int? ticketId,  String? message, @JsonKey(name: 'is_me')  bool? isMe, @JsonKey(name: 'created_at')  int? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2BoardTicketMessage() when $default != null:
return $default(_that.id,_that.ticketId,_that.message,_that.isMe,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_id')  int? ticketId,  String? message, @JsonKey(name: 'is_me')  bool? isMe, @JsonKey(name: 'created_at')  int? createdAt)  $default,) {final _that = this;
switch (_that) {
case _V2BoardTicketMessage():
return $default(_that.id,_that.ticketId,_that.message,_that.isMe,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'ticket_id')  int? ticketId,  String? message, @JsonKey(name: 'is_me')  bool? isMe, @JsonKey(name: 'created_at')  int? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _V2BoardTicketMessage() when $default != null:
return $default(_that.id,_that.ticketId,_that.message,_that.isMe,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2BoardTicketMessage implements V2BoardTicketMessage {
  const _V2BoardTicketMessage({required this.id, @JsonKey(name: 'ticket_id') this.ticketId, this.message, @JsonKey(name: 'is_me') this.isMe, @JsonKey(name: 'created_at') this.createdAt});
  factory _V2BoardTicketMessage.fromJson(Map<String, dynamic> json) => _$V2BoardTicketMessageFromJson(json);

@override final  int id;
@override@JsonKey(name: 'ticket_id') final  int? ticketId;
@override final  String? message;
@override@JsonKey(name: 'is_me') final  bool? isMe;
@override@JsonKey(name: 'created_at') final  int? createdAt;

/// Create a copy of V2BoardTicketMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2BoardTicketMessageCopyWith<_V2BoardTicketMessage> get copyWith => __$V2BoardTicketMessageCopyWithImpl<_V2BoardTicketMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2BoardTicketMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2BoardTicketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.message, message) || other.message == message)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketId,message,isMe,createdAt);

@override
String toString() {
  return 'V2BoardTicketMessage(id: $id, ticketId: $ticketId, message: $message, isMe: $isMe, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$V2BoardTicketMessageCopyWith<$Res> implements $V2BoardTicketMessageCopyWith<$Res> {
  factory _$V2BoardTicketMessageCopyWith(_V2BoardTicketMessage value, $Res Function(_V2BoardTicketMessage) _then) = __$V2BoardTicketMessageCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'ticket_id') int? ticketId, String? message,@JsonKey(name: 'is_me') bool? isMe,@JsonKey(name: 'created_at') int? createdAt
});




}
/// @nodoc
class __$V2BoardTicketMessageCopyWithImpl<$Res>
    implements _$V2BoardTicketMessageCopyWith<$Res> {
  __$V2BoardTicketMessageCopyWithImpl(this._self, this._then);

  final _V2BoardTicketMessage _self;
  final $Res Function(_V2BoardTicketMessage) _then;

/// Create a copy of V2BoardTicketMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketId = freezed,Object? message = freezed,Object? isMe = freezed,Object? createdAt = freezed,}) {
  return _then(_V2BoardTicketMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketId: freezed == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,isMe: freezed == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
