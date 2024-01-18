/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 667 (333 per locale)
///
/// Built on 2024-01-18 at 05:40 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	ko(languageCode: 'ko', build: _StringsKo.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// context enums

enum GroupMembershipTypeContext {
	open,
	private,
	restricted,
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsIntroductionEn introduction = _StringsIntroductionEn._(_root);
	late final _StringsGeneralEn general = _StringsGeneralEn._(_root);
	late final _StringsPrayerEn prayer = _StringsPrayerEn._(_root);
	late final _StringsAuthEn auth = _StringsAuthEn._(_root);
	late final _StringsGroupEn group = _StringsGroupEn._(_root);
	late final _StringsCorporatePrayerEn corporatePrayer = _StringsCorporatePrayerEn._(_root);
	late final _StringsAlertEn alert = _StringsAlertEn._(_root);
	late final _StringsNeighborEn neighbor = _StringsNeighborEn._(_root);
	late final _StringsSettingsEn settings = _StringsSettingsEn._(_root);
	late final _StringsNotificationEn notification = _StringsNotificationEn._(_root);
	late final _StringsErrorEn error = _StringsErrorEn._(_root);
	late final _StringsBibleEn bible = _StringsBibleEn._(_root);
	late final _StringsFeedbackEn feedback = _StringsFeedbackEn._(_root);
	late final _StringsPlaceholderEn placeholder = _StringsPlaceholderEn._(_root);
	late final _StringsDonateEn donate = _StringsDonateEn._(_root);
	late final _StringsDayEn day = _StringsDayEn._(_root);
	late final _StringsEmptyEn empty = _StringsEmptyEn._(_root);
	late final _StringsBannedEn banned = _StringsBannedEn._(_root);
}

// Path: introduction
class _StringsIntroductionEn {
	_StringsIntroductionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	List<String> get title => [
		'United in Prayer',
		'Stronger Together',
		'Collective Faith',
	];
}

// Path: general
class _StringsGeneralEn {
	_StringsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get about => 'About';
	String get accept => 'Accept';
	String get accepted => 'Accepted';
	String get account => 'Account';
	String get admin => 'Admin';
	String get anonymous => 'Anonymous';
	String banUser({required Object user}) => 'Ban ${user}';
	String unbanUser({required Object user}) => 'Unban ${user}';
	String get bans => 'Bans';
	String get bio => 'Bio';
	String get bible => 'Bible';
	String get blocked => 'Blocked';
	String blockUser({required Object username}) => 'Block ${username}';
	String get bibleVerse => 'Bible Verse';
	String get cancel => 'Cancel';
	String get prayer => 'Prayer';
	String get prayers => 'Prayers';
	String get prays => 'Prays';
	String get privacyPolicy => 'Privacy Policy';
	String get private => 'Private';
	String get profile => 'Profile';
	String get promote => 'Promote';
	String promoteUser({required Object user}) => 'Promote ${user}';
	String get ratePrayer => 'Rate Prayer';
	String get readmore => 'Read More';
	String get refresh => 'Refresh';
	String get reminder => 'Reminder';
	String get reminders => 'Reminders';
	String get report => 'Report';
	String get requested => 'Requested';
	String get requests => 'Requests';
	String get restricted => 'Restricted';
	String get revoke => 'Revoke';
	String get revoked => 'Revoked';
	String get name => 'Name';
	String get neighbor => 'Neighbor';
	String get corporatePrayerPrayed => 'Prayed';
	String get corporatePrayerPraying => 'Praying';
	String get corporatePrayerPreparing => 'Preparing';
	String get corporate => 'Corporate';
	String get corporatePrayer => 'Corporate Prayer';
	String get create => 'Create';
	String get endedAt => 'Ended At';
	String get everyday => 'Everyday';
	String get follow => 'Follow';
	String followUser({required Object username}) => 'Follow ${username}';
	String get followers => 'Followers';
	String get following => 'Following';
	String get followings => 'Followings';
	String get group => 'Group';
	String get invitation => 'Invitation';
	String get invite => 'Invite';
	String get invited => 'Invited';
	String get invites => 'Invites';
	String get join => 'Join';
	String get joined => 'Joined';
	String get leaveGroup => 'Leave group';
	String get legal => 'Legal';
	String get message => 'Message';
	String get moderator => 'Moderator';
	String get moderators => 'Moderators';
	String get done => 'Done';
	String get edit => 'Edit';
	String get startedAt => 'Started At';
	String get support => 'Support';
	String get termsOfUse => 'Terms of Use';
	String get test => 'Test';
	String get title => 'Title';
	String unblockUser({required Object username}) => 'Unblock ${username}';
	String get unfollow => 'Unfollow';
	String unfollowUser({required Object username}) => 'Unfollow ${username}';
	String get username => 'Username';
	String get users => 'Users';
	String get weekdays => 'Weekdays';
	String get notifications => 'Notifications';
	String get weekend => 'Weekend';
	String get community => 'Community';
	String get createGroup => 'Create a Group';
	String get darkMode => 'Dark Mode';
	String get delete => 'Delete';
	String get deleteGroup => 'Delete a Group';
	String get description => 'Description';
	String get searchGroup => 'Search a group';
	String get sendInvitation => 'Send Invitation';
	String get sendFeedback => 'Send a Feedback';
	String get settings => 'Settings';
	String get open => 'Open';
	String get postedByMe => 'Posted by me';
	String get pray => 'Pray';
	String get groups => 'Groups';
	String get home => 'Home';
	String get sharePrayer => 'Share Prayer';
	String get signOut => 'Sign Out';
	String get prayDuration => 'Duration';
	String get praySilently => 'Pray silently';
	String get members => 'Members';
	String membersCount({required num n, required Object membersCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${membersCount} Member',
		other: '${membersCount} Members',
	);
	String get membershipType => 'Membership Type';
	String get removeFromGroup => 'Remove from group';
	String get removeModerator => 'Remove as moderator';
	String get pinPrayer => 'Pin Prayer';
	String get unpinPrayer => 'Unpin Prayer';
	TextSpan pinnedBy({required InlineSpan user}) => TextSpan(children: [
		const TextSpan(text: 'Pinned by '),
		user,
	]);
	String get myPost => 'My Post';
	String get rule => 'Rule';
	String get rules => 'Rules';
	String get welcome => 'Welcome';
	String get joinGroup => 'Join Group';
	String get askJoin => 'Ask to Join';
}

// Path: prayer
class _StringsPrayerEn {
	_StringsPrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get onlyVisibleToYou => 'Only visible to you';
	TextSpan someoneHasPrayed({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' prayed'),
	]);
	late final _StringsPrayerAlertEn alert = _StringsPrayerAlertEn._(_root);
	late final _StringsPrayerFormEn form = _StringsPrayerFormEn._(_root);
}

// Path: auth
class _StringsAuthEn {
	_StringsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsAuthLoginEn login = _StringsAuthLoginEn._(_root);
	late final _StringsAuthSignupEn signup = _StringsAuthSignupEn._(_root);
}

// Path: group
class _StringsGroupEn {
	_StringsGroupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsGroupAlertEn alert = _StringsGroupAlertEn._(_root);
	late final _StringsGroupWelcomeEn welcome = _StringsGroupWelcomeEn._(_root);
	late final _StringsGroupPrayerTimeEn prayerTime = _StringsGroupPrayerTimeEn._(_root);
	late final _StringsGroupFormEn form = _StringsGroupFormEn._(_root);
}

// Path: corporatePrayer
class _StringsCorporatePrayerEn {
	_StringsCorporatePrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsCorporatePrayerAlertEn alert = _StringsCorporatePrayerAlertEn._(_root);
	late final _StringsCorporatePrayerFormEn form = _StringsCorporatePrayerFormEn._(_root);
}

// Path: alert
class _StringsAlertEn {
	_StringsAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsAlertImagePickerEn imagePicker = _StringsAlertImagePickerEn._(_root);
	late final _StringsAlertUpdateEn update = _StringsAlertUpdateEn._(_root);
	String get confirmClose => 'Do you want to close?';
	String get actionIrreversible => 'You cannot undo this action';
	late final _StringsAlertDeleteAccountEn deleteAccount = _StringsAlertDeleteAccountEn._(_root);
	List<String> get blockUser => [
		'1. The user will not be aware that you have blocked them.',
		'2. The user will not be able to view your prayers, group, or profile.',
		'3. The user will be unable to search for you.',
	];
}

// Path: neighbor
class _StringsNeighborEn {
	_StringsNeighborEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsNeighborAlertEn alert = _StringsNeighborAlertEn._(_root);
	late final _StringsNeighborCardEn card = _StringsNeighborCardEn._(_root);
}

// Path: settings
class _StringsSettingsEn {
	_StringsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String shareAppMessage({required Object url}) => 'Share your prayer requests, express your prayers, and offer your prayers for others on Prayer today!\n\n${url}';
	TextSpan versionText({required InlineSpan version}) => TextSpan(children: [
		const TextSpan(text: 'Version: '),
		version,
	]);
}

// Path: notification
class _StringsNotificationEn {
	_StringsNotificationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsNotificationPlainEn plain = _StringsNotificationPlainEn._(_root);
	TextSpan groupAccepted({required InlineSpan group}) => TextSpan(children: [
		const TextSpan(text: 'You are now a member of '),
		group,
	]);
	TextSpan someoneFollowed({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' started following you'),
	]);
	TextSpan groupJoinRequested({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' requested to join'),
	]);
	TextSpan someoneJoinedGroup({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' joined the group'),
	]);
	TextSpan postedCorporatePrayer({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' posted a corporate prayer'),
	]);
	TextSpan postedPrayer({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' posted a prayer'),
	]);
	TextSpan prayed({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: ' prayed'),
	]);
	TextSpan groupPromoted({required InlineSpan group}) => TextSpan(children: [
		const TextSpan(text: 'You are now a moderator of '),
		group,
	]);
}

// Path: error
class _StringsErrorEn {
	_StringsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsErrorConnectionEn connection = _StringsErrorConnectionEn._(_root);
	String get acceptUser => 'Failed to accept the user';
	String get noPermissionPhotos => 'Prayers does not have an access to your photos.';
	String get adminLeaveGroup => 'Admin cannot leave the group';
	String get checkingUsernameExists => 'Error while checking your username';
	String get chooseUserToInvite => 'Please choose a user to invite';
	String get corporatePrayerHasSpecialCharacters => 'Name must not include the \'#\' or the \'@\' symbol';
	String get corporatePrayerMustNotEmpty => 'Name must include at least one non-whitespace character';
	String get corporatePrayerNeedPrayers => 'Please provide a prayer for corporate prayer';
	String get createGroup => 'Failed to create a group';
	String get deleteGroup => 'Unable to delete a group';
	String get deletePray => 'Failed to delete a pray';
	String get deleteUser => 'Please follow all the steps before deleting a user.';
	String get editGroup => 'Failed to edit a group';
	String get emptyPrayer => 'Prayer must include at least one non-whitespace character';
	String get enterName => 'Please enter your name';
	String get fieldRequired => 'This field is required';
	String fullLocalReminders({required Object max}) => 'You can set up to ${max} reminders';
	String get joinGroup => 'Failed to join the group';
	String get leaveGroup => 'Failed to leave the group';
	String get loadImage => 'Failed to load an image';
	String get memberCanShare => 'Only members can share the group';
	String get moderatorCanShare => 'Only moderators can share the group';
	String get mustBeMemberToPost => 'Only members are allowed to post prayers.';
	String get needCorporatePrayerDescription => 'Please provide a description for a corporate prayer';
	String get needDayReminder => 'Please select a day to send';
	String get needGroupBanner => 'Please upload a banner';
	String get needGroupDescription => 'Please provide a description for the group';
	String get postNoPermission => 'You have to be a member of the group';
	String viewNoPermission({required Object membershipType}) => 'This group is ${membershipType}.\nJoin to see the prayers';
	String get postPrayer => 'Unable to post a prayer';
	String get promoteUser => 'Failed to promote the user';
	String get provideReminderMessage => 'Please provide a message to be sent';
	String get revokeInvite => 'Failed to revoke the invite';
	String get signIn => 'Failed to sign in. Please try again.';
	String get unableUpdate => 'Unable to update. Please try again later';
	String get unknown => 'Unknown error occured';
	String get wrongUsernameFormat => 'You can only use alphabets, numbers, period, and underscore for the username';
	String get usernameRequired => 'Username is required';
	String usernameTaken({required Object username}) => 'Username ${username} is already taken';
}

// Path: bible
class _StringsBibleEn {
	_StringsBibleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBibleFormEn form = _StringsBibleFormEn._(_root);
}

// Path: feedback
class _StringsFeedbackEn {
	_StringsFeedbackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsFeedbackAlertEn alert = _StringsFeedbackAlertEn._(_root);
	late final _StringsFeedbackFormEn form = _StringsFeedbackFormEn._(_root);
}

// Path: placeholder
class _StringsPlaceholderEn {
	_StringsPlaceholderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get bibleVerse => 'Pick your bible verse';
	String get search => 'Search...';
}

// Path: donate
class _StringsDonateEn {
	_StringsDonateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Donate Now';
	late final _StringsDonateCardEn card = _StringsDonateCardEn._(_root);
	String get message => 'Join us in nurturing a community of faith and support. Our app offers a unique space for users to share and uplift through prayers, free from ads and without selling any data. We rely entirely on donations to keep this serene and safe platform running. Every contribution, big or small, makes a meaningful difference. Thank you for supporting this journey of fellowship and prayer.';
}

// Path: day
class _StringsDayEn {
	_StringsDayEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get fri => 'Fri';
	String get mon => 'Mon';
	String get sat => 'Sat';
	String get sun => 'Sun';
	String get thu => 'Thu';
	String get tue => 'Tue';
	String get wed => 'Wed';
}

// Path: empty
class _StringsEmptyEn {
	_StringsEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsEmptyMainEn main = _StringsEmptyMainEn._(_root);
	late final _StringsEmptyGroupPrayerEn groupPrayer = _StringsEmptyGroupPrayerEn._(_root);
	late final _StringsEmptyCorporatePrayerEn corporatePrayer = _StringsEmptyCorporatePrayerEn._(_root);
	late final _StringsEmptyGroupEn group = _StringsEmptyGroupEn._(_root);
	late final _StringsEmptyGroupRulesEn groupRules = _StringsEmptyGroupRulesEn._(_root);
	late final _StringsEmptyFollowersPrayerEn followersPrayer = _StringsEmptyFollowersPrayerEn._(_root);
	late final _StringsEmptyNeighborEn neighbor = _StringsEmptyNeighborEn._(_root);
}

// Path: banned
class _StringsBannedEn {
	_StringsBannedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBannedGroupMemberEn group_member = _StringsBannedGroupMemberEn._(_root);
}

// Path: prayer.alert
class _StringsPrayerAlertEn {
	_StringsPrayerAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPrayerAlertNeedWaitToPrayEn needWaitToPray = _StringsPrayerAlertNeedWaitToPrayEn._(_root);
	late final _StringsPrayerAlertPrayWithNameEn prayWithName = _StringsPrayerAlertPrayWithNameEn._(_root);
	late final _StringsPrayerAlertPinPrayerEn pinPrayer = _StringsPrayerAlertPinPrayerEn._(_root);
	late final _StringsPrayerAlertUnpinPrayerEn unpinPrayer = _StringsPrayerAlertUnpinPrayerEn._(_root);
}

// Path: prayer.form
class _StringsPrayerFormEn {
	_StringsPrayerFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPrayerFormPrayEn pray = _StringsPrayerFormPrayEn._(_root);
	String get postAnonymously => 'Post Anonymously';
	String get postPublicly => 'Post Publicly';
	late final _StringsPrayerFormMainEn main = _StringsPrayerFormMainEn._(_root);
	late final _StringsPrayerFormPostTypeEn postType = _StringsPrayerFormPostTypeEn._(_root);
}

// Path: auth.login
class _StringsAuthLoginEn {
	_StringsAuthLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	TextSpan disclaimer({required InlineSpan termsOfService, required InlineSpan privacyPolicy}) => TextSpan(children: [
		const TextSpan(text: 'By signing up, you agree to our '),
		termsOfService,
		const TextSpan(text: ' and acknowledge that our '),
		privacyPolicy,
		const TextSpan(text: ' applies to you'),
	]);
	late final _StringsAuthLoginButtonEn button = _StringsAuthLoginButtonEn._(_root);
}

// Path: auth.signup
class _StringsAuthSignupEn {
	_StringsAuthSignupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsAuthSignupBibleEn bible = _StringsAuthSignupBibleEn._(_root);
}

// Path: group.alert
class _StringsGroupAlertEn {
	_StringsGroupAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsGroupAlertDetailEn detail = _StringsGroupAlertDetailEn._(_root);
	String acceptMember({required Object username}) => 'Accept ${username}?';
	List<String> get deleteGroup => [
		'1. Deletion is irreversible and immediate.',
		'2. All group members will be removed automatically.',
		'3. All prayers, both corporate and individual, must be deleted to remove the group.',
	];
	List<String> get leaveGroup => [
		'1. You need to be reaccepted to join the group.',
		'2. You need to be repromoted to regain moderator status.',
		'3. None of your prayers will be deleted.',
	];
	String revokeInvitation({required Object username}) => 'Revoke an invitation of ${username}?';
	late final _StringsGroupAlertPromoteEn promote = _StringsGroupAlertPromoteEn._(_root);
	late final _StringsGroupAlertBanEn ban = _StringsGroupAlertBanEn._(_root);
	late final _StringsGroupAlertKickEn kick = _StringsGroupAlertKickEn._(_root);
	late final _StringsGroupAlertRemoveModEn removeMod = _StringsGroupAlertRemoveModEn._(_root);
}

// Path: group.welcome
class _StringsGroupWelcomeEn {
	_StringsGroupWelcomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object group}) => 'Welcome to ${group}';
	String get description => 'Thank you for selecting us as your companions on this spiritual journey.  Before we proceed, please take a moment to familiarize yourself with our guidelines.';
}

// Path: group.prayerTime
class _StringsGroupPrayerTimeEn {
	_StringsGroupPrayerTimeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'This group does not have a prayer time.';
	String yes({required Object time}) => 'You will be reminded at ${time} everyday.';
}

// Path: group.form
class _StringsGroupFormEn {
	_StringsGroupFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsGroupFormMainEn main = _StringsGroupFormMainEn._(_root);
	late final _StringsGroupFormNotificationsEn notifications = _StringsGroupFormNotificationsEn._(_root);
	late final _StringsGroupFormPickerEn picker = _StringsGroupFormPickerEn._(_root);
	late final _StringsGroupFormInviteEn invite = _StringsGroupFormInviteEn._(_root);
}

// Path: corporatePrayer.alert
class _StringsCorporatePrayerAlertEn {
	_StringsCorporatePrayerAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsCorporatePrayerAlertDeleteCorporatePrayerEn deleteCorporatePrayer = _StringsCorporatePrayerAlertDeleteCorporatePrayerEn._(_root);
}

// Path: corporatePrayer.form
class _StringsCorporatePrayerFormEn {
	_StringsCorporatePrayerFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsCorporatePrayerFormMainEn main = _StringsCorporatePrayerFormMainEn._(_root);
	late final _StringsCorporatePrayerFormPickerEn picker = _StringsCorporatePrayerFormPickerEn._(_root);
	late final _StringsCorporatePrayerFormNotificationsEn notifications = _StringsCorporatePrayerFormNotificationsEn._(_root);
}

// Path: alert.imagePicker
class _StringsAlertImagePickerEn {
	_StringsAlertImagePickerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pick an image';
	String get pickImageFromGallery => 'Pick image from gallery';
	String get resetToDefault => 'Reset to default';
	String get removeCurrentPhoto => 'Remove current photo';
}

// Path: alert.update
class _StringsAlertUpdateEn {
	_StringsAlertUpdateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'New Update Available';
	String get description => 'Please download the new update to enhance your prayer and religious life experience.';
	String get button => 'Update';
}

// Path: alert.deleteAccount
class _StringsAlertDeleteAccountEn {
	_StringsAlertDeleteAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Delete an account';
	List<String> get rules => [
		'1. You will be immediately deleted.',
		'2. You cannot recover once they are deleted.',
		'3. You must delete all the groups they own.',
		'4. You must leave all the groups to which they belong.',
		'5. You must not have any corporate prayers.',
	];
	String get prompt => 'Are you sure you want to delete an account?';
}

// Path: neighbor.alert
class _StringsNeighborAlertEn {
	_StringsNeighborAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.alert.confirmClose}';
	String get subtitle => 'You can always view this by clicking the neighbor tab.';
}

// Path: neighbor.card
class _StringsNeighborCardEn {
	_StringsNeighborCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Who is my neighbor?';
	String get description => 'When you pray for others, they become your neighbors in faith, and you\'ll see the blessings of their future prayers.';
}

// Path: notification.plain
class _StringsNotificationPlainEn {
	_StringsNotificationPlainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String groupAccepted({required Object group}) => 'You are now a member of ${group}';
	String someoneFollowed({required Object username}) => '${username} started following you';
	String groupJoinRequested({required Object username}) => '${username} requested to join';
	String someoneJoinedGroup({required Object username}) => '${username} joined the group';
	String postedCorporatePrayer({required Object username}) => '${username} posted a corporate prayer';
	String postedPrayer({required Object username}) => '${username} posted a prayer';
	String prayed({required Object username}) => '${username} prayed';
	String groupPromoted({required Object group}) => 'You are now a moderator of ${group}';
}

// Path: error.connection
class _StringsErrorConnectionEn {
	_StringsErrorConnectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Connection Error';
	String get description => 'We\'re experiencing a temporary issue connecting you to our prayer community. Please retry shortly. May your faith remain strong during this brief interruption.';
}

// Path: bible.form
class _StringsBibleFormEn {
	_StringsBibleFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBibleFormVersePickerEn versePicker = _StringsBibleFormVersePickerEn._(_root);
	late final _StringsBibleFormTranslationPickerEn translationPicker = _StringsBibleFormTranslationPickerEn._(_root);
}

// Path: feedback.alert
class _StringsFeedbackAlertEn {
	_StringsFeedbackAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sent => 'Feedback has sent';
}

// Path: feedback.form
class _StringsFeedbackFormEn {
	_StringsFeedbackFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get placeholder => 'Feel free to reach out us';
}

// Path: donate.card
class _StringsDonateCardEn {
	_StringsDonateCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.donate.title}';
	String get description => 'Help us spread the love of Jesus Christ.';
}

// Path: empty.main
class _StringsEmptyMainEn {
	_StringsEmptyMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Awaiting Your Love';
	String get description => 'It seems we\'re just beginning. Share your love and be the beacon of Jesus Christ\'s love.';
}

// Path: empty.groupPrayer
class _StringsEmptyGroupPrayerEn {
	_StringsEmptyGroupPrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Share your first prayer with us';
	String get description => 'Take a heartfelt step in your spiritual journey';
	String get button => '${_root.general.pray}';
}

// Path: empty.corporatePrayer
class _StringsEmptyCorporatePrayerEn {
	_StringsEmptyCorporatePrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Witness a Miracle';
	String get description => 'Post your first corporate prayer and watch as, in unity, miracles unfold.';
	String get reminder => 'No reminder has been set for this corporate prayer';
}

// Path: empty.group
class _StringsEmptyGroupEn {
	_StringsEmptyGroupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pray with Others';
	String get description => 'Connect, share, and experience the power of collective prayer. Unite with others in faith and witness the extraordinary.';
	String get button => '${_root.general.createGroup}';
}

// Path: empty.groupRules
class _StringsEmptyGroupRulesEn {
	_StringsEmptyGroupRulesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'While this group doesn\'t have rules, we expect all members to maintain respectful and considerate interactions.';
}

// Path: empty.followersPrayer
class _StringsEmptyFollowersPrayerEn {
	_StringsEmptyFollowersPrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Companions on the Journey';
	String get description => 'Find comfort in companionship, and uplift each other through every step of your journey. Your path is unique, but you\'re not alone. Follow, lead, and grow in faith.';
	String get button => 'Search a companion';
}

// Path: empty.neighbor
class _StringsEmptyNeighborEn {
	_StringsEmptyNeighborEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pray for others to become their neighbor.';
	String get description => 'And the second is like it: ‘Love your neighbor as yourself.’ All the Law and the Prophets hang on these two commandments.\n\nMatthew 22:38-40 (NIV)';
}

// Path: banned.group_member
class _StringsBannedGroupMemberEn {
	_StringsBannedGroupMemberEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'You are permanently banned from the group for violating our group rules.';
	List<String> get actions => [
		'You are unable to post a prayer to the group.',
		'At this moment, posting a pray to the group\'s prayer is not possible.',
		'If moderators decide to remove you, you will not be able to rejoin the group.',
	];
}

// Path: prayer.alert.needWaitToPray
class _StringsPrayerAlertNeedWaitToPrayEn {
	_StringsPrayerAlertNeedWaitToPrayEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Your prayer has been received';
	String get description => 'Let\'s give it a 5-minute grace period to soar high. How about a quick stretch or a moment of quiet reflection? Ready for your next prayer in a jiffy!\n';
}

// Path: prayer.alert.prayWithName
class _StringsPrayerAlertPrayWithNameEn {
	_StringsPrayerAlertPrayWithNameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pray with name?';
	String get community => 'Do you want to pray using your name? Everyone will be able to see your prayer along with your name.';
	String get group => 'Do you want to pray using your name? All members in the group will be able to see your prayer along with your name.';
}

// Path: prayer.alert.pinPrayer
class _StringsPrayerAlertPinPrayerEn {
	_StringsPrayerAlertPinPrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pin this prayer?';
	String get description => 'This will replace the previously pinned prayer.';
}

// Path: prayer.alert.unpinPrayer
class _StringsPrayerAlertUnpinPrayerEn {
	_StringsPrayerAlertUnpinPrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Unpin this prayer?';
}

// Path: prayer.form.pray
class _StringsPrayerFormPrayEn {
	_StringsPrayerFormPrayEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get placeholder => 'Share your love';
}

// Path: prayer.form.main
class _StringsPrayerFormMainEn {
	_StringsPrayerFormMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get placeholder => 'Our father in heaven';
}

// Path: prayer.form.postType
class _StringsPrayerFormPostTypeEn {
	_StringsPrayerFormPostTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'How to Share Your Prayer?';
	late final _StringsPrayerFormPostTypePublicEn public = _StringsPrayerFormPostTypePublicEn._(_root);
	late final _StringsPrayerFormPostTypeAnonymousEn anonymous = _StringsPrayerFormPostTypeAnonymousEn._(_root);
}

// Path: auth.login.button
class _StringsAuthLoginButtonEn {
	_StringsAuthLoginButtonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get apple => 'Continue with Apple';
	String get google => 'Continue with Google';
}

// Path: auth.signup.bible
class _StringsAuthSignupBibleEn {
	_StringsAuthSignupBibleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get passage => 'Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus.';
	String get verse => '1 Thessalonians 5:16-18 (NIV)';
}

// Path: group.alert.detail
class _StringsGroupAlertDetailEn {
	_StringsGroupAlertDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object membershipType}) => 'This group is ${membershipType}';
	late final _StringsGroupAlertDetailDescriptionEn description = _StringsGroupAlertDetailDescriptionEn._(_root);
	late final _StringsGroupAlertDetailPrayerTimeEn prayerTime = _StringsGroupAlertDetailPrayerTimeEn._(_root);
}

// Path: group.alert.promote
class _StringsGroupAlertPromoteEn {
	_StringsGroupAlertPromoteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object name}) => 'Promote ${name}';
	List<String> get description => [
		'1. Moderators have the ability to invite others or accept join requests.',
		'2. Moderators can post corporate prayers.',
		'3. Moderators can remove or ban members from the group.',
	];
	String get success => 'Member Promoted';
}

// Path: group.alert.ban
class _StringsGroupAlertBanEn {
	_StringsGroupAlertBanEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object name}) => 'Ban ${name}';
	List<String> get description => [
		'1. Users will be immediately banned.',
		'2. Users will not be automatically kicked.',
		'3. Users will be unable to post a prayer.',
		'4. Users will be unable to post a pray to the group\'s prayers.',
		'5. If a user is kicked after being banned, they will not be able to rejoin.',
	];
	String get success => 'Member banned';
}

// Path: group.alert.kick
class _StringsGroupAlertKickEn {
	_StringsGroupAlertKickEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object name}) => 'Remove ${name} from the group?';
	String get subtitle => '${_root.alert.actionIrreversible}';
	List<String> get description => [
		'1. Users won\'t be notified if they\'re removed from the group.',
		'2. Users can always rejoin or request to come back in.',
		'3. If a user has been previously banned, they will not be able to rejoin.',
		'4. All the prayers and group prayers users posted before stay put.',
		'5. Moderators cannot be removed from the group.',
	];
}

// Path: group.alert.removeMod
class _StringsGroupAlertRemoveModEn {
	_StringsGroupAlertRemoveModEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object name}) => 'Remove ${name} as moderator?';
	String get subtitle => '${_root.alert.actionIrreversible}';
	List<String> get description => [
		'All moderator privillegs will be immediately revoked.',
	];
}

// Path: group.form.main
class _StringsGroupFormMainEn {
	_StringsGroupFormMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsGroupFormMainNameEn name = _StringsGroupFormMainNameEn._(_root);
	late final _StringsGroupFormMainDescriptionEn description = _StringsGroupFormMainDescriptionEn._(_root);
	late final _StringsGroupFormMainMembershipTypeEn membershipType = _StringsGroupFormMainMembershipTypeEn._(_root);
	late final _StringsGroupFormMainPrayerTimeEn prayerTime = _StringsGroupFormMainPrayerTimeEn._(_root);
	late final _StringsGroupFormMainWelcomeEn welcome = _StringsGroupFormMainWelcomeEn._(_root);
}

// Path: group.form.notifications
class _StringsGroupFormNotificationsEn {
	_StringsGroupFormNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsGroupFormNotificationsMembersEn members = _StringsGroupFormNotificationsMembersEn._(_root);
	late final _StringsGroupFormNotificationsModeratorEn moderator = _StringsGroupFormNotificationsModeratorEn._(_root);
}

// Path: group.form.picker
class _StringsGroupFormPickerEn {
	_StringsGroupFormPickerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Choose a Group';
}

// Path: group.form.invite
class _StringsGroupFormInviteEn {
	_StringsGroupFormInviteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Invite a user?',
		other: 'Invite ${n} users?',
	);
	String get description => 'Users will receive a notification and can join without approval. Admin or other moderators can revoke your invites';
}

// Path: corporatePrayer.alert.deleteCorporatePrayer
class _StringsCorporatePrayerAlertDeleteCorporatePrayerEn {
	_StringsCorporatePrayerAlertDeleteCorporatePrayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Delete a Corporate Prayer';
	String get rules => 'All prayers in corporate prayers will not be deleted.';
	String get prompt => 'Are you sure you want to delete a corporate prayer?';
}

// Path: corporatePrayer.form.main
class _StringsCorporatePrayerFormMainEn {
	_StringsCorporatePrayerFormMainEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsCorporatePrayerFormMainBibleEn bible = _StringsCorporatePrayerFormMainBibleEn._(_root);
	late final _StringsCorporatePrayerFormMainReminderEn reminder = _StringsCorporatePrayerFormMainReminderEn._(_root);
	late final _StringsCorporatePrayerFormMainDurationEn duration = _StringsCorporatePrayerFormMainDurationEn._(_root);
}

// Path: corporatePrayer.form.picker
class _StringsCorporatePrayerFormPickerEn {
	_StringsCorporatePrayerFormPickerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Choose a Corporate Prayer';
}

// Path: corporatePrayer.form.notifications
class _StringsCorporatePrayerFormNotificationsEn {
	_StringsCorporatePrayerFormNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsCorporatePrayerFormNotificationsReminderEn reminder = _StringsCorporatePrayerFormNotificationsReminderEn._(_root);
	late final _StringsCorporatePrayerFormNotificationsMembersEn members = _StringsCorporatePrayerFormNotificationsMembersEn._(_root);
}

// Path: bible.form.versePicker
class _StringsBibleFormVersePickerEn {
	_StringsBibleFormVersePickerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Pick your bible verse';
}

// Path: bible.form.translationPicker
class _StringsBibleFormTranslationPickerEn {
	_StringsBibleFormTranslationPickerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Choose a translation';
}

// Path: prayer.form.postType.public
class _StringsPrayerFormPostTypePublicEn {
	_StringsPrayerFormPostTypePublicEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'With Name';
	String get description => 'your name will appear alongside your post';
}

// Path: prayer.form.postType.anonymous
class _StringsPrayerFormPostTypeAnonymousEn {
	_StringsPrayerFormPostTypeAnonymousEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Anonymously';
	String get description => 'Share your prayer without revealing your identity, keeping your name private';
}

// Path: group.alert.detail.description
class _StringsGroupAlertDetailDescriptionEn {
	_StringsGroupAlertDetailDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	TextSpan establishedAt({required InlineSpan establishedAt, required InlineSpan user}) => TextSpan(children: [
		const TextSpan(text: 'This group was established on '),
		establishedAt,
		const TextSpan(text: ' by '),
		user,
		const TextSpan(text: '.'),
	]);
	late final _StringsGroupAlertDetailDescriptionMembershipTypeEn membershipType = _StringsGroupAlertDetailDescriptionMembershipTypeEn._(_root);
}

// Path: group.alert.detail.prayerTime
class _StringsGroupAlertDetailPrayerTimeEn {
	_StringsGroupAlertDetailPrayerTimeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'This group does not have a designated prayer time.';
	TextSpan time({required InlineSpan day, required InlineSpan time}) => TextSpan(children: [
		const TextSpan(text: 'The group\'s prayer time is scheduled for '),
		day,
		const TextSpan(text: ' at '),
		time,
		const TextSpan(text: '. You will receive a notification at these times.'),
	]);
}

// Path: group.form.main.name
class _StringsGroupFormMainNameEn {
	_StringsGroupFormMainNameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Group Name';
	String get subtitle => 'Names must be less than 30 characters and do not include hashtag and or the \'@\' symbol.';
}

// Path: group.form.main.description
class _StringsGroupFormMainDescriptionEn {
	_StringsGroupFormMainDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Group Description';
	String get subtitle => 'Tell us a detail about your Group, such as its purpose or mission.';
}

// Path: group.form.main.membershipType
class _StringsGroupFormMainMembershipTypeEn {
	_StringsGroupFormMainMembershipTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Membership Type';
	String get subtitle => 'Tell us who can join this group. You cannot change this later.';
	String description({required GroupMembershipTypeContext context}) {
		switch (context) {
			case GroupMembershipTypeContext.open:
				return 'Anyone can freely view, join, and/or be invited to the group.';
			case GroupMembershipTypeContext.private:
				return 'Similar to restricted, but it is hidden from searches and exclusively for those who are invited';
			case GroupMembershipTypeContext.restricted:
				return 'People must ask or be invited to join the group; prayers are not visible to non-members';
		}
	}
}

// Path: group.form.main.prayerTime
class _StringsGroupFormMainPrayerTimeEn {
	_StringsGroupFormMainPrayerTimeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Prayer Time';
	String get description => 'All members of the group will receive a notification at this time.';
}

// Path: group.form.main.welcome
class _StringsGroupFormMainWelcomeEn {
	_StringsGroupFormMainWelcomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Introduction';
	String get message => 'Welcome Message';
	String get description => 'This will be displayed when users attempt to join. You can always preview it by clicking on About.';
}

// Path: group.form.notifications.members
class _StringsGroupFormNotificationsMembersEn {
	_StringsGroupFormNotificationsMembersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.general.members}';
	String get description => 'Notify when the prayer is posted to the group.';
}

// Path: group.form.notifications.moderator
class _StringsGroupFormNotificationsModeratorEn {
	_StringsGroupFormNotificationsModeratorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.general.moderator}';
	String get description => 'Notify when the moderator posts a prayer.';
}

// Path: corporatePrayer.form.main.bible
class _StringsCorporatePrayerFormMainBibleEn {
	_StringsCorporatePrayerFormMainBibleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get passage => 'After they prayed, the place where they were meeting was shaken. And they were all filled with the Holy Spirit and spoke the word of God boldly.';
	String get verse => '- Acts 4:31 (NIV)';
}

// Path: corporatePrayer.form.main.reminder
class _StringsCorporatePrayerFormMainReminderEn {
	_StringsCorporatePrayerFormMainReminderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.general.reminder}';
	String get description => 'Your timezone will be used to notify other members';
	String get placeholder => 'Let us pray...';
}

// Path: corporatePrayer.form.main.duration
class _StringsCorporatePrayerFormMainDurationEn {
	_StringsCorporatePrayerFormMainDurationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.general.prayDuration}';
	String get description => 'After the duration of prayers has elapsed, they will be marked as concluded, and reminders will not be sent.';
}

// Path: corporatePrayer.form.notifications.reminder
class _StringsCorporatePrayerFormNotificationsReminderEn {
	_StringsCorporatePrayerFormNotificationsReminderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.general.reminder}';
	String description({required Object fromDays, required Object toDays}) => 'You will be notified on ${fromDays} at ${toDays}';
}

// Path: corporatePrayer.form.notifications.members
class _StringsCorporatePrayerFormNotificationsMembersEn {
	_StringsCorporatePrayerFormNotificationsMembersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => '${_root.general.members}';
	String get description => '${_root.group.form.notifications.members.description}';
}

// Path: group.alert.detail.description.membershipType
class _StringsGroupAlertDetailDescriptionMembershipTypeEn {
	_StringsGroupAlertDetailDescriptionMembershipTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get open => 'All prayers in the group are public, visible to everyone, and joining is unrestricted.';
	String get restricted => 'Joining the group requires approval, and only members can view prayers.';
	String get private => 'Group is unlisted in searches and its prayers are inaccessible to non-members.';
}

// Path: <root>
class _StringsKo extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsKo.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ko,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ko>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _StringsKo _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsIntroductionKo introduction = _StringsIntroductionKo._(_root);
	@override late final _StringsGeneralKo general = _StringsGeneralKo._(_root);
	@override late final _StringsPrayerKo prayer = _StringsPrayerKo._(_root);
	@override late final _StringsAuthKo auth = _StringsAuthKo._(_root);
	@override late final _StringsGroupKo group = _StringsGroupKo._(_root);
	@override late final _StringsCorporatePrayerKo corporatePrayer = _StringsCorporatePrayerKo._(_root);
	@override late final _StringsAlertKo alert = _StringsAlertKo._(_root);
	@override late final _StringsNeighborKo neighbor = _StringsNeighborKo._(_root);
	@override late final _StringsSettingsKo settings = _StringsSettingsKo._(_root);
	@override late final _StringsNotificationKo notification = _StringsNotificationKo._(_root);
	@override late final _StringsErrorKo error = _StringsErrorKo._(_root);
	@override late final _StringsBibleKo bible = _StringsBibleKo._(_root);
	@override late final _StringsFeedbackKo feedback = _StringsFeedbackKo._(_root);
	@override late final _StringsPlaceholderKo placeholder = _StringsPlaceholderKo._(_root);
	@override late final _StringsDonateKo donate = _StringsDonateKo._(_root);
	@override late final _StringsDayKo day = _StringsDayKo._(_root);
	@override late final _StringsEmptyKo empty = _StringsEmptyKo._(_root);
	@override late final _StringsBannedKo banned = _StringsBannedKo._(_root);
}

// Path: introduction
class _StringsIntroductionKo extends _StringsIntroductionEn {
	_StringsIntroductionKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override List<String> get title => [
		'기도로 연합',
		'믿음의 동반자',
		'공동의 믿음',
	];
}

// Path: general
class _StringsGeneralKo extends _StringsGeneralEn {
	_StringsGeneralKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get about => '정보';
	@override String get accept => '승인';
	@override String get accepted => '승인됨';
	@override String get account => '계정';
	@override String get admin => '관리자';
	@override String get anonymous => '익명';
	@override String banUser({required Object user}) => '${user} 차단';
	@override String unbanUser({required Object user}) => '${user} 차단 해제';
	@override String get bans => '차단';
	@override String get bio => '바이오';
	@override String get bible => '성경';
	@override String get blocked => '차단됨';
	@override String blockUser({required Object username}) => '${username} 차단';
	@override String get bibleVerse => '성경 구절';
	@override String get cancel => '취소';
	@override String get prayer => '기도문';
	@override String get prayers => '기도문';
	@override String get prays => '기도';
	@override String get privacyPolicy => '개인정보 처리방침';
	@override String get private => '비공개';
	@override String get profile => '프로필';
	@override String get promote => '임명';
	@override String promoteUser({required Object user}) => '${user} 임명';
	@override String get ratePrayer => 'Prayer 리뷰 남기기';
	@override String get readmore => '더보기';
	@override String get refresh => '새로고침';
	@override String get reminder => '알림';
	@override String get reminders => '알림';
	@override String get report => '신고하기';
	@override String get requested => '요청됨';
	@override String get requests => '요청';
	@override String get restricted => '제한됨';
	@override String get revoke => '철회';
	@override String get revoked => '철회됨';
	@override String get name => '이름';
	@override String get neighbor => '이웃';
	@override String get corporatePrayerPrayed => '기도 완료';
	@override String get corporatePrayerPraying => '기도 중';
	@override String get corporatePrayerPreparing => '기도 준비 중';
	@override String get corporate => '중보 기도';
	@override String get corporatePrayer => '중보 기도';
	@override String get create => '생성';
	@override String get endedAt => '종료';
	@override String get everyday => '매일';
	@override String get follow => '팔로우';
	@override String followUser({required Object username}) => '${username} 팔로우';
	@override String get followers => '팔로워';
	@override String get following => '팔로잉';
	@override String get followings => '팔로잉';
	@override String get group => '그룹';
	@override String get invitation => '초대';
	@override String get invite => '초대하기';
	@override String get invited => '초대됨';
	@override String get invites => '초대';
	@override String get join => '가입';
	@override String get joined => '가입됨';
	@override String get leaveGroup => '그룹 탈퇴';
	@override String get legal => '법률';
	@override String get message => '메시지';
	@override String get moderator => '사역자';
	@override String get moderators => '사역자들';
	@override String get done => '완료';
	@override String get edit => '수정';
	@override String get startedAt => '시작';
	@override String get support => '지원';
	@override String get termsOfUse => '이용약관';
	@override String get test => '테스트';
	@override String get title => '제목';
	@override String unblockUser({required Object username}) => '${username} 차단 해제';
	@override String get unfollow => '언팔로우';
	@override String unfollowUser({required Object username}) => '${username} 언팔로우';
	@override String get username => '아이디';
	@override String get users => '유저';
	@override String get weekdays => '주중';
	@override String get notifications => '알림';
	@override String get weekend => '주말';
	@override String get community => '커뮤니티';
	@override String get createGroup => '그룹 생성';
	@override String get darkMode => '다크 모드';
	@override String get delete => '삭제';
	@override String get deleteGroup => '그룹 삭제';
	@override String get description => '설명';
	@override String get searchGroup => '그룹 찾기';
	@override String get sendInvitation => '초대하기';
	@override String get sendFeedback => '피드백 보내기';
	@override String get settings => '설정';
	@override String get open => '공개';
	@override String get postedByMe => '내가 포스팅한 기도문';
	@override String get pray => '기도';
	@override String get groups => '그룹';
	@override String get home => '홈';
	@override String get sharePrayer => 'Prayer 공유하기';
	@override String get signOut => '로그아웃';
	@override String get prayDuration => '기도 기간';
	@override String get praySilently => '조용히 기도하기';
	@override String get members => '멤버들';
	@override String membersCount({required num n, required Object membersCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(n,
		one: '${membersCount} 멤버',
		other: '${membersCount} 멤버들',
	);
	@override String get membershipType => '가입 조건';
	@override String get removeFromGroup => '강제 퇴장';
	@override String get removeModerator => '멤버로 전환';
	@override String get pinPrayer => '기도문 고정';
	@override String get unpinPrayer => '기도문 고정 해제';
	@override TextSpan pinnedBy({required InlineSpan user}) => TextSpan(children: [
		user,
		const TextSpan(text: '에 의해 고정됨'),
	]);
	@override String get myPost => '내 기도문';
	@override String get rule => '규칙';
	@override String get rules => '규칙';
	@override String get welcome => '환영';
	@override String get joinGroup => '그룹 참가';
	@override String get askJoin => '가입 요청';
}

// Path: prayer
class _StringsPrayerKo extends _StringsPrayerEn {
	_StringsPrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get onlyVisibleToYou => '나한테만 보임';
	@override TextSpan someoneHasPrayed({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 기도했습니다'),
	]);
	@override late final _StringsPrayerAlertKo alert = _StringsPrayerAlertKo._(_root);
	@override late final _StringsPrayerFormKo form = _StringsPrayerFormKo._(_root);
}

// Path: auth
class _StringsAuthKo extends _StringsAuthEn {
	_StringsAuthKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsAuthLoginKo login = _StringsAuthLoginKo._(_root);
	@override late final _StringsAuthSignupKo signup = _StringsAuthSignupKo._(_root);
}

// Path: group
class _StringsGroupKo extends _StringsGroupEn {
	_StringsGroupKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsGroupAlertKo alert = _StringsGroupAlertKo._(_root);
	@override late final _StringsGroupWelcomeKo welcome = _StringsGroupWelcomeKo._(_root);
	@override late final _StringsGroupFormKo form = _StringsGroupFormKo._(_root);
}

// Path: corporatePrayer
class _StringsCorporatePrayerKo extends _StringsCorporatePrayerEn {
	_StringsCorporatePrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsCorporatePrayerAlertKo alert = _StringsCorporatePrayerAlertKo._(_root);
	@override late final _StringsCorporatePrayerFormKo form = _StringsCorporatePrayerFormKo._(_root);
}

// Path: alert
class _StringsAlertKo extends _StringsAlertEn {
	_StringsAlertKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsAlertImagePickerKo imagePicker = _StringsAlertImagePickerKo._(_root);
	@override late final _StringsAlertUpdateKo update = _StringsAlertUpdateKo._(_root);
	@override String get confirmClose => '정말로 닫으시겠습니까?';
	@override String get actionIrreversible => '이 작업은 취소할 수 없습니다';
	@override late final _StringsAlertDeleteAccountKo deleteAccount = _StringsAlertDeleteAccountKo._(_root);
	@override List<String> get blockUser => [
		'1. 사용자가 당신을 차단했다는 사실을 모를 거예요.',
		'2. 사용자는 당신의 기도, 그룹, 프로필을 볼 수 없게 됩니다.',
		'3. 사용자는 당신을 검색 할 수 없습니다.',
	];
}

// Path: neighbor
class _StringsNeighborKo extends _StringsNeighborEn {
	_StringsNeighborKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsNeighborAlertKo alert = _StringsNeighborAlertKo._(_root);
	@override late final _StringsNeighborCardKo card = _StringsNeighborCardKo._(_root);
}

// Path: settings
class _StringsSettingsKo extends _StringsSettingsEn {
	_StringsSettingsKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String shareAppMessage({required Object url}) => '지금 \'Prayer\' 앱에서 서로의 기도를 나누고, 기도 요청을 올리고 다른 사람들을 위해 기도해주세요.\n\n${url}';
	@override TextSpan versionText({required InlineSpan version}) => TextSpan(children: [
		const TextSpan(text: '버전: '),
		version,
	]);
}

// Path: notification
class _StringsNotificationKo extends _StringsNotificationEn {
	_StringsNotificationKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsNotificationPlainKo plain = _StringsNotificationPlainKo._(_root);
	@override TextSpan groupAccepted({required InlineSpan group}) => TextSpan(children: [
		group,
		const TextSpan(text: '의 그룹원이 되었습니다'),
	]);
	@override TextSpan someoneFollowed({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 당신을 팔로우 했습니다'),
	]);
	@override TextSpan groupJoinRequested({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 가입을 요청했습니다'),
	]);
	@override TextSpan someoneJoinedGroup({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 그룹원이 되었습니다'),
	]);
	@override TextSpan postedCorporatePrayer({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 중보기도문을 올렸습니다'),
	]);
	@override TextSpan postedPrayer({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 기도문을 올렸습니다'),
	]);
	@override TextSpan prayed({required InlineSpan username}) => TextSpan(children: [
		username,
		const TextSpan(text: '님이 기도했습니다'),
	]);
	@override TextSpan groupPromoted({required InlineSpan group}) => TextSpan(children: [
		group,
		const TextSpan(text: '의 사역자가 되었습니다'),
	]);
}

// Path: error
class _StringsErrorKo extends _StringsErrorEn {
	_StringsErrorKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsErrorConnectionKo connection = _StringsErrorConnectionKo._(_root);
	@override String get acceptUser => '유저 승인에 실패했습니다';
	@override String get noPermissionPhotos => '사진 접근 권한을 허용해주세요.';
	@override String get adminLeaveGroup => '관리자는 그룹을 떠날 수 없습니다';
	@override String get checkingUsernameExists => '오류가 발생했습니다';
	@override String get chooseUserToInvite => '초대할 사용자를 선택해 주세요';
	@override String get corporatePrayerHasSpecialCharacters => '이름에는 \'#\' 또는 \'@\' 기호를 포함할 수 없습니다';
	@override String get corporatePrayerMustNotEmpty => '이름은 최소한 하나의 공백이 아닌 문자를 포함해야 합니다';
	@override String get corporatePrayerNeedPrayers => '중보기도를 위한 기도문을 적어주세요';
	@override String get createGroup => '그룹 생성에 실패했습니다';
	@override String get deleteGroup => '그룹 삭제에 실패했습니다';
	@override String get deletePray => '삭제에 실패하였습니다';
	@override String get deleteUser => '탈퇴하기 전에 모든 단계를 따라 주세요.';
	@override String get editGroup => '그룹 수정에 실패했습니다';
	@override String get emptyPrayer => '기도문은 최소한 하나의 공백이 아닌 문자를 포함해야 합니다';
	@override String get enterName => '이름을 입력해주세요';
	@override String get fieldRequired => '필수 입력란입니다';
	@override String fullLocalReminders({required Object max}) => '최대 ${max}개의 알림을 설정할 수 있습니다';
	@override String get joinGroup => '그룹 참가에 실패했습니다';
	@override String get leaveGroup => '그룹 탈퇴에 실패했습니다';
	@override String get loadImage => '이미지 로딩에 실패하였습니다';
	@override String get memberCanShare => '그룹 멤버만 공유 할 수 있습니다';
	@override String get moderatorCanShare => '사역자만 그룹을 공유 할 수 있습니다';
	@override String get mustBeMemberToPost => '그룹 멤버만 작성할 수 있습니다';
	@override String get needCorporatePrayerDescription => '중보기도 설명을 적어주세요';
	@override String get needDayReminder => '보내질 날을 선택해주세요';
	@override String get needGroupBanner => '배너 이미지를 업로드해주세요';
	@override String get needGroupDescription => '그룹 설명을 적어주세요';
	@override String get postNoPermission => '그룹 멤버만 작성할 수 있습니다';
	@override String viewNoPermission({required Object membershipType}) => '이 그룹은 ${membershipType} 입니다.\n멤버만 볼 수 있습니다.';
	@override String get postPrayer => '기도문 게시에 실패하였습니다';
	@override String get promoteUser => '유저를 임명하는데에 실패하였습니다';
	@override String get provideReminderMessage => '멤버들에게 전해질 메시지를 적어주세요';
	@override String get revokeInvite => '초대 철회에 실패하였습니다';
	@override String get signIn => '로그인에 실패하였습니다. 다시 시도해주세요.';
	@override String get unableUpdate => '업데이트에 실패하였습니다';
	@override String get unknown => '알 수 없는 오류가 발생했습니다';
	@override String get wrongUsernameFormat => '아이디는 알파벳, 숫자, 마침표, 밑줄만 사용가능합니다';
	@override String get usernameRequired => '아이디를 입력해주세요';
	@override String usernameTaken({required Object username}) => '${username}이 이미 사용중 입니다';
}

// Path: bible
class _StringsBibleKo extends _StringsBibleEn {
	_StringsBibleKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsBibleFormKo form = _StringsBibleFormKo._(_root);
}

// Path: feedback
class _StringsFeedbackKo extends _StringsFeedbackEn {
	_StringsFeedbackKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsFeedbackAlertKo alert = _StringsFeedbackAlertKo._(_root);
	@override late final _StringsFeedbackFormKo form = _StringsFeedbackFormKo._(_root);
}

// Path: placeholder
class _StringsPlaceholderKo extends _StringsPlaceholderEn {
	_StringsPlaceholderKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get bibleVerse => '성경 구절을 고르세요';
	@override String get search => '검색...';
}

// Path: donate
class _StringsDonateKo extends _StringsDonateEn {
	_StringsDonateKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '후원하기';
	@override late final _StringsDonateCardKo card = _StringsDonateCardKo._(_root);
	@override String get message => '크리스쳔 커뮤니티를 지키는데 힘을 실어주세요. 저희 앱은 사용자들이 기도를 통해 서로를 격려하고 위로할 수 있는 공간을 제공하고 평화롭고 안전한 플랫폼을 유지하기 위해 힘쓰고 있습니다. Prayer는 어떠한 광고나 사용자 데이터의 판매없이 전적으로 기부에 의존하고 있습니다. 크든 작든 모든 기부는 커뮤니티를 지켜나가는데 힘이 됩니다. 기도의 여정을 지원해 주셔서 감사합니다.';
}

// Path: day
class _StringsDayKo extends _StringsDayEn {
	_StringsDayKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get fri => '금';
	@override String get mon => '월';
	@override String get sat => '토';
	@override String get sun => '일';
	@override String get thu => '목';
	@override String get tue => '화';
	@override String get wed => '수';
}

// Path: empty
class _StringsEmptyKo extends _StringsEmptyEn {
	_StringsEmptyKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsEmptyMainKo main = _StringsEmptyMainKo._(_root);
	@override late final _StringsEmptyGroupPrayerKo groupPrayer = _StringsEmptyGroupPrayerKo._(_root);
	@override late final _StringsEmptyCorporatePrayerKo corporatePrayer = _StringsEmptyCorporatePrayerKo._(_root);
	@override late final _StringsEmptyGroupKo group = _StringsEmptyGroupKo._(_root);
	@override late final _StringsEmptyGroupRulesKo groupRules = _StringsEmptyGroupRulesKo._(_root);
	@override late final _StringsEmptyFollowersPrayerKo followersPrayer = _StringsEmptyFollowersPrayerKo._(_root);
	@override late final _StringsEmptyNeighborKo neighbor = _StringsEmptyNeighborKo._(_root);
}

// Path: banned
class _StringsBannedKo extends _StringsBannedEn {
	_StringsBannedKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsBannedGroupMemberKo group_member = _StringsBannedGroupMemberKo._(_root);
}

// Path: prayer.alert
class _StringsPrayerAlertKo extends _StringsPrayerAlertEn {
	_StringsPrayerAlertKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsPrayerAlertNeedWaitToPrayKo needWaitToPray = _StringsPrayerAlertNeedWaitToPrayKo._(_root);
	@override late final _StringsPrayerAlertPrayWithNameKo prayWithName = _StringsPrayerAlertPrayWithNameKo._(_root);
	@override late final _StringsPrayerAlertPinPrayerKo pinPrayer = _StringsPrayerAlertPinPrayerKo._(_root);
	@override late final _StringsPrayerAlertUnpinPrayerKo unpinPrayer = _StringsPrayerAlertUnpinPrayerKo._(_root);
}

// Path: prayer.form
class _StringsPrayerFormKo extends _StringsPrayerFormEn {
	_StringsPrayerFormKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsPrayerFormPrayKo pray = _StringsPrayerFormPrayKo._(_root);
	@override String get postAnonymously => '익명으로 공유하기';
	@override String get postPublicly => '공개적으로 공유하기';
	@override late final _StringsPrayerFormMainKo main = _StringsPrayerFormMainKo._(_root);
	@override late final _StringsPrayerFormPostTypeKo postType = _StringsPrayerFormPostTypeKo._(_root);
}

// Path: auth.login
class _StringsAuthLoginKo extends _StringsAuthLoginEn {
	_StringsAuthLoginKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override TextSpan disclaimer({required InlineSpan termsOfService, required InlineSpan privacyPolicy}) => TextSpan(children: [
		const TextSpan(text: '계속 진행함으로써 '),
		termsOfService,
		const TextSpan(text: '에 동의하고 '),
		privacyPolicy,
		const TextSpan(text: '이 적용된다는 것을 인지합니다.'),
	]);
	@override late final _StringsAuthLoginButtonKo button = _StringsAuthLoginButtonKo._(_root);
}

// Path: auth.signup
class _StringsAuthSignupKo extends _StringsAuthSignupEn {
	_StringsAuthSignupKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsAuthSignupBibleKo bible = _StringsAuthSignupBibleKo._(_root);
}

// Path: group.alert
class _StringsGroupAlertKo extends _StringsGroupAlertEn {
	_StringsGroupAlertKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsGroupAlertDetailKo detail = _StringsGroupAlertDetailKo._(_root);
	@override String acceptMember({required Object username}) => '${username}님을 승인하시겠습니까?';
	@override List<String> get deleteGroup => [
		'1. 삭제는 되돌릴 수 없으며 즉시 이루어집니다.',
		'2. 모든 그룹 구성원은 자동으로 탈퇴됩니다.',
		'3. 그룹을 삭제하기 위해서는 모든 기도 및 중보기도를 삭제해야 합니다.',
	];
	@override List<String> get leaveGroup => [
		'1. 그룹에 가입하기 위해서는 다시 초대받거나 승인되어야 합니다',
		'2. 현재 사역자일 경우 다시 임명 받아야합니다.',
		'3. 그룹에 올린 기도문은 삭제되지 않습니다.',
	];
	@override String revokeInvitation({required Object username}) => '${username}님의 초대를 취소하시겠습니까?';
	@override late final _StringsGroupAlertPromoteKo promote = _StringsGroupAlertPromoteKo._(_root);
	@override late final _StringsGroupAlertBanKo ban = _StringsGroupAlertBanKo._(_root);
	@override late final _StringsGroupAlertKickKo kick = _StringsGroupAlertKickKo._(_root);
	@override late final _StringsGroupAlertRemoveModKo removeMod = _StringsGroupAlertRemoveModKo._(_root);
}

// Path: group.welcome
class _StringsGroupWelcomeKo extends _StringsGroupWelcomeEn {
	_StringsGroupWelcomeKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required Object group}) => '${group} 오신 것을 환영합니다';
	@override String get description => '이 영적 여정에서 저희를 동반자로 선택해 주셔서 감사합니다.  계속하기 전에, 예수 그리스도의 사랑으로 가득 찬 평화롭고 영적인 분위기를 조성하기 위해 마련된 우리의 지침들을 숙지해주시기 바랍니다.';
}

// Path: group.form
class _StringsGroupFormKo extends _StringsGroupFormEn {
	_StringsGroupFormKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsGroupFormMainKo main = _StringsGroupFormMainKo._(_root);
	@override late final _StringsGroupFormNotificationsKo notifications = _StringsGroupFormNotificationsKo._(_root);
	@override late final _StringsGroupFormPickerKo picker = _StringsGroupFormPickerKo._(_root);
	@override late final _StringsGroupFormInviteKo invite = _StringsGroupFormInviteKo._(_root);
}

// Path: corporatePrayer.alert
class _StringsCorporatePrayerAlertKo extends _StringsCorporatePrayerAlertEn {
	_StringsCorporatePrayerAlertKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsCorporatePrayerAlertDeleteCorporatePrayerKo deleteCorporatePrayer = _StringsCorporatePrayerAlertDeleteCorporatePrayerKo._(_root);
}

// Path: corporatePrayer.form
class _StringsCorporatePrayerFormKo extends _StringsCorporatePrayerFormEn {
	_StringsCorporatePrayerFormKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsCorporatePrayerFormMainKo main = _StringsCorporatePrayerFormMainKo._(_root);
	@override late final _StringsCorporatePrayerFormPickerKo picker = _StringsCorporatePrayerFormPickerKo._(_root);
	@override late final _StringsCorporatePrayerFormNotificationsKo notifications = _StringsCorporatePrayerFormNotificationsKo._(_root);
}

// Path: alert.imagePicker
class _StringsAlertImagePickerKo extends _StringsAlertImagePickerEn {
	_StringsAlertImagePickerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '이미지 선택';
	@override String get pickImageFromGallery => '갤러리에서 사진 가져오기';
	@override String get resetToDefault => '기본값으로 초기화';
	@override String get removeCurrentPhoto => '현재 사진 제거하기';
}

// Path: alert.update
class _StringsAlertUpdateKo extends _StringsAlertUpdateEn {
	_StringsAlertUpdateKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prayer 업데이트';
	@override String get description => '새 업데이트를 다운로드하여 더 나은 기도와 신앙 생활을 경험하세요';
	@override String get button => '업데이트';
}

// Path: alert.deleteAccount
class _StringsAlertDeleteAccountKo extends _StringsAlertDeleteAccountEn {
	_StringsAlertDeleteAccountKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '정말 계정을 삭제하시겠습니까?';
	@override List<String> get rules => [
		'1. 사용자는 즉시 삭제됩니다.',
		'2. 사용자는 삭제되면 복구할 수 없습니다.',
		'3. 사용자는 자신이 소유한 모든 그룹을 삭제해야 합니다.',
		'4. 사용자는 자신이 속한 모든 그룹을 탈퇴해야 합니다.',
		'5. 사용자는 모든 중보 기도를 삭제해야됩니다.',
	];
	@override String get prompt => '계정을 삭제하시겠습니까?';
}

// Path: neighbor.alert
class _StringsNeighborAlertKo extends _StringsNeighborAlertEn {
	_StringsNeighborAlertKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.alert.confirmClose}';
	@override String get subtitle => '이웃 탭을 클릭하면 언제든지 다시 확인할 수 있습니다.';
}

// Path: neighbor.card
class _StringsNeighborCardKo extends _StringsNeighborCardEn {
	_StringsNeighborCardKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '누가 제 이웃인가요?';
	@override String get description => '다른 사람을 위해 기도하면, 그 사람이 이웃이 되고, 내가 기도한 사람들의 추후 기도문을 계속 볼 수 있습니다.';
}

// Path: notification.plain
class _StringsNotificationPlainKo extends _StringsNotificationPlainEn {
	_StringsNotificationPlainKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String groupAccepted({required Object group}) => '${group}의 그룹원이 되었습니다';
	@override String someoneFollowed({required Object username}) => '${username}님이 당신을 팔로우 했습니다';
	@override String groupJoinRequested({required Object username}) => '${username}님이 가입을 요청했습니다';
	@override String someoneJoinedGroup({required Object username}) => '${username}님이 그룹원이 되었습니다';
	@override String postedCorporatePrayer({required Object username}) => '${username}님이 중보기도문을 올렸습니다';
	@override String postedPrayer({required Object username}) => '${username}님이 기도문을 올렸습니다';
	@override String prayed({required Object username}) => '${username}님이 기도했습니다';
	@override String groupPromoted({required Object group}) => '${group}의 사역자가 되었습니다';
}

// Path: error.connection
class _StringsErrorConnectionKo extends _StringsErrorConnectionEn {
	_StringsErrorConnectionKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '연결 오류';
	@override String get description => '우리 기도 커뮤니티에 연결하는 데 일시적인 문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.';
}

// Path: bible.form
class _StringsBibleFormKo extends _StringsBibleFormEn {
	_StringsBibleFormKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsBibleFormVersePickerKo versePicker = _StringsBibleFormVersePickerKo._(_root);
	@override late final _StringsBibleFormTranslationPickerKo translationPicker = _StringsBibleFormTranslationPickerKo._(_root);
}

// Path: feedback.alert
class _StringsFeedbackAlertKo extends _StringsFeedbackAlertEn {
	_StringsFeedbackAlertKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get sent => '피드백이 전송되었습니다';
}

// Path: feedback.form
class _StringsFeedbackFormKo extends _StringsFeedbackFormEn {
	_StringsFeedbackFormKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get placeholder => '저희에게 연락 주세요';
}

// Path: donate.card
class _StringsDonateCardKo extends _StringsDonateCardEn {
	_StringsDonateCardKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '후원하기';
	@override String get description => '예수님의 사랑을 널리 퍼뜨릴 수 있도록 도와주세요.';
}

// Path: empty.main
class _StringsEmptyMainKo extends _StringsEmptyMainEn {
	_StringsEmptyMainKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '기도의 손길';
	@override String get description => '씨앗이 뿌려졌습니다. 사랑을 나누고 예수 그리스도의 사랑의 빛이 되어주세요.';
}

// Path: empty.groupPrayer
class _StringsEmptyGroupPrayerKo extends _StringsEmptyGroupPrayerEn {
	_StringsEmptyGroupPrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '첫 기도문을 올리고 하나님의 기적을 경험하세요.';
	@override String get description => '영적 여정에서 진심을 담은 첫걸음을 내디뎌보세요.';
	@override String get button => '기도하기';
}

// Path: empty.corporatePrayer
class _StringsEmptyCorporatePrayerKo extends _StringsEmptyCorporatePrayerEn {
	_StringsEmptyCorporatePrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '기적의 증인이 되는 삶';
	@override String get description => '첫 중보기도를 올리고 함께 기적을 목격하세요.';
	@override String get reminder => '이 중보기도는 알림이 없습니다';
}

// Path: empty.group
class _StringsEmptyGroupKo extends _StringsEmptyGroupEn {
	_StringsEmptyGroupKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '다른 사람과 기도해보세요';
	@override String get description => '연결되고 나누어 중보기도의 힘을 경험하세요. 다른 이들과 신앙 안에서 하나가 되어 놀라운 일을 목격하세요.';
	@override String get button => '그룹 생성하기';
}

// Path: empty.groupRules
class _StringsEmptyGroupRulesKo extends _StringsEmptyGroupRulesEn {
	_StringsEmptyGroupRulesKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '이 그룹에는 정해진 규칙이 없지만, 모든 멤버들의 존중과 배려를 부탁드립니다.';
}

// Path: empty.followersPrayer
class _StringsEmptyFollowersPrayerKo extends _StringsEmptyFollowersPrayerEn {
	_StringsEmptyFollowersPrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '믿음의 동반자';
	@override String get description => '동행에서 위안을 찾고, 여정의 모든 단계에서 서로를 격려하세요. 당신의 길은 특별하지만, 혼자가 아닙니다.';
	@override String get button => '동반자 찾기';
}

// Path: empty.neighbor
class _StringsEmptyNeighborKo extends _StringsEmptyNeighborEn {
	_StringsEmptyNeighborKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '남을 위해 기도하면, 그들은 우리의 신앙 이웃이 됩니다.';
	@override String get description => '둘째도 그와 같으니 네 이웃을 네 자신 같이 사랑하라 하셨으니 모든 율법과 선지자의 가르침이 이 두 계명에 달려있다.\n\n마태복음 22:38-40 (개역개정)';
}

// Path: banned.group_member
class _StringsBannedGroupMemberKo extends _StringsBannedGroupMemberEn {
	_StringsBannedGroupMemberKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '당신은 그룹 규칙을 위반하여 그룹에서 영구적으로 제외되었습니다.';
	@override List<String> get actions => [
		'당신은 그룹에 기도문를 올릴 수 없습니다.',
		'현재로서는 그룹의 기도문에 기도를 올리는 것이 불가능합니다.',
		'만약 운영진이 당신을 제거하기로 결정한다면, 그룹에 다시 가입할 수 없습니다.',
	];
}

// Path: prayer.alert.needWaitToPray
class _StringsPrayerAlertNeedWaitToPrayKo extends _StringsPrayerAlertNeedWaitToPrayEn {
	_StringsPrayerAlertNeedWaitToPrayKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '이미 기도하신 제목입니다';
	@override String get description => '다음 침묵 기도는 5분 뒤에 할 수 있습니다. 잠시 스트레칭을 하거나 조용히 묵상하는 시간은 어떨까요?';
}

// Path: prayer.alert.prayWithName
class _StringsPrayerAlertPrayWithNameKo extends _StringsPrayerAlertPrayWithNameEn {
	_StringsPrayerAlertPrayWithNameKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '공개적으로 기도하시겠습니까?';
	@override String get community => '당신의 이름과 함께 기도문을 올리시겠습니까? 모든 사람이 당신의 기도문과 이름을 볼 수 있습니다.';
	@override String get group => '그룹원이 당신의 이름과 함께 기도문을 볼 수 있습니다.';
}

// Path: prayer.alert.pinPrayer
class _StringsPrayerAlertPinPrayerKo extends _StringsPrayerAlertPinPrayerEn {
	_StringsPrayerAlertPinPrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '이 기도문을 상단에 고정하시겠습니까?';
	@override String get description => '기존에 고정된 기도문과 대체됩니다.';
}

// Path: prayer.alert.unpinPrayer
class _StringsPrayerAlertUnpinPrayerKo extends _StringsPrayerAlertUnpinPrayerEn {
	_StringsPrayerAlertUnpinPrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '이 기도문을 상단에서 내리겠습니까?';
}

// Path: prayer.form.pray
class _StringsPrayerFormPrayKo extends _StringsPrayerFormPrayEn {
	_StringsPrayerFormPrayKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get placeholder => '사랑을 나눠주세요';
}

// Path: prayer.form.main
class _StringsPrayerFormMainKo extends _StringsPrayerFormMainEn {
	_StringsPrayerFormMainKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get placeholder => '하늘에 계신 우리 아버지...';
}

// Path: prayer.form.postType
class _StringsPrayerFormPostTypeKo extends _StringsPrayerFormPostTypeEn {
	_StringsPrayerFormPostTypeKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '어떻게 기도문을 공유하시겠습니까?';
	@override late final _StringsPrayerFormPostTypePublicKo public = _StringsPrayerFormPostTypePublicKo._(_root);
	@override late final _StringsPrayerFormPostTypeAnonymousKo anonymous = _StringsPrayerFormPostTypeAnonymousKo._(_root);
}

// Path: auth.login.button
class _StringsAuthLoginButtonKo extends _StringsAuthLoginButtonEn {
	_StringsAuthLoginButtonKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get apple => 'Apple로 로그인하기';
	@override String get google => 'Google로 로그인하기';
}

// Path: auth.signup.bible
class _StringsAuthSignupBibleKo extends _StringsAuthSignupBibleEn {
	_StringsAuthSignupBibleKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get passage => '항상 기뻐하라, 쉬지 말고 기도하라, 범사에 감사하라 이것이 그리스도 예수 안에서 너희를 향하신 하나님의 뜻이라';
	@override String get verse => '데살로니가전서 5:16-18 (개역개정)';
}

// Path: group.alert.detail
class _StringsGroupAlertDetailKo extends _StringsGroupAlertDetailEn {
	_StringsGroupAlertDetailKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required Object membershipType}) => '이 그룹은 ${membershipType}입니다';
	@override late final _StringsGroupAlertDetailDescriptionKo description = _StringsGroupAlertDetailDescriptionKo._(_root);
	@override late final _StringsGroupAlertDetailPrayerTimeKo prayerTime = _StringsGroupAlertDetailPrayerTimeKo._(_root);
}

// Path: group.alert.promote
class _StringsGroupAlertPromoteKo extends _StringsGroupAlertPromoteEn {
	_StringsGroupAlertPromoteKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => '${name}님을 임명하시겠습니까?';
	@override List<String> get description => [
		'1. 사역자는 다른 사람을 초대하거나 가입 요청을 수락할 수 있습니다',
		'2. 사역자는 중보 기도문을 게시할 수 있습니다.',
		'3. 사역자는 다른 사람을 강제 퇴장하거나 밴 할 수 있습니다.',
	];
	@override String get success => '멤버를 임명했습니다';
}

// Path: group.alert.ban
class _StringsGroupAlertBanKo extends _StringsGroupAlertBanEn {
	_StringsGroupAlertBanKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Ban ${name}';
	@override List<String> get description => [
		'1. 사용자는 즉시 차단됩니다.',
		'2. 사용자가 자동으로 그룹에서 제거되지 않습니다.',
		'3. 사용자는 기도문을 게시할 수 없습니다.',
		'4. 사용자는 그룹 내 기도문에 기도를 올릴 수 없습니다.',
		'5. 만약 사용자가 차단 이후에 그룹에서 제거 될 경우, 그룹에 다시 가입할 수 없습니다.',
	];
	@override String get success => 'Member banned';
}

// Path: group.alert.kick
class _StringsGroupAlertKickKo extends _StringsGroupAlertKickEn {
	_StringsGroupAlertKickKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => '${name}님을 그룹에서 제거하시겠습니까?';
	@override String get subtitle => '${_root.alert.actionIrreversible}';
	@override List<String> get description => [
		'1. 제거했다는 사실이 알려지지 않습니다.',
		'2. 유저가 다시 가입하거나 가입 신청할 수 있습니다.',
		'3. 만약 유저가 기존에 차단당했을 경우, 다시 가입하거나 가입 신청할 수 없습니다.',
		'4. 기존에 유저가 올린 기도문/중보기도문은 삭제되지 않습니다.',
		'5. 사역자일 경우 제거할 수 없습니다.',
	];
	@override String get success => '멤버를 임명했습니다';
}

// Path: group.alert.removeMod
class _StringsGroupAlertRemoveModKo extends _StringsGroupAlertRemoveModEn {
	_StringsGroupAlertRemoveModKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => '${name}님을 일반 멤버로 전환하시겠습니까?';
	@override String get subtitle => '${_root.alert.actionIrreversible}';
	@override List<String> get description => [
		'기존에 사역자 권한이 즉시 박탈됩니다.',
	];
}

// Path: group.form.main
class _StringsGroupFormMainKo extends _StringsGroupFormMainEn {
	_StringsGroupFormMainKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsGroupFormMainNameKo name = _StringsGroupFormMainNameKo._(_root);
	@override late final _StringsGroupFormMainDescriptionKo description = _StringsGroupFormMainDescriptionKo._(_root);
	@override late final _StringsGroupFormMainMembershipTypeKo membershipType = _StringsGroupFormMainMembershipTypeKo._(_root);
	@override late final _StringsGroupFormMainWelcomeKo welcome = _StringsGroupFormMainWelcomeKo._(_root);
}

// Path: group.form.notifications
class _StringsGroupFormNotificationsKo extends _StringsGroupFormNotificationsEn {
	_StringsGroupFormNotificationsKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsGroupFormNotificationsMembersKo members = _StringsGroupFormNotificationsMembersKo._(_root);
	@override late final _StringsGroupFormNotificationsModeratorKo moderator = _StringsGroupFormNotificationsModeratorKo._(_root);
}

// Path: group.form.picker
class _StringsGroupFormPickerKo extends _StringsGroupFormPickerEn {
	_StringsGroupFormPickerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '그룹 선택';
}

// Path: group.form.invite
class _StringsGroupFormInviteKo extends _StringsGroupFormInviteEn {
	_StringsGroupFormInviteKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String title({required num n, required Object membersCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(n,
		one: '사용자 한 명을 초대하시겠습니까?',
		other: '${membersCount}명의 사람을 초대하시겠습니까?',
	);
	@override String get description => '초대받은 사용자는 알림을 받고 관리자의 승인 없이 그룹에 가입할 수 있습니다. 다른 관리자가 이 초대를 철회할 수 도 있습니다.';
}

// Path: corporatePrayer.alert.deleteCorporatePrayer
class _StringsCorporatePrayerAlertDeleteCorporatePrayerKo extends _StringsCorporatePrayerAlertDeleteCorporatePrayerEn {
	_StringsCorporatePrayerAlertDeleteCorporatePrayerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '중보기도 삭제';
	@override String get rules => '중보기도에 있는 기도문은 삭제되지 않습니다.';
	@override String get prompt => '정말 중보기도를 삭제하시겠습니까?';
}

// Path: corporatePrayer.form.main
class _StringsCorporatePrayerFormMainKo extends _StringsCorporatePrayerFormMainEn {
	_StringsCorporatePrayerFormMainKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsCorporatePrayerFormMainBibleKo bible = _StringsCorporatePrayerFormMainBibleKo._(_root);
	@override late final _StringsCorporatePrayerFormMainReminderKo reminder = _StringsCorporatePrayerFormMainReminderKo._(_root);
	@override late final _StringsCorporatePrayerFormMainDurationKo duration = _StringsCorporatePrayerFormMainDurationKo._(_root);
}

// Path: corporatePrayer.form.picker
class _StringsCorporatePrayerFormPickerKo extends _StringsCorporatePrayerFormPickerEn {
	_StringsCorporatePrayerFormPickerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '중보기도 선택';
}

// Path: corporatePrayer.form.notifications
class _StringsCorporatePrayerFormNotificationsKo extends _StringsCorporatePrayerFormNotificationsEn {
	_StringsCorporatePrayerFormNotificationsKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override late final _StringsCorporatePrayerFormNotificationsReminderKo reminder = _StringsCorporatePrayerFormNotificationsReminderKo._(_root);
	@override late final _StringsCorporatePrayerFormNotificationsMembersKo members = _StringsCorporatePrayerFormNotificationsMembersKo._(_root);
}

// Path: bible.form.versePicker
class _StringsBibleFormVersePickerKo extends _StringsBibleFormVersePickerEn {
	_StringsBibleFormVersePickerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '성경 구절 고르기';
}

// Path: bible.form.translationPicker
class _StringsBibleFormTranslationPickerKo extends _StringsBibleFormTranslationPickerEn {
	_StringsBibleFormTranslationPickerKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '번역 선택하기';
}

// Path: prayer.form.postType.public
class _StringsPrayerFormPostTypePublicKo extends _StringsPrayerFormPostTypePublicEn {
	_StringsPrayerFormPostTypePublicKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '공개적으로 공유하기';
	@override String get description => '사용자들이 당신의 기도문과 당신의 이름을 볼 수 있습니다';
}

// Path: prayer.form.postType.anonymous
class _StringsPrayerFormPostTypeAnonymousKo extends _StringsPrayerFormPostTypeAnonymousEn {
	_StringsPrayerFormPostTypeAnonymousKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '익명으로 공유하기';
	@override String get description => '익명 기도문은 누가 올렸는지 확인할 수 없습니다';
}

// Path: group.alert.detail.description
class _StringsGroupAlertDetailDescriptionKo extends _StringsGroupAlertDetailDescriptionEn {
	_StringsGroupAlertDetailDescriptionKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override TextSpan establishedAt({required InlineSpan establishedAt, required InlineSpan user}) => TextSpan(children: [
		const TextSpan(text: '이 그룹은 '),
		establishedAt,
		const TextSpan(text: '애 '),
		user,
		const TextSpan(text: '에 의해 창설되었습니다'),
	]);
	@override late final _StringsGroupAlertDetailDescriptionMembershipTypeKo membershipType = _StringsGroupAlertDetailDescriptionMembershipTypeKo._(_root);
}

// Path: group.alert.detail.prayerTime
class _StringsGroupAlertDetailPrayerTimeKo extends _StringsGroupAlertDetailPrayerTimeEn {
	_StringsGroupAlertDetailPrayerTimeKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get empty => '이 그룹은 지정된 기도 시간이 없습니다.';
	@override TextSpan time({required InlineSpan day, required InlineSpan time}) => TextSpan(children: [
		const TextSpan(text: '이 그룹의 기도 시간은 '),
		day,
		const TextSpan(text: ' '),
		time,
		const TextSpan(text: '로 예정되어 있습니다. 해당 시간에 알림을 받게 됩니다.'),
	]);
}

// Path: group.form.main.name
class _StringsGroupFormMainNameKo extends _StringsGroupFormMainNameEn {
	_StringsGroupFormMainNameKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '그룹 이름';
	@override String get subtitle => '이름은 30자 미만이어야 하며 해시태그 및 \'@\' 기호를 포함하지 않아야 합니다.';
}

// Path: group.form.main.description
class _StringsGroupFormMainDescriptionKo extends _StringsGroupFormMainDescriptionEn {
	_StringsGroupFormMainDescriptionKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '그룹 설명';
	@override String get subtitle => '이 그룹이 어떤 그룹인지 알려주세요. 예) 목적, 미션, 기도제목';
}

// Path: group.form.main.membershipType
class _StringsGroupFormMainMembershipTypeKo extends _StringsGroupFormMainMembershipTypeEn {
	_StringsGroupFormMainMembershipTypeKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '가입 조건';
	@override String get subtitle => '누가 그룹을 가입할 수 있는지 선택해주세요. 이 선택은 나중에 바꿀 수 없습니다.';
	@override String description({required GroupMembershipTypeContext context}) {
		switch (context) {
			case GroupMembershipTypeContext.open:
				return '누구나 자유롭게 그룹내 기도문을 보고, 가입할 수 있습니다.';
			case GroupMembershipTypeContext.private:
				return '제한됨과 비슷하지만, 그룹이 검색되지 않고 초대를 통해서만 들어올 수 있습니다.';
			case GroupMembershipTypeContext.restricted:
				return '그룹을 가입하기 위해 승인받거나 초대받아야하며, 그룹내 멤버들만 기도문을 볼 수 있습니다.';
		}
	}
}

// Path: group.form.main.welcome
class _StringsGroupFormMainWelcomeKo extends _StringsGroupFormMainWelcomeEn {
	_StringsGroupFormMainWelcomeKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '그룹 소개';
	@override String get message => '그룹 소개글';
	@override String get description => '소개는 유저가 그룹에 가입할때 보여집니다. 항상 \'그룹 정보\'를 클릭해 미리 볼 수 있습니다.';
}

// Path: group.form.notifications.members
class _StringsGroupFormNotificationsMembersKo extends _StringsGroupFormNotificationsMembersEn {
	_StringsGroupFormNotificationsMembersKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.general.members}';
	@override String get description => '그룹원이 기도문을 올릴때 알림을 받습니다.';
}

// Path: group.form.notifications.moderator
class _StringsGroupFormNotificationsModeratorKo extends _StringsGroupFormNotificationsModeratorEn {
	_StringsGroupFormNotificationsModeratorKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.general.moderator}';
	@override String get description => '사역자가 기도문을 올릴때 알림을 받습니다.';
}

// Path: corporatePrayer.form.main.bible
class _StringsCorporatePrayerFormMainBibleKo extends _StringsCorporatePrayerFormMainBibleEn {
	_StringsCorporatePrayerFormMainBibleKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get passage => '빌기를 다하매 모인 곳이 진동하더니 무리가 다 성령이 충만하여 담대히 하나님의 말씀을 전하니라';
	@override String get verse => '- 사도행전 4:31 (개역개정)';
}

// Path: corporatePrayer.form.main.reminder
class _StringsCorporatePrayerFormMainReminderKo extends _StringsCorporatePrayerFormMainReminderEn {
	_StringsCorporatePrayerFormMainReminderKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.general.reminder}';
	@override String get description => '내 시간대를 기준으로 다른 사람에게 알림이 전송됩니다';
	@override String get placeholder => '기도 시간 입니다...';
}

// Path: corporatePrayer.form.main.duration
class _StringsCorporatePrayerFormMainDurationKo extends _StringsCorporatePrayerFormMainDurationEn {
	_StringsCorporatePrayerFormMainDurationKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.general.prayDuration}';
	@override String get description => '기도 기간이 끝나면 알림이 전송되지 않습니다';
}

// Path: corporatePrayer.form.notifications.reminder
class _StringsCorporatePrayerFormNotificationsReminderKo extends _StringsCorporatePrayerFormNotificationsReminderEn {
	_StringsCorporatePrayerFormNotificationsReminderKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.general.reminder}';
	@override String description({required Object fromDays, required Object toDays}) => '이 알림은 ${fromDays}부터 ${toDays}까지 전송됩니다';
}

// Path: corporatePrayer.form.notifications.members
class _StringsCorporatePrayerFormNotificationsMembersKo extends _StringsCorporatePrayerFormNotificationsMembersEn {
	_StringsCorporatePrayerFormNotificationsMembersKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '${_root.general.members}';
	@override String get description => '${_root.group.form.notifications.members.description}';
}

// Path: group.alert.detail.description.membershipType
class _StringsGroupAlertDetailDescriptionMembershipTypeKo extends _StringsGroupAlertDetailDescriptionMembershipTypeEn {
	_StringsGroupAlertDetailDescriptionMembershipTypeKo._(_StringsKo root) : this._root = root, super._(root);

	@override final _StringsKo _root; // ignore: unused_field

	// Translations
	@override String get open => '누구나 그룹내 모든 기도문을 볼 수 있고, 가입을 자유롭게 할 수 있습니다.';
	@override String get restricted => '그룹을 가입하기 위해 승인받거나 초대받아야하며, 그룹내 멤버들만 기도문을 볼 수 있습니다.';
	@override String get private => '그룹이 검색되지 않고 초대를 통해서만 들어올 수 있습니다.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'introduction.title.0': return 'United in Prayer';
			case 'introduction.title.1': return 'Stronger Together';
			case 'introduction.title.2': return 'Collective Faith';
			case 'general.about': return 'About';
			case 'general.accept': return 'Accept';
			case 'general.accepted': return 'Accepted';
			case 'general.account': return 'Account';
			case 'general.admin': return 'Admin';
			case 'general.anonymous': return 'Anonymous';
			case 'general.banUser': return ({required Object user}) => 'Ban ${user}';
			case 'general.unbanUser': return ({required Object user}) => 'Unban ${user}';
			case 'general.bans': return 'Bans';
			case 'general.bio': return 'Bio';
			case 'general.bible': return 'Bible';
			case 'general.blocked': return 'Blocked';
			case 'general.blockUser': return ({required Object username}) => 'Block ${username}';
			case 'general.bibleVerse': return 'Bible Verse';
			case 'general.cancel': return 'Cancel';
			case 'general.prayer': return 'Prayer';
			case 'general.prayers': return 'Prayers';
			case 'general.prays': return 'Prays';
			case 'general.privacyPolicy': return 'Privacy Policy';
			case 'general.private': return 'Private';
			case 'general.profile': return 'Profile';
			case 'general.promote': return 'Promote';
			case 'general.promoteUser': return ({required Object user}) => 'Promote ${user}';
			case 'general.ratePrayer': return 'Rate Prayer';
			case 'general.readmore': return 'Read More';
			case 'general.refresh': return 'Refresh';
			case 'general.reminder': return 'Reminder';
			case 'general.reminders': return 'Reminders';
			case 'general.report': return 'Report';
			case 'general.requested': return 'Requested';
			case 'general.requests': return 'Requests';
			case 'general.restricted': return 'Restricted';
			case 'general.revoke': return 'Revoke';
			case 'general.revoked': return 'Revoked';
			case 'general.name': return 'Name';
			case 'general.neighbor': return 'Neighbor';
			case 'general.corporatePrayerPrayed': return 'Prayed';
			case 'general.corporatePrayerPraying': return 'Praying';
			case 'general.corporatePrayerPreparing': return 'Preparing';
			case 'general.corporate': return 'Corporate';
			case 'general.corporatePrayer': return 'Corporate Prayer';
			case 'general.create': return 'Create';
			case 'general.endedAt': return 'Ended At';
			case 'general.everyday': return 'Everyday';
			case 'general.follow': return 'Follow';
			case 'general.followUser': return ({required Object username}) => 'Follow ${username}';
			case 'general.followers': return 'Followers';
			case 'general.following': return 'Following';
			case 'general.followings': return 'Followings';
			case 'general.group': return 'Group';
			case 'general.invitation': return 'Invitation';
			case 'general.invite': return 'Invite';
			case 'general.invited': return 'Invited';
			case 'general.invites': return 'Invites';
			case 'general.join': return 'Join';
			case 'general.joined': return 'Joined';
			case 'general.leaveGroup': return 'Leave group';
			case 'general.legal': return 'Legal';
			case 'general.message': return 'Message';
			case 'general.moderator': return 'Moderator';
			case 'general.moderators': return 'Moderators';
			case 'general.done': return 'Done';
			case 'general.edit': return 'Edit';
			case 'general.startedAt': return 'Started At';
			case 'general.support': return 'Support';
			case 'general.termsOfUse': return 'Terms of Use';
			case 'general.test': return 'Test';
			case 'general.title': return 'Title';
			case 'general.unblockUser': return ({required Object username}) => 'Unblock ${username}';
			case 'general.unfollow': return 'Unfollow';
			case 'general.unfollowUser': return ({required Object username}) => 'Unfollow ${username}';
			case 'general.username': return 'Username';
			case 'general.users': return 'Users';
			case 'general.weekdays': return 'Weekdays';
			case 'general.notifications': return 'Notifications';
			case 'general.weekend': return 'Weekend';
			case 'general.community': return 'Community';
			case 'general.createGroup': return 'Create a Group';
			case 'general.darkMode': return 'Dark Mode';
			case 'general.delete': return 'Delete';
			case 'general.deleteGroup': return 'Delete a Group';
			case 'general.description': return 'Description';
			case 'general.searchGroup': return 'Search a group';
			case 'general.sendInvitation': return 'Send Invitation';
			case 'general.sendFeedback': return 'Send a Feedback';
			case 'general.settings': return 'Settings';
			case 'general.open': return 'Open';
			case 'general.postedByMe': return 'Posted by me';
			case 'general.pray': return 'Pray';
			case 'general.groups': return 'Groups';
			case 'general.home': return 'Home';
			case 'general.sharePrayer': return 'Share Prayer';
			case 'general.signOut': return 'Sign Out';
			case 'general.prayDuration': return 'Duration';
			case 'general.praySilently': return 'Pray silently';
			case 'general.members': return 'Members';
			case 'general.membersCount': return ({required num n, required Object membersCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${membersCount} Member',
				other: '${membersCount} Members',
			);
			case 'general.membershipType': return 'Membership Type';
			case 'general.removeFromGroup': return 'Remove from group';
			case 'general.removeModerator': return 'Remove as moderator';
			case 'general.pinPrayer': return 'Pin Prayer';
			case 'general.unpinPrayer': return 'Unpin Prayer';
			case 'general.pinnedBy': return ({required InlineSpan user}) => TextSpan(children: [
				const TextSpan(text: 'Pinned by '),
				user,
			]);
			case 'general.myPost': return 'My Post';
			case 'general.rule': return 'Rule';
			case 'general.rules': return 'Rules';
			case 'general.welcome': return 'Welcome';
			case 'general.joinGroup': return 'Join Group';
			case 'general.askJoin': return 'Ask to Join';
			case 'prayer.onlyVisibleToYou': return 'Only visible to you';
			case 'prayer.someoneHasPrayed': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' prayed'),
			]);
			case 'prayer.alert.needWaitToPray.title': return 'Your prayer has been received';
			case 'prayer.alert.needWaitToPray.description': return 'Let\'s give it a 5-minute grace period to soar high. How about a quick stretch or a moment of quiet reflection? Ready for your next prayer in a jiffy!\n';
			case 'prayer.alert.prayWithName.title': return 'Pray with name?';
			case 'prayer.alert.prayWithName.community': return 'Do you want to pray using your name? Everyone will be able to see your prayer along with your name.';
			case 'prayer.alert.prayWithName.group': return 'Do you want to pray using your name? All members in the group will be able to see your prayer along with your name.';
			case 'prayer.alert.pinPrayer.title': return 'Pin this prayer?';
			case 'prayer.alert.pinPrayer.description': return 'This will replace the previously pinned prayer.';
			case 'prayer.alert.unpinPrayer.title': return 'Unpin this prayer?';
			case 'prayer.form.pray.placeholder': return 'Share your love';
			case 'prayer.form.postAnonymously': return 'Post Anonymously';
			case 'prayer.form.postPublicly': return 'Post Publicly';
			case 'prayer.form.main.placeholder': return 'Our father in heaven';
			case 'prayer.form.postType.title': return 'How to Share Your Prayer?';
			case 'prayer.form.postType.public.title': return 'With Name';
			case 'prayer.form.postType.public.description': return 'your name will appear alongside your post';
			case 'prayer.form.postType.anonymous.title': return 'Anonymously';
			case 'prayer.form.postType.anonymous.description': return 'Share your prayer without revealing your identity, keeping your name private';
			case 'auth.login.disclaimer': return ({required InlineSpan termsOfService, required InlineSpan privacyPolicy}) => TextSpan(children: [
				const TextSpan(text: 'By signing up, you agree to our '),
				termsOfService,
				const TextSpan(text: ' and acknowledge that our '),
				privacyPolicy,
				const TextSpan(text: ' applies to you'),
			]);
			case 'auth.login.button.apple': return 'Continue with Apple';
			case 'auth.login.button.google': return 'Continue with Google';
			case 'auth.signup.bible.passage': return 'Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus.';
			case 'auth.signup.bible.verse': return '1 Thessalonians 5:16-18 (NIV)';
			case 'group.alert.detail.title': return ({required Object membershipType}) => 'This group is ${membershipType}';
			case 'group.alert.detail.description.establishedAt': return ({required InlineSpan establishedAt, required InlineSpan user}) => TextSpan(children: [
				const TextSpan(text: 'This group was established on '),
				establishedAt,
				const TextSpan(text: ' by '),
				user,
				const TextSpan(text: '.'),
			]);
			case 'group.alert.detail.description.membershipType.open': return 'All prayers in the group are public, visible to everyone, and joining is unrestricted.';
			case 'group.alert.detail.description.membershipType.restricted': return 'Joining the group requires approval, and only members can view prayers.';
			case 'group.alert.detail.description.membershipType.private': return 'Group is unlisted in searches and its prayers are inaccessible to non-members.';
			case 'group.alert.detail.prayerTime.empty': return 'This group does not have a designated prayer time.';
			case 'group.alert.detail.prayerTime.time': return ({required InlineSpan day, required InlineSpan time}) => TextSpan(children: [
				const TextSpan(text: 'The group\'s prayer time is scheduled for '),
				day,
				const TextSpan(text: ' at '),
				time,
				const TextSpan(text: '. You will receive a notification at these times.'),
			]);
			case 'group.alert.acceptMember': return ({required Object username}) => 'Accept ${username}?';
			case 'group.alert.deleteGroup.0': return '1. Deletion is irreversible and immediate.';
			case 'group.alert.deleteGroup.1': return '2. All group members will be removed automatically.';
			case 'group.alert.deleteGroup.2': return '3. All prayers, both corporate and individual, must be deleted to remove the group.';
			case 'group.alert.leaveGroup.0': return '1. You need to be reaccepted to join the group.';
			case 'group.alert.leaveGroup.1': return '2. You need to be repromoted to regain moderator status.';
			case 'group.alert.leaveGroup.2': return '3. None of your prayers will be deleted.';
			case 'group.alert.revokeInvitation': return ({required Object username}) => 'Revoke an invitation of ${username}?';
			case 'group.alert.promote.title': return ({required Object name}) => 'Promote ${name}';
			case 'group.alert.promote.description.0': return '1. Moderators have the ability to invite others or accept join requests.';
			case 'group.alert.promote.description.1': return '2. Moderators can post corporate prayers.';
			case 'group.alert.promote.description.2': return '3. Moderators can remove or ban members from the group.';
			case 'group.alert.promote.success': return 'Member Promoted';
			case 'group.alert.ban.title': return ({required Object name}) => 'Ban ${name}';
			case 'group.alert.ban.description.0': return '1. Users will be immediately banned.';
			case 'group.alert.ban.description.1': return '2. Users will not be automatically kicked.';
			case 'group.alert.ban.description.2': return '3. Users will be unable to post a prayer.';
			case 'group.alert.ban.description.3': return '4. Users will be unable to post a pray to the group\'s prayers.';
			case 'group.alert.ban.description.4': return '5. If a user is kicked after being banned, they will not be able to rejoin.';
			case 'group.alert.ban.success': return 'Member banned';
			case 'group.alert.kick.title': return ({required Object name}) => 'Remove ${name} from the group?';
			case 'group.alert.kick.subtitle': return '${_root.alert.actionIrreversible}';
			case 'group.alert.kick.description.0': return '1. Users won\'t be notified if they\'re removed from the group.';
			case 'group.alert.kick.description.1': return '2. Users can always rejoin or request to come back in.';
			case 'group.alert.kick.description.2': return '3. If a user has been previously banned, they will not be able to rejoin.';
			case 'group.alert.kick.description.3': return '4. All the prayers and group prayers users posted before stay put.';
			case 'group.alert.kick.description.4': return '5. Moderators cannot be removed from the group.';
			case 'group.alert.removeMod.title': return ({required Object name}) => 'Remove ${name} as moderator?';
			case 'group.alert.removeMod.subtitle': return '${_root.alert.actionIrreversible}';
			case 'group.alert.removeMod.description.0': return 'All moderator privillegs will be immediately revoked.';
			case 'group.welcome.title': return ({required Object group}) => 'Welcome to ${group}';
			case 'group.welcome.description': return 'Thank you for selecting us as your companions on this spiritual journey.  Before we proceed, please take a moment to familiarize yourself with our guidelines.';
			case 'group.prayerTime.empty': return 'This group does not have a prayer time.';
			case 'group.prayerTime.yes': return ({required Object time}) => 'You will be reminded at ${time} everyday.';
			case 'group.form.main.name.title': return 'Group Name';
			case 'group.form.main.name.subtitle': return 'Names must be less than 30 characters and do not include hashtag and or the \'@\' symbol.';
			case 'group.form.main.description.title': return 'Group Description';
			case 'group.form.main.description.subtitle': return 'Tell us a detail about your Group, such as its purpose or mission.';
			case 'group.form.main.membershipType.title': return 'Membership Type';
			case 'group.form.main.membershipType.subtitle': return 'Tell us who can join this group. You cannot change this later.';
			case 'group.form.main.membershipType.description': return ({required GroupMembershipTypeContext context}) {
				switch (context) {
					case GroupMembershipTypeContext.open:
						return 'Anyone can freely view, join, and/or be invited to the group.';
					case GroupMembershipTypeContext.private:
						return 'Similar to restricted, but it is hidden from searches and exclusively for those who are invited';
					case GroupMembershipTypeContext.restricted:
						return 'People must ask or be invited to join the group; prayers are not visible to non-members';
				}
			};
			case 'group.form.main.prayerTime.title': return 'Prayer Time';
			case 'group.form.main.prayerTime.description': return 'All members of the group will receive a notification at this time.';
			case 'group.form.main.welcome.title': return 'Introduction';
			case 'group.form.main.welcome.message': return 'Welcome Message';
			case 'group.form.main.welcome.description': return 'This will be displayed when users attempt to join. You can always preview it by clicking on About.';
			case 'group.form.notifications.members.title': return '${_root.general.members}';
			case 'group.form.notifications.members.description': return 'Notify when the prayer is posted to the group.';
			case 'group.form.notifications.moderator.title': return '${_root.general.moderator}';
			case 'group.form.notifications.moderator.description': return 'Notify when the moderator posts a prayer.';
			case 'group.form.picker.title': return 'Choose a Group';
			case 'group.form.invite.title': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Invite a user?',
				other: 'Invite ${n} users?',
			);
			case 'group.form.invite.description': return 'Users will receive a notification and can join without approval. Admin or other moderators can revoke your invites';
			case 'corporatePrayer.alert.deleteCorporatePrayer.title': return 'Delete a Corporate Prayer';
			case 'corporatePrayer.alert.deleteCorporatePrayer.rules': return 'All prayers in corporate prayers will not be deleted.';
			case 'corporatePrayer.alert.deleteCorporatePrayer.prompt': return 'Are you sure you want to delete a corporate prayer?';
			case 'corporatePrayer.form.main.bible.passage': return 'After they prayed, the place where they were meeting was shaken. And they were all filled with the Holy Spirit and spoke the word of God boldly.';
			case 'corporatePrayer.form.main.bible.verse': return '- Acts 4:31 (NIV)';
			case 'corporatePrayer.form.main.reminder.title': return '${_root.general.reminder}';
			case 'corporatePrayer.form.main.reminder.description': return 'Your timezone will be used to notify other members';
			case 'corporatePrayer.form.main.reminder.placeholder': return 'Let us pray...';
			case 'corporatePrayer.form.main.duration.title': return '${_root.general.prayDuration}';
			case 'corporatePrayer.form.main.duration.description': return 'After the duration of prayers has elapsed, they will be marked as concluded, and reminders will not be sent.';
			case 'corporatePrayer.form.picker.title': return 'Choose a Corporate Prayer';
			case 'corporatePrayer.form.notifications.reminder.title': return '${_root.general.reminder}';
			case 'corporatePrayer.form.notifications.reminder.description': return ({required Object fromDays, required Object toDays}) => 'You will be notified on ${fromDays} at ${toDays}';
			case 'corporatePrayer.form.notifications.members.title': return '${_root.general.members}';
			case 'corporatePrayer.form.notifications.members.description': return '${_root.group.form.notifications.members.description}';
			case 'alert.imagePicker.title': return 'Pick an image';
			case 'alert.imagePicker.pickImageFromGallery': return 'Pick image from gallery';
			case 'alert.imagePicker.resetToDefault': return 'Reset to default';
			case 'alert.imagePicker.removeCurrentPhoto': return 'Remove current photo';
			case 'alert.update.title': return 'New Update Available';
			case 'alert.update.description': return 'Please download the new update to enhance your prayer and religious life experience.';
			case 'alert.update.button': return 'Update';
			case 'alert.confirmClose': return 'Do you want to close?';
			case 'alert.actionIrreversible': return 'You cannot undo this action';
			case 'alert.deleteAccount.title': return 'Delete an account';
			case 'alert.deleteAccount.rules.0': return '1. You will be immediately deleted.';
			case 'alert.deleteAccount.rules.1': return '2. You cannot recover once they are deleted.';
			case 'alert.deleteAccount.rules.2': return '3. You must delete all the groups they own.';
			case 'alert.deleteAccount.rules.3': return '4. You must leave all the groups to which they belong.';
			case 'alert.deleteAccount.rules.4': return '5. You must not have any corporate prayers.';
			case 'alert.deleteAccount.prompt': return 'Are you sure you want to delete an account?';
			case 'alert.blockUser.0': return '1. The user will not be aware that you have blocked them.';
			case 'alert.blockUser.1': return '2. The user will not be able to view your prayers, group, or profile.';
			case 'alert.blockUser.2': return '3. The user will be unable to search for you.';
			case 'neighbor.alert.title': return '${_root.alert.confirmClose}';
			case 'neighbor.alert.subtitle': return 'You can always view this by clicking the neighbor tab.';
			case 'neighbor.card.title': return 'Who is my neighbor?';
			case 'neighbor.card.description': return 'When you pray for others, they become your neighbors in faith, and you\'ll see the blessings of their future prayers.';
			case 'settings.shareAppMessage': return ({required Object url}) => 'Share your prayer requests, express your prayers, and offer your prayers for others on Prayer today!\n\n${url}';
			case 'settings.versionText': return ({required InlineSpan version}) => TextSpan(children: [
				const TextSpan(text: 'Version: '),
				version,
			]);
			case 'notification.plain.groupAccepted': return ({required Object group}) => 'You are now a member of ${group}';
			case 'notification.plain.someoneFollowed': return ({required Object username}) => '${username} started following you';
			case 'notification.plain.groupJoinRequested': return ({required Object username}) => '${username} requested to join';
			case 'notification.plain.someoneJoinedGroup': return ({required Object username}) => '${username} joined the group';
			case 'notification.plain.postedCorporatePrayer': return ({required Object username}) => '${username} posted a corporate prayer';
			case 'notification.plain.postedPrayer': return ({required Object username}) => '${username} posted a prayer';
			case 'notification.plain.prayed': return ({required Object username}) => '${username} prayed';
			case 'notification.plain.groupPromoted': return ({required Object group}) => 'You are now a moderator of ${group}';
			case 'notification.groupAccepted': return ({required InlineSpan group}) => TextSpan(children: [
				const TextSpan(text: 'You are now a member of '),
				group,
			]);
			case 'notification.someoneFollowed': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' started following you'),
			]);
			case 'notification.groupJoinRequested': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' requested to join'),
			]);
			case 'notification.someoneJoinedGroup': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' joined the group'),
			]);
			case 'notification.postedCorporatePrayer': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' posted a corporate prayer'),
			]);
			case 'notification.postedPrayer': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' posted a prayer'),
			]);
			case 'notification.prayed': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: ' prayed'),
			]);
			case 'notification.groupPromoted': return ({required InlineSpan group}) => TextSpan(children: [
				const TextSpan(text: 'You are now a moderator of '),
				group,
			]);
			case 'error.connection.title': return 'Connection Error';
			case 'error.connection.description': return 'We\'re experiencing a temporary issue connecting you to our prayer community. Please retry shortly. May your faith remain strong during this brief interruption.';
			case 'error.acceptUser': return 'Failed to accept the user';
			case 'error.noPermissionPhotos': return 'Prayers does not have an access to your photos.';
			case 'error.adminLeaveGroup': return 'Admin cannot leave the group';
			case 'error.checkingUsernameExists': return 'Error while checking your username';
			case 'error.chooseUserToInvite': return 'Please choose a user to invite';
			case 'error.corporatePrayerHasSpecialCharacters': return 'Name must not include the \'#\' or the \'@\' symbol';
			case 'error.corporatePrayerMustNotEmpty': return 'Name must include at least one non-whitespace character';
			case 'error.corporatePrayerNeedPrayers': return 'Please provide a prayer for corporate prayer';
			case 'error.createGroup': return 'Failed to create a group';
			case 'error.deleteGroup': return 'Unable to delete a group';
			case 'error.deletePray': return 'Failed to delete a pray';
			case 'error.deleteUser': return 'Please follow all the steps before deleting a user.';
			case 'error.editGroup': return 'Failed to edit a group';
			case 'error.emptyPrayer': return 'Prayer must include at least one non-whitespace character';
			case 'error.enterName': return 'Please enter your name';
			case 'error.fieldRequired': return 'This field is required';
			case 'error.fullLocalReminders': return ({required Object max}) => 'You can set up to ${max} reminders';
			case 'error.joinGroup': return 'Failed to join the group';
			case 'error.leaveGroup': return 'Failed to leave the group';
			case 'error.loadImage': return 'Failed to load an image';
			case 'error.memberCanShare': return 'Only members can share the group';
			case 'error.moderatorCanShare': return 'Only moderators can share the group';
			case 'error.mustBeMemberToPost': return 'Only members are allowed to post prayers.';
			case 'error.needCorporatePrayerDescription': return 'Please provide a description for a corporate prayer';
			case 'error.needDayReminder': return 'Please select a day to send';
			case 'error.needGroupBanner': return 'Please upload a banner';
			case 'error.needGroupDescription': return 'Please provide a description for the group';
			case 'error.postNoPermission': return 'You have to be a member of the group';
			case 'error.viewNoPermission': return ({required Object membershipType}) => 'This group is ${membershipType}.\nJoin to see the prayers';
			case 'error.postPrayer': return 'Unable to post a prayer';
			case 'error.promoteUser': return 'Failed to promote the user';
			case 'error.provideReminderMessage': return 'Please provide a message to be sent';
			case 'error.revokeInvite': return 'Failed to revoke the invite';
			case 'error.signIn': return 'Failed to sign in. Please try again.';
			case 'error.unableUpdate': return 'Unable to update. Please try again later';
			case 'error.unknown': return 'Unknown error occured';
			case 'error.wrongUsernameFormat': return 'You can only use alphabets, numbers, period, and underscore for the username';
			case 'error.usernameRequired': return 'Username is required';
			case 'error.usernameTaken': return ({required Object username}) => 'Username ${username} is already taken';
			case 'bible.form.versePicker.title': return 'Pick your bible verse';
			case 'bible.form.translationPicker.title': return 'Choose a translation';
			case 'feedback.alert.sent': return 'Feedback has sent';
			case 'feedback.form.placeholder': return 'Feel free to reach out us';
			case 'placeholder.bibleVerse': return 'Pick your bible verse';
			case 'placeholder.search': return 'Search...';
			case 'donate.title': return 'Donate Now';
			case 'donate.card.title': return '${_root.donate.title}';
			case 'donate.card.description': return 'Help us spread the love of Jesus Christ.';
			case 'donate.message': return 'Join us in nurturing a community of faith and support. Our app offers a unique space for users to share and uplift through prayers, free from ads and without selling any data. We rely entirely on donations to keep this serene and safe platform running. Every contribution, big or small, makes a meaningful difference. Thank you for supporting this journey of fellowship and prayer.';
			case 'day.fri': return 'Fri';
			case 'day.mon': return 'Mon';
			case 'day.sat': return 'Sat';
			case 'day.sun': return 'Sun';
			case 'day.thu': return 'Thu';
			case 'day.tue': return 'Tue';
			case 'day.wed': return 'Wed';
			case 'empty.main.title': return 'Awaiting Your Love';
			case 'empty.main.description': return 'It seems we\'re just beginning. Share your love and be the beacon of Jesus Christ\'s love.';
			case 'empty.groupPrayer.title': return 'Share your first prayer with us';
			case 'empty.groupPrayer.description': return 'Take a heartfelt step in your spiritual journey';
			case 'empty.groupPrayer.button': return '${_root.general.pray}';
			case 'empty.corporatePrayer.title': return 'Witness a Miracle';
			case 'empty.corporatePrayer.description': return 'Post your first corporate prayer and watch as, in unity, miracles unfold.';
			case 'empty.corporatePrayer.reminder': return 'No reminder has been set for this corporate prayer';
			case 'empty.group.title': return 'Pray with Others';
			case 'empty.group.description': return 'Connect, share, and experience the power of collective prayer. Unite with others in faith and witness the extraordinary.';
			case 'empty.group.button': return '${_root.general.createGroup}';
			case 'empty.groupRules.title': return 'While this group doesn\'t have rules, we expect all members to maintain respectful and considerate interactions.';
			case 'empty.followersPrayer.title': return 'Companions on the Journey';
			case 'empty.followersPrayer.description': return 'Find comfort in companionship, and uplift each other through every step of your journey. Your path is unique, but you\'re not alone. Follow, lead, and grow in faith.';
			case 'empty.followersPrayer.button': return 'Search a companion';
			case 'empty.neighbor.title': return 'Pray for others to become their neighbor.';
			case 'empty.neighbor.description': return 'And the second is like it: ‘Love your neighbor as yourself.’ All the Law and the Prophets hang on these two commandments.\n\nMatthew 22:38-40 (NIV)';
			case 'banned.group_member.title': return 'You are permanently banned from the group for violating our group rules.';
			case 'banned.group_member.actions.0': return 'You are unable to post a prayer to the group.';
			case 'banned.group_member.actions.1': return 'At this moment, posting a pray to the group\'s prayer is not possible.';
			case 'banned.group_member.actions.2': return 'If moderators decide to remove you, you will not be able to rejoin the group.';
			default: return null;
		}
	}
}

extension on _StringsKo {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'introduction.title.0': return '기도로 연합';
			case 'introduction.title.1': return '믿음의 동반자';
			case 'introduction.title.2': return '공동의 믿음';
			case 'general.about': return '정보';
			case 'general.accept': return '승인';
			case 'general.accepted': return '승인됨';
			case 'general.account': return '계정';
			case 'general.admin': return '관리자';
			case 'general.anonymous': return '익명';
			case 'general.banUser': return ({required Object user}) => '${user} 차단';
			case 'general.unbanUser': return ({required Object user}) => '${user} 차단 해제';
			case 'general.bans': return '차단';
			case 'general.bio': return '바이오';
			case 'general.bible': return '성경';
			case 'general.blocked': return '차단됨';
			case 'general.blockUser': return ({required Object username}) => '${username} 차단';
			case 'general.bibleVerse': return '성경 구절';
			case 'general.cancel': return '취소';
			case 'general.prayer': return '기도문';
			case 'general.prayers': return '기도문';
			case 'general.prays': return '기도';
			case 'general.privacyPolicy': return '개인정보 처리방침';
			case 'general.private': return '비공개';
			case 'general.profile': return '프로필';
			case 'general.promote': return '임명';
			case 'general.promoteUser': return ({required Object user}) => '${user} 임명';
			case 'general.ratePrayer': return 'Prayer 리뷰 남기기';
			case 'general.readmore': return '더보기';
			case 'general.refresh': return '새로고침';
			case 'general.reminder': return '알림';
			case 'general.reminders': return '알림';
			case 'general.report': return '신고하기';
			case 'general.requested': return '요청됨';
			case 'general.requests': return '요청';
			case 'general.restricted': return '제한됨';
			case 'general.revoke': return '철회';
			case 'general.revoked': return '철회됨';
			case 'general.name': return '이름';
			case 'general.neighbor': return '이웃';
			case 'general.corporatePrayerPrayed': return '기도 완료';
			case 'general.corporatePrayerPraying': return '기도 중';
			case 'general.corporatePrayerPreparing': return '기도 준비 중';
			case 'general.corporate': return '중보 기도';
			case 'general.corporatePrayer': return '중보 기도';
			case 'general.create': return '생성';
			case 'general.endedAt': return '종료';
			case 'general.everyday': return '매일';
			case 'general.follow': return '팔로우';
			case 'general.followUser': return ({required Object username}) => '${username} 팔로우';
			case 'general.followers': return '팔로워';
			case 'general.following': return '팔로잉';
			case 'general.followings': return '팔로잉';
			case 'general.group': return '그룹';
			case 'general.invitation': return '초대';
			case 'general.invite': return '초대하기';
			case 'general.invited': return '초대됨';
			case 'general.invites': return '초대';
			case 'general.join': return '가입';
			case 'general.joined': return '가입됨';
			case 'general.leaveGroup': return '그룹 탈퇴';
			case 'general.legal': return '법률';
			case 'general.message': return '메시지';
			case 'general.moderator': return '사역자';
			case 'general.moderators': return '사역자들';
			case 'general.done': return '완료';
			case 'general.edit': return '수정';
			case 'general.startedAt': return '시작';
			case 'general.support': return '지원';
			case 'general.termsOfUse': return '이용약관';
			case 'general.test': return '테스트';
			case 'general.title': return '제목';
			case 'general.unblockUser': return ({required Object username}) => '${username} 차단 해제';
			case 'general.unfollow': return '언팔로우';
			case 'general.unfollowUser': return ({required Object username}) => '${username} 언팔로우';
			case 'general.username': return '아이디';
			case 'general.users': return '유저';
			case 'general.weekdays': return '주중';
			case 'general.notifications': return '알림';
			case 'general.weekend': return '주말';
			case 'general.community': return '커뮤니티';
			case 'general.createGroup': return '그룹 생성';
			case 'general.darkMode': return '다크 모드';
			case 'general.delete': return '삭제';
			case 'general.deleteGroup': return '그룹 삭제';
			case 'general.description': return '설명';
			case 'general.searchGroup': return '그룹 찾기';
			case 'general.sendInvitation': return '초대하기';
			case 'general.sendFeedback': return '피드백 보내기';
			case 'general.settings': return '설정';
			case 'general.open': return '공개';
			case 'general.postedByMe': return '내가 포스팅한 기도문';
			case 'general.pray': return '기도';
			case 'general.groups': return '그룹';
			case 'general.home': return '홈';
			case 'general.sharePrayer': return 'Prayer 공유하기';
			case 'general.signOut': return '로그아웃';
			case 'general.prayDuration': return '기도 기간';
			case 'general.praySilently': return '조용히 기도하기';
			case 'general.members': return '멤버들';
			case 'general.membersCount': return ({required num n, required Object membersCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(n,
				one: '${membersCount} 멤버',
				other: '${membersCount} 멤버들',
			);
			case 'general.membershipType': return '가입 조건';
			case 'general.removeFromGroup': return '강제 퇴장';
			case 'general.removeModerator': return '멤버로 전환';
			case 'general.pinPrayer': return '기도문 고정';
			case 'general.unpinPrayer': return '기도문 고정 해제';
			case 'general.pinnedBy': return ({required InlineSpan user}) => TextSpan(children: [
				user,
				const TextSpan(text: '에 의해 고정됨'),
			]);
			case 'general.myPost': return '내 기도문';
			case 'general.rule': return '규칙';
			case 'general.rules': return '규칙';
			case 'general.welcome': return '환영';
			case 'general.joinGroup': return '그룹 참가';
			case 'general.askJoin': return '가입 요청';
			case 'prayer.onlyVisibleToYou': return '나한테만 보임';
			case 'prayer.someoneHasPrayed': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 기도했습니다'),
			]);
			case 'prayer.alert.needWaitToPray.title': return '이미 기도하신 제목입니다';
			case 'prayer.alert.needWaitToPray.description': return '다음 침묵 기도는 5분 뒤에 할 수 있습니다. 잠시 스트레칭을 하거나 조용히 묵상하는 시간은 어떨까요?';
			case 'prayer.alert.prayWithName.title': return '공개적으로 기도하시겠습니까?';
			case 'prayer.alert.prayWithName.community': return '당신의 이름과 함께 기도문을 올리시겠습니까? 모든 사람이 당신의 기도문과 이름을 볼 수 있습니다.';
			case 'prayer.alert.prayWithName.group': return '그룹원이 당신의 이름과 함께 기도문을 볼 수 있습니다.';
			case 'prayer.alert.pinPrayer.title': return '이 기도문을 상단에 고정하시겠습니까?';
			case 'prayer.alert.pinPrayer.description': return '기존에 고정된 기도문과 대체됩니다.';
			case 'prayer.alert.unpinPrayer.title': return '이 기도문을 상단에서 내리겠습니까?';
			case 'prayer.form.pray.placeholder': return '사랑을 나눠주세요';
			case 'prayer.form.postAnonymously': return '익명으로 공유하기';
			case 'prayer.form.postPublicly': return '공개적으로 공유하기';
			case 'prayer.form.main.placeholder': return '하늘에 계신 우리 아버지...';
			case 'prayer.form.postType.title': return '어떻게 기도문을 공유하시겠습니까?';
			case 'prayer.form.postType.public.title': return '공개적으로 공유하기';
			case 'prayer.form.postType.public.description': return '사용자들이 당신의 기도문과 당신의 이름을 볼 수 있습니다';
			case 'prayer.form.postType.anonymous.title': return '익명으로 공유하기';
			case 'prayer.form.postType.anonymous.description': return '익명 기도문은 누가 올렸는지 확인할 수 없습니다';
			case 'auth.login.disclaimer': return ({required InlineSpan termsOfService, required InlineSpan privacyPolicy}) => TextSpan(children: [
				const TextSpan(text: '계속 진행함으로써 '),
				termsOfService,
				const TextSpan(text: '에 동의하고 '),
				privacyPolicy,
				const TextSpan(text: '이 적용된다는 것을 인지합니다.'),
			]);
			case 'auth.login.button.apple': return 'Apple로 로그인하기';
			case 'auth.login.button.google': return 'Google로 로그인하기';
			case 'auth.signup.bible.passage': return '항상 기뻐하라, 쉬지 말고 기도하라, 범사에 감사하라 이것이 그리스도 예수 안에서 너희를 향하신 하나님의 뜻이라';
			case 'auth.signup.bible.verse': return '데살로니가전서 5:16-18 (개역개정)';
			case 'group.alert.detail.title': return ({required Object membershipType}) => '이 그룹은 ${membershipType}입니다';
			case 'group.alert.detail.description.establishedAt': return ({required InlineSpan establishedAt, required InlineSpan user}) => TextSpan(children: [
				const TextSpan(text: '이 그룹은 '),
				establishedAt,
				const TextSpan(text: '애 '),
				user,
				const TextSpan(text: '에 의해 창설되었습니다'),
			]);
			case 'group.alert.detail.description.membershipType.open': return '누구나 그룹내 모든 기도문을 볼 수 있고, 가입을 자유롭게 할 수 있습니다.';
			case 'group.alert.detail.description.membershipType.restricted': return '그룹을 가입하기 위해 승인받거나 초대받아야하며, 그룹내 멤버들만 기도문을 볼 수 있습니다.';
			case 'group.alert.detail.description.membershipType.private': return '그룹이 검색되지 않고 초대를 통해서만 들어올 수 있습니다.';
			case 'group.alert.detail.prayerTime.empty': return '이 그룹은 지정된 기도 시간이 없습니다.';
			case 'group.alert.detail.prayerTime.time': return ({required InlineSpan day, required InlineSpan time}) => TextSpan(children: [
				const TextSpan(text: '이 그룹의 기도 시간은 '),
				day,
				const TextSpan(text: ' '),
				time,
				const TextSpan(text: '로 예정되어 있습니다. 해당 시간에 알림을 받게 됩니다.'),
			]);
			case 'group.alert.acceptMember': return ({required Object username}) => '${username}님을 승인하시겠습니까?';
			case 'group.alert.deleteGroup.0': return '1. 삭제는 되돌릴 수 없으며 즉시 이루어집니다.';
			case 'group.alert.deleteGroup.1': return '2. 모든 그룹 구성원은 자동으로 탈퇴됩니다.';
			case 'group.alert.deleteGroup.2': return '3. 그룹을 삭제하기 위해서는 모든 기도 및 중보기도를 삭제해야 합니다.';
			case 'group.alert.leaveGroup.0': return '1. 그룹에 가입하기 위해서는 다시 초대받거나 승인되어야 합니다';
			case 'group.alert.leaveGroup.1': return '2. 현재 사역자일 경우 다시 임명 받아야합니다.';
			case 'group.alert.leaveGroup.2': return '3. 그룹에 올린 기도문은 삭제되지 않습니다.';
			case 'group.alert.revokeInvitation': return ({required Object username}) => '${username}님의 초대를 취소하시겠습니까?';
			case 'group.alert.promote.title': return ({required Object name}) => '${name}님을 임명하시겠습니까?';
			case 'group.alert.promote.description.0': return '1. 사역자는 다른 사람을 초대하거나 가입 요청을 수락할 수 있습니다';
			case 'group.alert.promote.description.1': return '2. 사역자는 중보 기도문을 게시할 수 있습니다.';
			case 'group.alert.promote.description.2': return '3. 사역자는 다른 사람을 강제 퇴장하거나 밴 할 수 있습니다.';
			case 'group.alert.promote.success': return '멤버를 임명했습니다';
			case 'group.alert.ban.title': return ({required Object name}) => 'Ban ${name}';
			case 'group.alert.ban.description.0': return '1. 사용자는 즉시 차단됩니다.';
			case 'group.alert.ban.description.1': return '2. 사용자가 자동으로 그룹에서 제거되지 않습니다.';
			case 'group.alert.ban.description.2': return '3. 사용자는 기도문을 게시할 수 없습니다.';
			case 'group.alert.ban.description.3': return '4. 사용자는 그룹 내 기도문에 기도를 올릴 수 없습니다.';
			case 'group.alert.ban.description.4': return '5. 만약 사용자가 차단 이후에 그룹에서 제거 될 경우, 그룹에 다시 가입할 수 없습니다.';
			case 'group.alert.ban.success': return 'Member banned';
			case 'group.alert.kick.title': return ({required Object name}) => '${name}님을 그룹에서 제거하시겠습니까?';
			case 'group.alert.kick.subtitle': return '${_root.alert.actionIrreversible}';
			case 'group.alert.kick.description.0': return '1. 제거했다는 사실이 알려지지 않습니다.';
			case 'group.alert.kick.description.1': return '2. 유저가 다시 가입하거나 가입 신청할 수 있습니다.';
			case 'group.alert.kick.description.2': return '3. 만약 유저가 기존에 차단당했을 경우, 다시 가입하거나 가입 신청할 수 없습니다.';
			case 'group.alert.kick.description.3': return '4. 기존에 유저가 올린 기도문/중보기도문은 삭제되지 않습니다.';
			case 'group.alert.kick.description.4': return '5. 사역자일 경우 제거할 수 없습니다.';
			case 'group.alert.kick.success': return '멤버를 임명했습니다';
			case 'group.alert.removeMod.title': return ({required Object name}) => '${name}님을 일반 멤버로 전환하시겠습니까?';
			case 'group.alert.removeMod.subtitle': return '${_root.alert.actionIrreversible}';
			case 'group.alert.removeMod.description.0': return '기존에 사역자 권한이 즉시 박탈됩니다.';
			case 'group.welcome.title': return ({required Object group}) => '${group} 오신 것을 환영합니다';
			case 'group.welcome.description': return '이 영적 여정에서 저희를 동반자로 선택해 주셔서 감사합니다.  계속하기 전에, 예수 그리스도의 사랑으로 가득 찬 평화롭고 영적인 분위기를 조성하기 위해 마련된 우리의 지침들을 숙지해주시기 바랍니다.';
			case 'group.form.main.name.title': return '그룹 이름';
			case 'group.form.main.name.subtitle': return '이름은 30자 미만이어야 하며 해시태그 및 \'@\' 기호를 포함하지 않아야 합니다.';
			case 'group.form.main.description.title': return '그룹 설명';
			case 'group.form.main.description.subtitle': return '이 그룹이 어떤 그룹인지 알려주세요. 예) 목적, 미션, 기도제목';
			case 'group.form.main.membershipType.title': return '가입 조건';
			case 'group.form.main.membershipType.subtitle': return '누가 그룹을 가입할 수 있는지 선택해주세요. 이 선택은 나중에 바꿀 수 없습니다.';
			case 'group.form.main.membershipType.description': return ({required GroupMembershipTypeContext context}) {
				switch (context) {
					case GroupMembershipTypeContext.open:
						return '누구나 자유롭게 그룹내 기도문을 보고, 가입할 수 있습니다.';
					case GroupMembershipTypeContext.private:
						return '제한됨과 비슷하지만, 그룹이 검색되지 않고 초대를 통해서만 들어올 수 있습니다.';
					case GroupMembershipTypeContext.restricted:
						return '그룹을 가입하기 위해 승인받거나 초대받아야하며, 그룹내 멤버들만 기도문을 볼 수 있습니다.';
				}
			};
			case 'group.form.main.welcome.title': return '그룹 소개';
			case 'group.form.main.welcome.message': return '그룹 소개글';
			case 'group.form.main.welcome.description': return '소개는 유저가 그룹에 가입할때 보여집니다. 항상 \'그룹 정보\'를 클릭해 미리 볼 수 있습니다.';
			case 'group.form.notifications.members.title': return '${_root.general.members}';
			case 'group.form.notifications.members.description': return '그룹원이 기도문을 올릴때 알림을 받습니다.';
			case 'group.form.notifications.moderator.title': return '${_root.general.moderator}';
			case 'group.form.notifications.moderator.description': return '사역자가 기도문을 올릴때 알림을 받습니다.';
			case 'group.form.picker.title': return '그룹 선택';
			case 'group.form.invite.title': return ({required num n, required Object membersCount}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(n,
				one: '사용자 한 명을 초대하시겠습니까?',
				other: '${membersCount}명의 사람을 초대하시겠습니까?',
			);
			case 'group.form.invite.description': return '초대받은 사용자는 알림을 받고 관리자의 승인 없이 그룹에 가입할 수 있습니다. 다른 관리자가 이 초대를 철회할 수 도 있습니다.';
			case 'corporatePrayer.alert.deleteCorporatePrayer.title': return '중보기도 삭제';
			case 'corporatePrayer.alert.deleteCorporatePrayer.rules': return '중보기도에 있는 기도문은 삭제되지 않습니다.';
			case 'corporatePrayer.alert.deleteCorporatePrayer.prompt': return '정말 중보기도를 삭제하시겠습니까?';
			case 'corporatePrayer.form.main.bible.passage': return '빌기를 다하매 모인 곳이 진동하더니 무리가 다 성령이 충만하여 담대히 하나님의 말씀을 전하니라';
			case 'corporatePrayer.form.main.bible.verse': return '- 사도행전 4:31 (개역개정)';
			case 'corporatePrayer.form.main.reminder.title': return '${_root.general.reminder}';
			case 'corporatePrayer.form.main.reminder.description': return '내 시간대를 기준으로 다른 사람에게 알림이 전송됩니다';
			case 'corporatePrayer.form.main.reminder.placeholder': return '기도 시간 입니다...';
			case 'corporatePrayer.form.main.duration.title': return '${_root.general.prayDuration}';
			case 'corporatePrayer.form.main.duration.description': return '기도 기간이 끝나면 알림이 전송되지 않습니다';
			case 'corporatePrayer.form.picker.title': return '중보기도 선택';
			case 'corporatePrayer.form.notifications.reminder.title': return '${_root.general.reminder}';
			case 'corporatePrayer.form.notifications.reminder.description': return ({required Object fromDays, required Object toDays}) => '이 알림은 ${fromDays}부터 ${toDays}까지 전송됩니다';
			case 'corporatePrayer.form.notifications.members.title': return '${_root.general.members}';
			case 'corporatePrayer.form.notifications.members.description': return '${_root.group.form.notifications.members.description}';
			case 'alert.imagePicker.title': return '이미지 선택';
			case 'alert.imagePicker.pickImageFromGallery': return '갤러리에서 사진 가져오기';
			case 'alert.imagePicker.resetToDefault': return '기본값으로 초기화';
			case 'alert.imagePicker.removeCurrentPhoto': return '현재 사진 제거하기';
			case 'alert.update.title': return 'Prayer 업데이트';
			case 'alert.update.description': return '새 업데이트를 다운로드하여 더 나은 기도와 신앙 생활을 경험하세요';
			case 'alert.update.button': return '업데이트';
			case 'alert.confirmClose': return '정말로 닫으시겠습니까?';
			case 'alert.actionIrreversible': return '이 작업은 취소할 수 없습니다';
			case 'alert.deleteAccount.title': return '정말 계정을 삭제하시겠습니까?';
			case 'alert.deleteAccount.rules.0': return '1. 사용자는 즉시 삭제됩니다.';
			case 'alert.deleteAccount.rules.1': return '2. 사용자는 삭제되면 복구할 수 없습니다.';
			case 'alert.deleteAccount.rules.2': return '3. 사용자는 자신이 소유한 모든 그룹을 삭제해야 합니다.';
			case 'alert.deleteAccount.rules.3': return '4. 사용자는 자신이 속한 모든 그룹을 탈퇴해야 합니다.';
			case 'alert.deleteAccount.rules.4': return '5. 사용자는 모든 중보 기도를 삭제해야됩니다.';
			case 'alert.deleteAccount.prompt': return '계정을 삭제하시겠습니까?';
			case 'alert.blockUser.0': return '1. 사용자가 당신을 차단했다는 사실을 모를 거예요.';
			case 'alert.blockUser.1': return '2. 사용자는 당신의 기도, 그룹, 프로필을 볼 수 없게 됩니다.';
			case 'alert.blockUser.2': return '3. 사용자는 당신을 검색 할 수 없습니다.';
			case 'neighbor.alert.title': return '${_root.alert.confirmClose}';
			case 'neighbor.alert.subtitle': return '이웃 탭을 클릭하면 언제든지 다시 확인할 수 있습니다.';
			case 'neighbor.card.title': return '누가 제 이웃인가요?';
			case 'neighbor.card.description': return '다른 사람을 위해 기도하면, 그 사람이 이웃이 되고, 내가 기도한 사람들의 추후 기도문을 계속 볼 수 있습니다.';
			case 'settings.shareAppMessage': return ({required Object url}) => '지금 \'Prayer\' 앱에서 서로의 기도를 나누고, 기도 요청을 올리고 다른 사람들을 위해 기도해주세요.\n\n${url}';
			case 'settings.versionText': return ({required InlineSpan version}) => TextSpan(children: [
				const TextSpan(text: '버전: '),
				version,
			]);
			case 'notification.plain.groupAccepted': return ({required Object group}) => '${group}의 그룹원이 되었습니다';
			case 'notification.plain.someoneFollowed': return ({required Object username}) => '${username}님이 당신을 팔로우 했습니다';
			case 'notification.plain.groupJoinRequested': return ({required Object username}) => '${username}님이 가입을 요청했습니다';
			case 'notification.plain.someoneJoinedGroup': return ({required Object username}) => '${username}님이 그룹원이 되었습니다';
			case 'notification.plain.postedCorporatePrayer': return ({required Object username}) => '${username}님이 중보기도문을 올렸습니다';
			case 'notification.plain.postedPrayer': return ({required Object username}) => '${username}님이 기도문을 올렸습니다';
			case 'notification.plain.prayed': return ({required Object username}) => '${username}님이 기도했습니다';
			case 'notification.plain.groupPromoted': return ({required Object group}) => '${group}의 사역자가 되었습니다';
			case 'notification.groupAccepted': return ({required InlineSpan group}) => TextSpan(children: [
				group,
				const TextSpan(text: '의 그룹원이 되었습니다'),
			]);
			case 'notification.someoneFollowed': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 당신을 팔로우 했습니다'),
			]);
			case 'notification.groupJoinRequested': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 가입을 요청했습니다'),
			]);
			case 'notification.someoneJoinedGroup': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 그룹원이 되었습니다'),
			]);
			case 'notification.postedCorporatePrayer': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 중보기도문을 올렸습니다'),
			]);
			case 'notification.postedPrayer': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 기도문을 올렸습니다'),
			]);
			case 'notification.prayed': return ({required InlineSpan username}) => TextSpan(children: [
				username,
				const TextSpan(text: '님이 기도했습니다'),
			]);
			case 'notification.groupPromoted': return ({required InlineSpan group}) => TextSpan(children: [
				group,
				const TextSpan(text: '의 사역자가 되었습니다'),
			]);
			case 'error.connection.title': return '연결 오류';
			case 'error.connection.description': return '우리 기도 커뮤니티에 연결하는 데 일시적인 문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.';
			case 'error.acceptUser': return '유저 승인에 실패했습니다';
			case 'error.noPermissionPhotos': return '사진 접근 권한을 허용해주세요.';
			case 'error.adminLeaveGroup': return '관리자는 그룹을 떠날 수 없습니다';
			case 'error.checkingUsernameExists': return '오류가 발생했습니다';
			case 'error.chooseUserToInvite': return '초대할 사용자를 선택해 주세요';
			case 'error.corporatePrayerHasSpecialCharacters': return '이름에는 \'#\' 또는 \'@\' 기호를 포함할 수 없습니다';
			case 'error.corporatePrayerMustNotEmpty': return '이름은 최소한 하나의 공백이 아닌 문자를 포함해야 합니다';
			case 'error.corporatePrayerNeedPrayers': return '중보기도를 위한 기도문을 적어주세요';
			case 'error.createGroup': return '그룹 생성에 실패했습니다';
			case 'error.deleteGroup': return '그룹 삭제에 실패했습니다';
			case 'error.deletePray': return '삭제에 실패하였습니다';
			case 'error.deleteUser': return '탈퇴하기 전에 모든 단계를 따라 주세요.';
			case 'error.editGroup': return '그룹 수정에 실패했습니다';
			case 'error.emptyPrayer': return '기도문은 최소한 하나의 공백이 아닌 문자를 포함해야 합니다';
			case 'error.enterName': return '이름을 입력해주세요';
			case 'error.fieldRequired': return '필수 입력란입니다';
			case 'error.fullLocalReminders': return ({required Object max}) => '최대 ${max}개의 알림을 설정할 수 있습니다';
			case 'error.joinGroup': return '그룹 참가에 실패했습니다';
			case 'error.leaveGroup': return '그룹 탈퇴에 실패했습니다';
			case 'error.loadImage': return '이미지 로딩에 실패하였습니다';
			case 'error.memberCanShare': return '그룹 멤버만 공유 할 수 있습니다';
			case 'error.moderatorCanShare': return '사역자만 그룹을 공유 할 수 있습니다';
			case 'error.mustBeMemberToPost': return '그룹 멤버만 작성할 수 있습니다';
			case 'error.needCorporatePrayerDescription': return '중보기도 설명을 적어주세요';
			case 'error.needDayReminder': return '보내질 날을 선택해주세요';
			case 'error.needGroupBanner': return '배너 이미지를 업로드해주세요';
			case 'error.needGroupDescription': return '그룹 설명을 적어주세요';
			case 'error.postNoPermission': return '그룹 멤버만 작성할 수 있습니다';
			case 'error.viewNoPermission': return ({required Object membershipType}) => '이 그룹은 ${membershipType} 입니다.\n멤버만 볼 수 있습니다.';
			case 'error.postPrayer': return '기도문 게시에 실패하였습니다';
			case 'error.promoteUser': return '유저를 임명하는데에 실패하였습니다';
			case 'error.provideReminderMessage': return '멤버들에게 전해질 메시지를 적어주세요';
			case 'error.revokeInvite': return '초대 철회에 실패하였습니다';
			case 'error.signIn': return '로그인에 실패하였습니다. 다시 시도해주세요.';
			case 'error.unableUpdate': return '업데이트에 실패하였습니다';
			case 'error.unknown': return '알 수 없는 오류가 발생했습니다';
			case 'error.wrongUsernameFormat': return '아이디는 알파벳, 숫자, 마침표, 밑줄만 사용가능합니다';
			case 'error.usernameRequired': return '아이디를 입력해주세요';
			case 'error.usernameTaken': return ({required Object username}) => '${username}이 이미 사용중 입니다';
			case 'bible.form.versePicker.title': return '성경 구절 고르기';
			case 'bible.form.translationPicker.title': return '번역 선택하기';
			case 'feedback.alert.sent': return '피드백이 전송되었습니다';
			case 'feedback.form.placeholder': return '저희에게 연락 주세요';
			case 'placeholder.bibleVerse': return '성경 구절을 고르세요';
			case 'placeholder.search': return '검색...';
			case 'donate.title': return '후원하기';
			case 'donate.card.title': return '후원하기';
			case 'donate.card.description': return '예수님의 사랑을 널리 퍼뜨릴 수 있도록 도와주세요.';
			case 'donate.message': return '크리스쳔 커뮤니티를 지키는데 힘을 실어주세요. 저희 앱은 사용자들이 기도를 통해 서로를 격려하고 위로할 수 있는 공간을 제공하고 평화롭고 안전한 플랫폼을 유지하기 위해 힘쓰고 있습니다. Prayer는 어떠한 광고나 사용자 데이터의 판매없이 전적으로 기부에 의존하고 있습니다. 크든 작든 모든 기부는 커뮤니티를 지켜나가는데 힘이 됩니다. 기도의 여정을 지원해 주셔서 감사합니다.';
			case 'day.fri': return '금';
			case 'day.mon': return '월';
			case 'day.sat': return '토';
			case 'day.sun': return '일';
			case 'day.thu': return '목';
			case 'day.tue': return '화';
			case 'day.wed': return '수';
			case 'empty.main.title': return '기도의 손길';
			case 'empty.main.description': return '씨앗이 뿌려졌습니다. 사랑을 나누고 예수 그리스도의 사랑의 빛이 되어주세요.';
			case 'empty.groupPrayer.title': return '첫 기도문을 올리고 하나님의 기적을 경험하세요.';
			case 'empty.groupPrayer.description': return '영적 여정에서 진심을 담은 첫걸음을 내디뎌보세요.';
			case 'empty.groupPrayer.button': return '기도하기';
			case 'empty.corporatePrayer.title': return '기적의 증인이 되는 삶';
			case 'empty.corporatePrayer.description': return '첫 중보기도를 올리고 함께 기적을 목격하세요.';
			case 'empty.corporatePrayer.reminder': return '이 중보기도는 알림이 없습니다';
			case 'empty.group.title': return '다른 사람과 기도해보세요';
			case 'empty.group.description': return '연결되고 나누어 중보기도의 힘을 경험하세요. 다른 이들과 신앙 안에서 하나가 되어 놀라운 일을 목격하세요.';
			case 'empty.group.button': return '그룹 생성하기';
			case 'empty.groupRules.title': return '이 그룹에는 정해진 규칙이 없지만, 모든 멤버들의 존중과 배려를 부탁드립니다.';
			case 'empty.followersPrayer.title': return '믿음의 동반자';
			case 'empty.followersPrayer.description': return '동행에서 위안을 찾고, 여정의 모든 단계에서 서로를 격려하세요. 당신의 길은 특별하지만, 혼자가 아닙니다.';
			case 'empty.followersPrayer.button': return '동반자 찾기';
			case 'empty.neighbor.title': return '남을 위해 기도하면, 그들은 우리의 신앙 이웃이 됩니다.';
			case 'empty.neighbor.description': return '둘째도 그와 같으니 네 이웃을 네 자신 같이 사랑하라 하셨으니 모든 율법과 선지자의 가르침이 이 두 계명에 달려있다.\n\n마태복음 22:38-40 (개역개정)';
			case 'banned.group_member.title': return '당신은 그룹 규칙을 위반하여 그룹에서 영구적으로 제외되었습니다.';
			case 'banned.group_member.actions.0': return '당신은 그룹에 기도문를 올릴 수 없습니다.';
			case 'banned.group_member.actions.1': return '현재로서는 그룹의 기도문에 기도를 올리는 것이 불가능합니다.';
			case 'banned.group_member.actions.2': return '만약 운영진이 당신을 제거하기로 결정한다면, 그룹에 다시 가입할 수 없습니다.';
			default: return null;
		}
	}
}
