// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Accept @{username}?`
  String alertAcceptMember(Object username) {
    return Intl.message(
      'Accept @$username?',
      name: 'alertAcceptMember',
      desc: '',
      args: [username],
    );
  }

  /// `1. Deletion is irreversible and immediate.:2. All group members will be removed automatically.:3. All prayers, both corporate and individual, must be deleted to remove the group.`
  String get alertDeleteGroup {
    return Intl.message(
      '1. Deletion is irreversible and immediate.:2. All group members will be removed automatically.:3. All prayers, both corporate and individual, must be deleted to remove the group.',
      name: 'alertDeleteGroup',
      desc: '',
      args: [],
    );
  }

  /// `Feedback has sent`
  String get alertFeedbackSent {
    return Intl.message(
      'Feedback has sent',
      name: 'alertFeedbackSent',
      desc: '',
      args: [],
    );
  }

  /// `1. You need to be reaccepted to join the group.:2. You need to be repromoted to regain moderator status.:3. None of your prayers will be deleted.`
  String get alertLeaveGroup {
    return Intl.message(
      '1. You need to be reaccepted to join the group.:2. You need to be repromoted to regain moderator status.:3. None of your prayers will be deleted.',
      name: 'alertLeaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to pray using your name? Please be aware that if you do, everyone will be able to see your prayer along with your name.`
  String get alertPrayWithName {
    return Intl.message(
      'Do you want to pray using your name? Please be aware that if you do, everyone will be able to see your prayer along with your name.',
      name: 'alertPrayWithName',
      desc: '',
      args: [],
    );
  }

  /// `Revoke an invitation of @{username}?`
  String alertRevokeInvitation(Object username) {
    return Intl.message(
      'Revoke an invitation of @$username?',
      name: 'alertRevokeInvitation',
      desc: '',
      args: [username],
    );
  }

  /// `You cannot undo this action`
  String get alertYouCannotUndoThisAction {
    return Intl.message(
      'You cannot undo this action',
      name: 'alertYouCannotUndoThisAction',
      desc: '',
      args: [],
    );
  }

  /// `Amen`
  String get amen {
    return Intl.message(
      'Amen',
      name: 'amen',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get anonymous {
    return Intl.message(
      'Anonymous',
      name: 'anonymous',
      desc: '',
      args: [],
    );
  }

  /// `Anonymously`
  String get anonymously {
    return Intl.message(
      'Anonymously',
      name: 'anonymously',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting Your Love`
  String get awaitingLove {
    return Intl.message(
      'Awaiting Your Love',
      name: 'awaitingLove',
      desc: '',
      args: [],
    );
  }

  /// `It seems we're just beginning. Share your love and be the beacon of Jesus Christ's love.`
  String get awaitingLoveDescription {
    return Intl.message(
      'It seems we\'re just beginning. Share your love and be the beacon of Jesus Christ\'s love.',
      name: 'awaitingLoveDescription',
      desc: '',
      args: [],
    );
  }

  /// `Bible`
  String get bible {
    return Intl.message(
      'Bible',
      name: 'bible',
      desc: '',
      args: [],
    );
  }

  /// `After they prayed, the place where they were meeting was shaken. And they were all filled with the Holy Spirit and spoke the word of God boldly.`
  String get bibleCorporatePrayerScreenVerse {
    return Intl.message(
      'After they prayed, the place where they were meeting was shaken. And they were all filled with the Holy Spirit and spoke the word of God boldly.',
      name: 'bibleCorporatePrayerScreenVerse',
      desc: '',
      args: [],
    );
  }

  /// `- Acts 4:31 (NIV)`
  String get bibleCorporatePrayerScreenVerseBook {
    return Intl.message(
      '- Acts 4:31 (NIV)',
      name: 'bibleCorporatePrayerScreenVerseBook',
      desc: '',
      args: [],
    );
  }

  /// `Bible Verse`
  String get bibleVerse {
    return Intl.message(
      'Bible Verse',
      name: 'bibleVerse',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Block {username}`
  String blockUser(Object username) {
    return Intl.message(
      'Block $username',
      name: 'blockUser',
      desc: '',
      args: [username],
    );
  }

  /// `1. The user will not be aware that you have blocked them.:2. The user will not be able to view your prayers, group, or profile.:3. The user will be unable to search for you.`
  String get blockUserDescription {
    return Intl.message(
      '1. The user will not be aware that you have blocked them.:2. The user will not be able to view your prayers, group, or profile.:3. The user will be unable to search for you.',
      name: 'blockUserDescription',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get blocked {
    return Intl.message(
      'Blocked',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Corporate Prayer`
  String get chooseCorporatePrayer {
    return Intl.message(
      'Choose a Corporate Prayer',
      name: 'chooseCorporatePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Group`
  String get chooseGroup {
    return Intl.message(
      'Choose a Group',
      name: 'chooseGroup',
      desc: '',
      args: [],
    );
  }

  /// `Choose a translation`
  String get chooseTranslation {
    return Intl.message(
      'Choose a translation',
      name: 'chooseTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Companions on the Journey`
  String get companionsOnTheJourney {
    return Intl.message(
      'Companions on the Journey',
      name: 'companionsOnTheJourney',
      desc: '',
      args: [],
    );
  }

  /// `Find comfort in companionship, and uplift each other through every step of your journey. Your path is unique, but you're not alone. Follow, lead, and grow in faith.`
  String get companionsOnTheJourneyDescription {
    return Intl.message(
      'Find comfort in companionship, and uplift each other through every step of your journey. Your path is unique, but you\'re not alone. Follow, lead, and grow in faith.',
      name: 'companionsOnTheJourneyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Corporate`
  String get corporate {
    return Intl.message(
      'Corporate',
      name: 'corporate',
      desc: '',
      args: [],
    );
  }

  /// `Prayed`
  String get corporatePrayerPrayed {
    return Intl.message(
      'Prayed',
      name: 'corporatePrayerPrayed',
      desc: '',
      args: [],
    );
  }

  /// `Praying`
  String get corporatePrayerPraying {
    return Intl.message(
      'Praying',
      name: 'corporatePrayerPraying',
      desc: '',
      args: [],
    );
  }

  /// `Preparing`
  String get corporatePrayerPreparing {
    return Intl.message(
      'Preparing',
      name: 'corporatePrayerPreparing',
      desc: '',
      args: [],
    );
  }

  /// `After the duration of prayers has elapsed, they will be marked as concluded, and reminders will not be sent.`
  String get corporatePrayerReminderMesasge {
    return Intl.message(
      'After the duration of prayers has elapsed, they will be marked as concluded, and reminders will not be sent.',
      name: 'corporatePrayerReminderMesasge',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Create a Group`
  String get createGroup {
    return Intl.message(
      'Create a Group',
      name: 'createGroup',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get dayFri {
    return Intl.message(
      'Fri',
      name: 'dayFri',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get dayMon {
    return Intl.message(
      'Mon',
      name: 'dayMon',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get daySat {
    return Intl.message(
      'Sat',
      name: 'daySat',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get daySun {
    return Intl.message(
      'Sun',
      name: 'daySun',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get dayThu {
    return Intl.message(
      'Thu',
      name: 'dayThu',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get dayTue {
    return Intl.message(
      'Tue',
      name: 'dayTue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get dayWen {
    return Intl.message(
      'Wed',
      name: 'dayWen',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete an account`
  String get deleteAccount {
    return Intl.message(
      'Delete an account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete a Group`
  String get deleteGroup {
    return Intl.message(
      'Delete a Group',
      name: 'deleteGroup',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `1. Users will be immediately deleted.:2. Users cannot recover once they are deleted.:3. Users must delete all the groups they own.:4. Users must leave all the groups to which they belong.:5. Users must not have any corporate prayers.`
  String get descriptionDeleteAccount {
    return Intl.message(
      '1. Users will be immediately deleted.:2. Users cannot recover once they are deleted.:3. Users must delete all the groups they own.:4. Users must leave all the groups to which they belong.:5. Users must not have any corporate prayers.',
      name: 'descriptionDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `All prayers in corporate prayers will not be deleted.`
  String get descriptionDeleteCorporatePrayer {
    return Intl.message(
      'All prayers in corporate prayers will not be deleted.',
      name: 'descriptionDeleteCorporatePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Join us in nurturing a community of faith and support. Our app offers a unique space for users to share and uplift through prayers, free from ads and without selling any data. We rely entirely on donations to keep this serene and safe platform running. Every contribution, big or small, makes a meaningful difference. Thank you for supporting this journey of fellowship and prayer.`
  String get descriptionNeedDonation {
    return Intl.message(
      'Join us in nurturing a community of faith and support. Our app offers a unique space for users to share and uplift through prayers, free from ads and without selling any data. We rely entirely on donations to keep this serene and safe platform running. Every contribution, big or small, makes a meaningful difference. Thank you for supporting this journey of fellowship and prayer.',
      name: 'descriptionNeedDonation',
      desc: '',
      args: [],
    );
  }

  /// `Let's give it a 5-minute grace period to soar high. How about a quick stretch or a moment of quiet reflection? Ready for your next prayer in a jiffy!`
  String get descriptionYourPrayerHasBeenReceived {
    return Intl.message(
      'Let\'s give it a 5-minute grace period to soar high. How about a quick stretch or a moment of quiet reflection? Ready for your next prayer in a jiffy!',
      name: 'descriptionYourPrayerHasBeenReceived',
      desc: '',
      args: [],
    );
  }

  /// `Donate Now`
  String get donatePrayer {
    return Intl.message(
      'Donate Now',
      name: 'donatePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Help us spread the love of Jesus Christ.`
  String get donatePrayerDescription {
    return Intl.message(
      'Help us spread the love of Jesus Christ.',
      name: 'donatePrayerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Post your first prayer and watch as, in unity, miracles unfold.`
  String get emptyCorporatePrayerDescription {
    return Intl.message(
      'Post your first prayer and watch as, in unity, miracles unfold.',
      name: 'emptyCorporatePrayerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Witness a Miracle`
  String get emptyCorporatePrayerTitle {
    return Intl.message(
      'Witness a Miracle',
      name: 'emptyCorporatePrayerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Connect, share, and experience the power of collective prayer. Unite with others in faith and witness the extraordinary.`
  String get emptyGroupDescription {
    return Intl.message(
      'Connect, share, and experience the power of collective prayer. Unite with others in faith and witness the extraordinary.',
      name: 'emptyGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Ended At`
  String get endedAt {
    return Intl.message(
      'Ended At',
      name: 'endedAt',
      desc: '',
      args: [],
    );
  }

  /// `Failed to accept the user`
  String get errorAcceptUser {
    return Intl.message(
      'Failed to accept the user',
      name: 'errorAcceptUser',
      desc: '',
      args: [],
    );
  }

  /// `Prayers does not have an access to your photos.`
  String get errorAccessPhoto {
    return Intl.message(
      'Prayers does not have an access to your photos.',
      name: 'errorAccessPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Admin cannot leave the group`
  String get errorAdminLeaveGroup {
    return Intl.message(
      'Admin cannot leave the group',
      name: 'errorAdminLeaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Error while checking your username`
  String get errorCheckingUsernameExists {
    return Intl.message(
      'Error while checking your username',
      name: 'errorCheckingUsernameExists',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a user to invite`
  String get errorChooseUserToInvite {
    return Intl.message(
      'Please choose a user to invite',
      name: 'errorChooseUserToInvite',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get errorConnection {
    return Intl.message(
      'Connection Error',
      name: 'errorConnection',
      desc: '',
      args: [],
    );
  }

  /// `We're experiencing a temporary issue connecting you to our prayer community. Please retry shortly. May your faith remain strong during this brief interruption.`
  String get errorConnectionDescription {
    return Intl.message(
      'We\'re experiencing a temporary issue connecting you to our prayer community. Please retry shortly. May your faith remain strong during this brief interruption.',
      name: 'errorConnectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Name must not include the '#' or the '@' symbol`
  String get errorCorporatePrayerHasSpecialCharacters {
    return Intl.message(
      'Name must not include the \'#\' or the \'@\' symbol',
      name: 'errorCorporatePrayerHasSpecialCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Name must include at least one non-whitespace character`
  String get errorCorporatePrayerMustNotEmpty {
    return Intl.message(
      'Name must include at least one non-whitespace character',
      name: 'errorCorporatePrayerMustNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a prayer for corporate prayer`
  String get errorCorporatePrayerNeedPrayers {
    return Intl.message(
      'Please provide a prayer for corporate prayer',
      name: 'errorCorporatePrayerNeedPrayers',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create a group`
  String get errorCreateGroup {
    return Intl.message(
      'Failed to create a group',
      name: 'errorCreateGroup',
      desc: '',
      args: [],
    );
  }

  /// `Unable to delete a group`
  String get errorDeleteGroup {
    return Intl.message(
      'Unable to delete a group',
      name: 'errorDeleteGroup',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete a pray`
  String get errorDeletePray {
    return Intl.message(
      'Failed to delete a pray',
      name: 'errorDeletePray',
      desc: '',
      args: [],
    );
  }

  /// `Please follow all the steps before deleting a user.`
  String get errorDeleteUser {
    return Intl.message(
      'Please follow all the steps before deleting a user.',
      name: 'errorDeleteUser',
      desc: '',
      args: [],
    );
  }

  /// `Failed to edit a group`
  String get errorEditGroup {
    return Intl.message(
      'Failed to edit a group',
      name: 'errorEditGroup',
      desc: '',
      args: [],
    );
  }

  /// `Prayer must include at least one non-whitespace character`
  String get errorEmptyPrayer {
    return Intl.message(
      'Prayer must include at least one non-whitespace character',
      name: 'errorEmptyPrayer',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get errorEnterName {
    return Intl.message(
      'Please enter your name',
      name: 'errorEnterName',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get errorFieldRequired {
    return Intl.message(
      'This field is required',
      name: 'errorFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Failed to follow the user`
  String get errorFollowUser {
    return Intl.message(
      'Failed to follow the user',
      name: 'errorFollowUser',
      desc: '',
      args: [],
    );
  }

  /// `You can set up to {max} reminders`
  String errorFullReminders(Object max) {
    return Intl.message(
      'You can set up to $max reminders',
      name: 'errorFullReminders',
      desc: '',
      args: [max],
    );
  }

  /// `Failed to join the group`
  String get errorJoinGroup {
    return Intl.message(
      'Failed to join the group',
      name: 'errorJoinGroup',
      desc: '',
      args: [],
    );
  }

  /// `Failed to leave the group`
  String get errorLeaveGroup {
    return Intl.message(
      'Failed to leave the group',
      name: 'errorLeaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load an image`
  String get errorLoadImage {
    return Intl.message(
      'Failed to load an image',
      name: 'errorLoadImage',
      desc: '',
      args: [],
    );
  }

  /// `Only members can share the group`
  String get errorMemberShare {
    return Intl.message(
      'Only members can share the group',
      name: 'errorMemberShare',
      desc: '',
      args: [],
    );
  }

  /// `Only moderators can share the group`
  String get errorModeratorShare {
    return Intl.message(
      'Only moderators can share the group',
      name: 'errorModeratorShare',
      desc: '',
      args: [],
    );
  }

  /// `Only moderators are allowed to post corporate prayers.`
  String get errorMustBeModeratorToPost {
    return Intl.message(
      'Only moderators are allowed to post corporate prayers.',
      name: 'errorMustBeModeratorToPost',
      desc: '',
      args: [],
    );
  }

  /// `Names must be less than 30 characters and do not include hashtag and or the '@' symbol.`
  String get errorNameLessThan30Characters {
    return Intl.message(
      'Names must be less than 30 characters and do not include hashtag and or the \'@\' symbol.',
      name: 'errorNameLessThan30Characters',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a description for a corporate prayer`
  String get errorNeedCorporatePrayerDescription {
    return Intl.message(
      'Please provide a description for a corporate prayer',
      name: 'errorNeedCorporatePrayerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please select a day to send`
  String get errorNeedDayReminder {
    return Intl.message(
      'Please select a day to send',
      name: 'errorNeedDayReminder',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a banner`
  String get errorNeedGroupBanner {
    return Intl.message(
      'Please upload a banner',
      name: 'errorNeedGroupBanner',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a description for the group`
  String get errorNeedGroupDescription {
    return Intl.message(
      'Please provide a description for the group',
      name: 'errorNeedGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please choose one of the type`
  String get errorNeedMembershipType {
    return Intl.message(
      'Please choose one of the type',
      name: 'errorNeedMembershipType',
      desc: '',
      args: [],
    );
  }

  /// `You have to be a member of the group`
  String get errorNeedPermissionToPost {
    return Intl.message(
      'You have to be a member of the group',
      name: 'errorNeedPermissionToPost',
      desc: '',
      args: [],
    );
  }

  /// `This group is {membershipType}.\nJoin to see the prayers`
  String errorNeedPermissionToView(Object membershipType) {
    return Intl.message(
      'This group is $membershipType.\nJoin to see the prayers',
      name: 'errorNeedPermissionToView',
      desc: '',
      args: [membershipType],
    );
  }

  /// `Unable to post a prayer`
  String get errorPostPrayer {
    return Intl.message(
      'Unable to post a prayer',
      name: 'errorPostPrayer',
      desc: '',
      args: [],
    );
  }

  /// `Failed to promote the user`
  String get errorPromoteUser {
    return Intl.message(
      'Failed to promote the user',
      name: 'errorPromoteUser',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a message to be sent`
  String get errorProvideReminderMessage {
    return Intl.message(
      'Please provide a message to be sent',
      name: 'errorProvideReminderMessage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to revoke the invite`
  String get errorRevokeInvite {
    return Intl.message(
      'Failed to revoke the invite',
      name: 'errorRevokeInvite',
      desc: '',
      args: [],
    );
  }

  /// `Failed to sign in. Please try again.`
  String get errorSignIn {
    return Intl.message(
      'Failed to sign in. Please try again.',
      name: 'errorSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Unable to update. Please try again later`
  String get errorUnableToUpdate {
    return Intl.message(
      'Unable to update. Please try again later',
      name: 'errorUnableToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error occured`
  String get errorUnknown {
    return Intl.message(
      'Unknown error occured',
      name: 'errorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `You can only use alphabets, numbers, period, and underscore for the username`
  String get errorUsernameFormat {
    return Intl.message(
      'You can only use alphabets, numbers, period, and underscore for the username',
      name: 'errorUsernameFormat',
      desc: '',
      args: [],
    );
  }

  /// `Username is required`
  String get errorUsernameReqruied {
    return Intl.message(
      'Username is required',
      name: 'errorUsernameReqruied',
      desc: '',
      args: [],
    );
  }

  /// `Username {username} is already taken`
  String errorUsernameTaken(Object username) {
    return Intl.message(
      'Username $username is already taken',
      name: 'errorUsernameTaken',
      desc: '',
      args: [username],
    );
  }

  /// `Everyday`
  String get everyday {
    return Intl.message(
      'Everyday',
      name: 'everyday',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Follow {username}`
  String followUser(Object username) {
    return Intl.message(
      'Follow $username',
      name: 'followUser',
      desc: '',
      args: [username],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Followings`
  String get followings {
    return Intl.message(
      'Followings',
      name: 'followings',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Group Description`
  String get groupDescription {
    return Intl.message(
      'Group Description',
      name: 'groupDescription',
      desc: '',
      args: [],
    );
  }

  /// `3. This group was established at {establishedAt}`
  String groupEstablishedAt(Object establishedAt) {
    return Intl.message(
      '3. This group was established at $establishedAt',
      name: 'groupEstablishedAt',
      desc: '',
      args: [establishedAt],
    );
  }

  /// `Group Name`
  String get groupName {
    return Intl.message(
      'Group Name',
      name: 'groupName',
      desc: '',
      args: [],
    );
  }

  /// `Notify when the prayer is posted to the group.`
  String get groupNotificationSettingsAll {
    return Intl.message(
      'Notify when the prayer is posted to the group.',
      name: 'groupNotificationSettingsAll',
      desc: '',
      args: [],
    );
  }

  /// `Notify when the moderator posts a prayer.`
  String get groupNotificationSettingsModerator {
    return Intl.message(
      'Notify when the moderator posts a prayer.',
      name: 'groupNotificationSettingsModerator',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `United in Prayer \nStronger Together \nCollective Faith`
  String get introductionTitle {
    return Intl.message(
      'United in Prayer \nStronger Together \nCollective Faith',
      name: 'introductionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Invitation`
  String get invitation {
    return Intl.message(
      'Invitation',
      name: 'invitation',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message(
      'Invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `Invited`
  String get invited {
    return Intl.message(
      'Invited',
      name: 'invited',
      desc: '',
      args: [],
    );
  }

  /// `Invites`
  String get invites {
    return Intl.message(
      'Invites',
      name: 'invites',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Joined`
  String get joined {
    return Intl.message(
      'Joined',
      name: 'joined',
      desc: '',
      args: [],
    );
  }

  /// `Leave group`
  String get leaveGroup {
    return Intl.message(
      'Leave group',
      name: 'leaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Legal`
  String get legal {
    return Intl.message(
      'Legal',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `Love your neighbor`
  String get loveYourNeighbor {
    return Intl.message(
      'Love your neighbor',
      name: 'loveYourNeighbor',
      desc: '',
      args: [],
    );
  }

  /// `Member Promoted`
  String get memberPromoted {
    return Intl.message(
      'Member Promoted',
      name: 'memberPromoted',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get members {
    return Intl.message(
      'Members',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `{membersCount} Members`
  String membersCount(Object membersCount) {
    return Intl.message(
      '$membersCount Members',
      name: 'membersCount',
      desc: '',
      args: [membersCount],
    );
  }

  /// `Membership Type`
  String get membershipType {
    return Intl.message(
      'Membership Type',
      name: 'membershipType',
      desc: '',
      args: [],
    );
  }

  /// `Anyone can freely view, join, and/or be invited to the group.`
  String get membershipTypeOpenDescription {
    return Intl.message(
      'Anyone can freely view, join, and/or be invited to the group.',
      name: 'membershipTypeOpenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Similar to restricted, but it is hidden from searches and exclusively for those who are invited`
  String get membershipTypePrivateDescription {
    return Intl.message(
      'Similar to restricted, but it is hidden from searches and exclusively for those who are invited',
      name: 'membershipTypePrivateDescription',
      desc: '',
      args: [],
    );
  }

  /// `People must ask or be invited to join the group; prayers are not visible to non-members`
  String get membershipTypeRestrictedDescription {
    return Intl.message(
      'People must ask or be invited to join the group; prayers are not visible to non-members',
      name: 'membershipTypeRestrictedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Moderator`
  String get moderator {
    return Intl.message(
      'Moderator',
      name: 'moderator',
      desc: '',
      args: [],
    );
  }

  /// `Moderators`
  String get moderators {
    return Intl.message(
      'Moderators',
      name: 'moderators',
      desc: '',
      args: [],
    );
  }

  /// `1. Moderators have the ability to invite others or accept join requests.:2. Moderators can post corporate prayers.:3. Moderators can set notifications for prayer times.`
  String get moderatorsPrivileges {
    return Intl.message(
      '1. Moderators have the ability to invite others or accept join requests.:2. Moderators can post corporate prayers.:3. Moderators can set notifications for prayer times.',
      name: 'moderatorsPrivileges',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Neighbor`
  String get neighbor {
    return Intl.message(
      'Neighbor',
      name: 'neighbor',
      desc: '',
      args: [],
    );
  }

  /// `Pray for others to become their neighbor.`
  String get neighborDescription {
    return Intl.message(
      'Pray for others to become their neighbor.',
      name: 'neighborDescription',
      desc: '',
      args: [],
    );
  }

  /// `No reminder has been set for this corporate prayer`
  String get noReminderSet {
    return Intl.message(
      'No reminder has been set for this corporate prayer',
      name: 'noReminderSet',
      desc: '',
      args: [],
    );
  }

  /// `You are now a member of {group}`
  String notificationAccepted(Object group) {
    return Intl.message(
      'You are now a member of $group',
      name: 'notificationAccepted',
      desc: '',
      args: [group],
    );
  }

  /// `{username} started following you`
  String notificationFollow(Object username) {
    return Intl.message(
      '$username started following you',
      name: 'notificationFollow',
      desc: '',
      args: [username],
    );
  }

  /// `{username} requested to join`
  String notificationJoinRequested(Object username) {
    return Intl.message(
      '$username requested to join',
      name: 'notificationJoinRequested',
      desc: '',
      args: [username],
    );
  }

  /// `{username} joined the group`
  String notificationJoinedGroup(Object username) {
    return Intl.message(
      '$username joined the group',
      name: 'notificationJoinedGroup',
      desc: '',
      args: [username],
    );
  }

  /// `{username} posted a corporate prayer`
  String notificationPostedCorporatePrayer(Object username) {
    return Intl.message(
      '$username posted a corporate prayer',
      name: 'notificationPostedCorporatePrayer',
      desc: '',
      args: [username],
    );
  }

  /// `{username} posted a prayer`
  String notificationPostedPrayer(Object username) {
    return Intl.message(
      '$username posted a prayer',
      name: 'notificationPostedPrayer',
      desc: '',
      args: [username],
    );
  }

  /// `{username} prayed`
  String notificationPrayed(Object username) {
    return Intl.message(
      '$username prayed',
      name: 'notificationPrayed',
      desc: '',
      args: [username],
    );
  }

  /// `{username} prayed for you`
  String notificationPrayedForYou(Object username) {
    return Intl.message(
      '$username prayed for you',
      name: 'notificationPrayedForYou',
      desc: '',
      args: [username],
    );
  }

  /// `You are now a moderator of {group}`
  String notificationPromoted(Object group) {
    return Intl.message(
      'You are now a moderator of $group',
      name: 'notificationPromoted',
      desc: '',
      args: [group],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Only visible to you`
  String get onlyVisibleToYou {
    return Intl.message(
      'Only visible to you',
      name: 'onlyVisibleToYou',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pickImage {
    return Intl.message(
      'Pick Image',
      name: 'pickImage',
      desc: '',
      args: [],
    );
  }

  /// `Pick image from gallery`
  String get pickImageFromGallery {
    return Intl.message(
      'Pick image from gallery',
      name: 'pickImageFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Pick your bible verse`
  String get placeholderBibleVerse {
    return Intl.message(
      'Pick your bible verse',
      name: 'placeholderBibleVerse',
      desc: '',
      args: [],
    );
  }

  /// `Our father in heaven`
  String get placeholderPrayer {
    return Intl.message(
      'Our father in heaven',
      name: 'placeholderPrayer',
      desc: '',
      args: [],
    );
  }

  /// `Let us pray...`
  String get placeholderReminder {
    return Intl.message(
      'Let us pray...',
      name: 'placeholderReminder',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get placeholderSearch {
    return Intl.message(
      'Search...',
      name: 'placeholderSearch',
      desc: '',
      args: [],
    );
  }

  /// `Posted by me`
  String get postedByMe {
    return Intl.message(
      'Posted by me',
      name: 'postedByMe',
      desc: '',
      args: [],
    );
  }

  /// `Pray`
  String get pray {
    return Intl.message(
      'Pray',
      name: 'pray',
      desc: '',
      args: [],
    );
  }

  /// `Pray Anonymously`
  String get prayAnonymoous {
    return Intl.message(
      'Pray Anonymously',
      name: 'prayAnonymoous',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get prayDuration {
    return Intl.message(
      'Duration',
      name: 'prayDuration',
      desc: '',
      args: [],
    );
  }

  /// `Pray with name?`
  String get prayWithName {
    return Intl.message(
      'Pray with name?',
      name: 'prayWithName',
      desc: '',
      args: [],
    );
  }

  /// `Pray with Others`
  String get prayWithOthers {
    return Intl.message(
      'Pray with Others',
      name: 'prayWithOthers',
      desc: '',
      args: [],
    );
  }

  /// `- Matthew 22:39 (NIV)`
  String get prayWithWordFormBible {
    return Intl.message(
      '- Matthew 22:39 (NIV)',
      name: 'prayWithWordFormBible',
      desc: '',
      args: [],
    );
  }

  /// `And the second is like it: ‘Love your neighbor as yourself.’`
  String get prayWithWordFormBibleVerse {
    return Intl.message(
      'And the second is like it: ‘Love your neighbor as yourself.’',
      name: 'prayWithWordFormBibleVerse',
      desc: '',
      args: [],
    );
  }

  /// `Pray with Words`
  String get prayWithWords {
    return Intl.message(
      'Pray with Words',
      name: 'prayWithWords',
      desc: '',
      args: [],
    );
  }

  /// `Prayer`
  String get prayer {
    return Intl.message(
      'Prayer',
      name: 'prayer',
      desc: '',
      args: [],
    );
  }

  /// `Prayers`
  String get prayers {
    return Intl.message(
      'Prayers',
      name: 'prayers',
      desc: '',
      args: [],
    );
  }

  /// `Prays`
  String get prays {
    return Intl.message(
      'Prays',
      name: 'prays',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Promote`
  String get promote {
    return Intl.message(
      'Promote',
      name: 'promote',
      desc: '',
      args: [],
    );
  }

  /// `Rate Prayer`
  String get ratePrayer {
    return Intl.message(
      'Rate Prayer',
      name: 'ratePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Read More`
  String get readmore {
    return Intl.message(
      'Read More',
      name: 'readmore',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Remove current photo`
  String get removeCurrentPhoto {
    return Intl.message(
      'Remove current photo',
      name: 'removeCurrentPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Requested`
  String get requested {
    return Intl.message(
      'Requested',
      name: 'requested',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `Reset to default`
  String get resetToDefault {
    return Intl.message(
      'Reset to default',
      name: 'resetToDefault',
      desc: '',
      args: [],
    );
  }

  /// `Restricted`
  String get restricted {
    return Intl.message(
      'Restricted',
      name: 'restricted',
      desc: '',
      args: [],
    );
  }

  /// `Revoke`
  String get revoke {
    return Intl.message(
      'Revoke',
      name: 'revoke',
      desc: '',
      args: [],
    );
  }

  /// `Revoked`
  String get revoked {
    return Intl.message(
      'Revoked',
      name: 'revoked',
      desc: '',
      args: [],
    );
  }

  /// `Search a companion`
  String get searchCompanion {
    return Intl.message(
      'Search a companion',
      name: 'searchCompanion',
      desc: '',
      args: [],
    );
  }

  /// `Search a group `
  String get searchGroup {
    return Intl.message(
      'Search a group ',
      name: 'searchGroup',
      desc: '',
      args: [],
    );
  }

  /// `Send Feedback`
  String get sendFeedback {
    return Intl.message(
      'Send Feedback',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Send Invitation`
  String get sendInvitation {
    return Intl.message(
      'Send Invitation',
      name: 'sendInvitation',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Share your prayer requests, express your prayers, and offer your prayers for others on Prayer today! \n\n {url}`
  String shareAppMessage(Object url) {
    return Intl.message(
      'Share your prayer requests, express your prayers, and offer your prayers for others on Prayer today! \n\n $url',
      name: 'shareAppMessage',
      desc: '',
      args: [url],
    );
  }

  /// `Share Prayer`
  String get sharePrayer {
    return Intl.message(
      'Share Prayer',
      name: 'sharePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get signInWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'signInWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus.`
  String get signUpScreenBibleVerse {
    return Intl.message(
      'Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus.',
      name: 'signUpScreenBibleVerse',
      desc: '',
      args: [],
    );
  }

  /// `1 Thessalonians 5:16-18 (NIV)`
  String get signUpScreenBibleVerseBook {
    return Intl.message(
      '1 Thessalonians 5:16-18 (NIV)',
      name: 'signUpScreenBibleVerseBook',
      desc: '',
      args: [],
    );
  }

  /// `{username} prayed`
  String someoneHasPrayed(Object username) {
    return Intl.message(
      '$username prayed',
      name: 'someoneHasPrayed',
      desc: '',
      args: [username],
    );
  }

  /// `Started At`
  String get startedAt {
    return Intl.message(
      'Started At',
      name: 'startedAt',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message(
      'Terms of Use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Share your prayer without revealing your identity, keeping your name private.`
  String get titleAnonymously {
    return Intl.message(
      'Share your prayer without revealing your identity, keeping your name private.',
      name: 'titleAnonymously',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete a corporate prayer?`
  String get titleConfirmDeleteCorporatePrayer {
    return Intl.message(
      'Are you sure you want to delete a corporate prayer?',
      name: 'titleConfirmDeleteCorporatePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete an account?`
  String get titleDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete an account?',
      name: 'titleDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Corporate Prayer`
  String get titleDeleteCorporatePrayer {
    return Intl.message(
      'Delete Corporate Prayer',
      name: 'titleDeleteCorporatePrayer',
      desc: '',
      args: [],
    );
  }

  /// `Tell us a detail about your Group, such as its purpose or mission.`
  String get titleGroupDescription {
    return Intl.message(
      'Tell us a detail about your Group, such as its purpose or mission.',
      name: 'titleGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `This group is {membershipType}`
  String titleGroupType(Object membershipType) {
    return Intl.message(
      'This group is $membershipType',
      name: 'titleGroupType',
      desc: '',
      args: [membershipType],
    );
  }

  /// `How to Share Your Prayer?`
  String get titleHowToShareYourPrayer {
    return Intl.message(
      'How to Share Your Prayer?',
      name: 'titleHowToShareYourPrayer',
      desc: '',
      args: [],
    );
  }

  /// `Invite {membersCount} people?`
  String titleInvitePeople(Object membersCount) {
    return Intl.message(
      'Invite $membersCount people?',
      name: 'titleInvitePeople',
      desc: '',
      args: [membersCount],
    );
  }

  /// `Users will receive a notification and can join without approval. Admin or other moderators can revoke your invites`
  String get titleInvitePeopleDescription {
    return Intl.message(
      'Users will receive a notification and can join without approval. Admin or other moderators can revoke your invites',
      name: 'titleInvitePeopleDescription',
      desc: '',
      args: [],
    );
  }

  /// `2. Only group members can post the prayer and participate in prayer activities`
  String get titleMemberCanPostOnly {
    return Intl.message(
      '2. Only group members can post the prayer and participate in prayer activities',
      name: 'titleMemberCanPostOnly',
      desc: '',
      args: [],
    );
  }

  /// `Tell us who can join this group. You cannot change this later.`
  String get titleMembershipType {
    return Intl.message(
      'Tell us who can join this group. You cannot change this later.',
      name: 'titleMembershipType',
      desc: '',
      args: [],
    );
  }

  /// `1. All prayers in the group are public, visible to everyone, and joining is unrestricted.`
  String get titleMembershipTypeOpen {
    return Intl.message(
      '1. All prayers in the group are public, visible to everyone, and joining is unrestricted.',
      name: 'titleMembershipTypeOpen',
      desc: '',
      args: [],
    );
  }

  /// `1. Group is unlisted in searches and its prayers are inaccessible to non-members.`
  String get titleMembershipTypePrivate {
    return Intl.message(
      '1. Group is unlisted in searches and its prayers are inaccessible to non-members.',
      name: 'titleMembershipTypePrivate',
      desc: '',
      args: [],
    );
  }

  /// `1. Joining the group requires approval, and only members can view prayers.`
  String get titleMembershipTypeRestricted {
    return Intl.message(
      '1. Joining the group requires approval, and only members can view prayers.',
      name: 'titleMembershipTypeRestricted',
      desc: '',
      args: [],
    );
  }

  /// `Post Anonymously`
  String get titlePrayerPostAnonymously {
    return Intl.message(
      'Post Anonymously',
      name: 'titlePrayerPostAnonymously',
      desc: '',
      args: [],
    );
  }

  /// `Post Publicly`
  String get titlePrayerPostPublicly {
    return Intl.message(
      'Post Publicly',
      name: 'titlePrayerPostPublicly',
      desc: '',
      args: [],
    );
  }

  /// `Promote {name}`
  String titlePromoteUser(Object name) {
    return Intl.message(
      'Promote $name',
      name: 'titlePromoteUser',
      desc: '',
      args: [name],
    );
  }

  /// `You will be notified on {fromDays} at {toDays}`
  String titleReminderNotifyOn(Object fromDays, Object toDays) {
    return Intl.message(
      'You will be notified on $fromDays at $toDays',
      name: 'titleReminderNotifyOn',
      desc: '',
      args: [fromDays, toDays],
    );
  }

  /// `Your timezone will be used to notify other members`
  String get titleTimezoneWillBeUsed {
    return Intl.message(
      'Your timezone will be used to notify other members',
      name: 'titleTimezoneWillBeUsed',
      desc: '',
      args: [],
    );
  }

  /// `Your name will appear alongside your post.`
  String get titleWithName {
    return Intl.message(
      'Your name will appear alongside your post.',
      name: 'titleWithName',
      desc: '',
      args: [],
    );
  }

  /// `Your prayer has been received`
  String get titleYourPrayerHasBeenReceived {
    return Intl.message(
      'Your prayer has been received',
      name: 'titleYourPrayerHasBeenReceived',
      desc: '',
      args: [],
    );
  }

  /// `Unblock {username}`
  String unblockUser(Object username) {
    return Intl.message(
      'Unblock $username',
      name: 'unblockUser',
      desc: '',
      args: [username],
    );
  }

  /// `Unfollow`
  String get unfollow {
    return Intl.message(
      'Unfollow',
      name: 'unfollow',
      desc: '',
      args: [],
    );
  }

  /// `Unfollow {username}`
  String unfollowUser(Object username) {
    return Intl.message(
      'Unfollow $username',
      name: 'unfollowUser',
      desc: '',
      args: [username],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Version: {version}`
  String versionText(Object version) {
    return Intl.message(
      'Version: $version',
      name: 'versionText',
      desc: '',
      args: [version],
    );
  }

  /// `Weekdays`
  String get weekdays {
    return Intl.message(
      'Weekdays',
      name: 'weekdays',
      desc: '',
      args: [],
    );
  }

  /// `Weekend`
  String get weekend {
    return Intl.message(
      'Weekend',
      name: 'weekend',
      desc: '',
      args: [],
    );
  }

  /// `With Name`
  String get withName {
    return Intl.message(
      'With Name',
      name: 'withName',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
