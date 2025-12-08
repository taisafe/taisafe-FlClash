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

/// Available plans

@ProviderFor(Plans)
const plansProvider = PlansProvider._();

/// Available plans
final class PlansProvider
    extends $NotifierProvider<Plans, AsyncValue<List<V2BoardPlan>>> {
  /// Available plans
  const PlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansHash();

  @$internal
  @override
  Plans create() => Plans();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<V2BoardPlan>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<V2BoardPlan>>>(
        value,
      ),
    );
  }
}

String _$plansHash() => r'f995d693deb5b7876a09a3d8822506c7d0ae7ae5';

/// Available plans

abstract class _$Plans extends $Notifier<AsyncValue<List<V2BoardPlan>>> {
  AsyncValue<List<V2BoardPlan>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<V2BoardPlan>>,
              AsyncValue<List<V2BoardPlan>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<V2BoardPlan>>,
                AsyncValue<List<V2BoardPlan>>
              >,
              AsyncValue<List<V2BoardPlan>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Gift card redemption action

@ProviderFor(RedeemGiftCard)
const redeemGiftCardProvider = RedeemGiftCardProvider._();

/// Gift card redemption action
final class RedeemGiftCardProvider
    extends $NotifierProvider<RedeemGiftCard, AsyncValue<String?>> {
  /// Gift card redemption action
  const RedeemGiftCardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redeemGiftCardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redeemGiftCardHash();

  @$internal
  @override
  RedeemGiftCard create() => RedeemGiftCard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$redeemGiftCardHash() => r'8dad1e6f7f05e993eb4aeb4cfe7e930d7ad68f50';

/// Gift card redemption action

abstract class _$RedeemGiftCard extends $Notifier<AsyncValue<String?>> {
  AsyncValue<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, AsyncValue<String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, AsyncValue<String?>>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Purchase plan action

@ProviderFor(PurchasePlan)
const purchasePlanProvider = PurchasePlanProvider._();

/// Purchase plan action
final class PurchasePlanProvider
    extends $NotifierProvider<PurchasePlan, AsyncValue<String?>> {
  /// Purchase plan action
  const PurchasePlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasePlanProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasePlanHash();

  @$internal
  @override
  PurchasePlan create() => PurchasePlan();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$purchasePlanHash() => r'f5ba490a05d4c6f4128fa227953da96605bb5ef8';

/// Purchase plan action

abstract class _$PurchasePlan extends $Notifier<AsyncValue<String?>> {
  AsyncValue<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, AsyncValue<String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, AsyncValue<String?>>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// User orders

@ProviderFor(Orders)
const ordersProvider = OrdersProvider._();

/// User orders
final class OrdersProvider
    extends $NotifierProvider<Orders, AsyncValue<List<V2BoardOrder>>> {
  /// User orders
  const OrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersHash();

  @$internal
  @override
  Orders create() => Orders();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<V2BoardOrder>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<V2BoardOrder>>>(
        value,
      ),
    );
  }
}

String _$ordersHash() => r'4ba46df60c9a160f9a02f944c5984bf4eebc40cf';

/// User orders

abstract class _$Orders extends $Notifier<AsyncValue<List<V2BoardOrder>>> {
  AsyncValue<List<V2BoardOrder>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<V2BoardOrder>>,
              AsyncValue<List<V2BoardOrder>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<V2BoardOrder>>,
                AsyncValue<List<V2BoardOrder>>
              >,
              AsyncValue<List<V2BoardOrder>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Order actions (cancel, checkout)

@ProviderFor(OrderAction)
const orderActionProvider = OrderActionProvider._();

/// Order actions (cancel, checkout)
final class OrderActionProvider
    extends $NotifierProvider<OrderAction, AsyncValue<String?>> {
  /// Order actions (cancel, checkout)
  const OrderActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderActionHash();

  @$internal
  @override
  OrderAction create() => OrderAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<String?>>(value),
    );
  }
}

String _$orderActionHash() => r'8b854645401b2217c76362a9ecf24e938c6ead88';

/// Order actions (cancel, checkout)

abstract class _$OrderAction extends $Notifier<AsyncValue<String?>> {
  AsyncValue<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, AsyncValue<String?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, AsyncValue<String?>>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
