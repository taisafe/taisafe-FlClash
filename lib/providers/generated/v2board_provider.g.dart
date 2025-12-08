// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../v2board_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted auth token

@ProviderFor(AuthToken)
const authTokenProvider = AuthTokenProvider._();

/// Persisted auth token
final class AuthTokenProvider extends $NotifierProvider<AuthToken, String?> {
  /// Persisted auth token
  const AuthTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenHash();

  @$internal
  @override
  AuthToken create() => AuthToken();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$authTokenHash() => r'a75db2ebeecaeea7001e2607c919e25e5550e5c3';

/// Persisted auth token

abstract class _$AuthToken extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Is user logged in

@ProviderFor(isLoggedIn)
const isLoggedInProvider = IsLoggedInProvider._();

/// Is user logged in

final class IsLoggedInProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Is user logged in
  const IsLoggedInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoggedInProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoggedInHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoggedIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoggedInHash() => r'0b2647fa776d14e74cbed32302be094e8fe5e711';

/// Current user info

@ProviderFor(CurrentUser)
const currentUserProvider = CurrentUserProvider._();

/// Current user info
final class CurrentUserProvider
    extends $NotifierProvider<CurrentUser, AsyncValue<V2BoardUser?>> {
  /// Current user info
  const CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  CurrentUser create() => CurrentUser();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<V2BoardUser?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<V2BoardUser?>>(value),
    );
  }
}

String _$currentUserHash() => r'06075c089f31849dcb9cb7c247c97857ef9d6f30';

/// Current user info

abstract class _$CurrentUser extends $Notifier<AsyncValue<V2BoardUser?>> {
  AsyncValue<V2BoardUser?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<V2BoardUser?>, AsyncValue<V2BoardUser?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<V2BoardUser?>, AsyncValue<V2BoardUser?>>,
              AsyncValue<V2BoardUser?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// User subscription info

@ProviderFor(UserSubscription)
const userSubscriptionProvider = UserSubscriptionProvider._();

/// User subscription info
final class UserSubscriptionProvider
    extends
        $NotifierProvider<UserSubscription, AsyncValue<V2BoardSubscription?>> {
  /// User subscription info
  const UserSubscriptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSubscriptionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSubscriptionHash();

  @$internal
  @override
  UserSubscription create() => UserSubscription();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<V2BoardSubscription?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<V2BoardSubscription?>>(
        value,
      ),
    );
  }
}

String _$userSubscriptionHash() => r'df1ce7352c53afee26c8dcb0a47a1ac7230d5d41';

/// User subscription info

abstract class _$UserSubscription
    extends $Notifier<AsyncValue<V2BoardSubscription?>> {
  AsyncValue<V2BoardSubscription?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<V2BoardSubscription?>,
              AsyncValue<V2BoardSubscription?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<V2BoardSubscription?>,
                AsyncValue<V2BoardSubscription?>
              >,
              AsyncValue<V2BoardSubscription?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notices/Announcements

@ProviderFor(Notices)
const noticesProvider = NoticesProvider._();

/// Notices/Announcements
final class NoticesProvider
    extends $NotifierProvider<Notices, AsyncValue<List<V2BoardNotice>>> {
  /// Notices/Announcements
  const NoticesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noticesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noticesHash();

  @$internal
  @override
  Notices create() => Notices();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<V2BoardNotice>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<V2BoardNotice>>>(
        value,
      ),
    );
  }
}

String _$noticesHash() => r'0242e82d03088abd2360df796d131d350adc8b64';

/// Notices/Announcements

abstract class _$Notices extends $Notifier<AsyncValue<List<V2BoardNotice>>> {
  AsyncValue<List<V2BoardNotice>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<V2BoardNotice>>,
              AsyncValue<List<V2BoardNotice>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<V2BoardNotice>>,
                AsyncValue<List<V2BoardNotice>>
              >,
              AsyncValue<List<V2BoardNotice>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// User tickets

@ProviderFor(Tickets)
const ticketsProvider = TicketsProvider._();

/// User tickets
final class TicketsProvider
    extends $NotifierProvider<Tickets, AsyncValue<List<V2BoardTicket>>> {
  /// User tickets
  const TicketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketsHash();

  @$internal
  @override
  Tickets create() => Tickets();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<V2BoardTicket>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<V2BoardTicket>>>(
        value,
      ),
    );
  }
}

String _$ticketsHash() => r'c7855c2f3abedd42ac86ffcfed476015fe001155';

/// User tickets

abstract class _$Tickets extends $Notifier<AsyncValue<List<V2BoardTicket>>> {
  AsyncValue<List<V2BoardTicket>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<V2BoardTicket>>,
              AsyncValue<List<V2BoardTicket>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<V2BoardTicket>>,
                AsyncValue<List<V2BoardTicket>>
              >,
              AsyncValue<List<V2BoardTicket>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Login action

@ProviderFor(LoginAction)
const loginActionProvider = LoginActionProvider._();

/// Login action
final class LoginActionProvider
    extends $NotifierProvider<LoginAction, AsyncValue<bool>> {
  /// Login action
  const LoginActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginActionHash();

  @$internal
  @override
  LoginAction create() => LoginAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<bool>>(value),
    );
  }
}

String _$loginActionHash() => r'41d30447738bfbdefe8ec75f723cd62d97c384f5';

/// Login action

abstract class _$LoginAction extends $Notifier<AsyncValue<bool>> {
  AsyncValue<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, AsyncValue<bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, AsyncValue<bool>>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Register action

@ProviderFor(RegisterAction)
const registerActionProvider = RegisterActionProvider._();

/// Register action
final class RegisterActionProvider
    extends $NotifierProvider<RegisterAction, AsyncValue<bool>> {
  /// Register action
  const RegisterActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerActionHash();

  @$internal
  @override
  RegisterAction create() => RegisterAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<bool>>(value),
    );
  }
}

String _$registerActionHash() => r'07f98a216af51fc9581c62b6a76652d56934f941';

/// Register action

abstract class _$RegisterAction extends $Notifier<AsyncValue<bool>> {
  AsyncValue<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, AsyncValue<bool>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, AsyncValue<bool>>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
