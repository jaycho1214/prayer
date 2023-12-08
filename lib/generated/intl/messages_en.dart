// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(username) => "Accept @${username}?";

  static String m1(username) => "Revoke an invitation of @${username}?";

  static String m2(membershipType) =>
      "This group is ${membershipType}.\nJoin to see the prayers";

  static String m3(username) => "Username ${username} is already taken";

  static String m4(establishedAt) =>
      "3. This group was established at ${establishedAt}";

  static String m5(membersCount) => "${membersCount} Members";

  static String m6(url) =>
      "Share your prayer requests, express your prayers, and offer your prayers for others on Prayer today! \n\n ${url}";

  static String m7(username) => "${username} has prayed";

  static String m8(membershipType) => "This group is ${membershipType}";

  static String m9(membersCount) => "Invite ${membersCount} people?";

  static String m10(name) => "Promote ${name}";

  static String m11(fromDays, toDays) =>
      "You will be notified on ${fromDays} at ${toDays}";

  static String m12(version) => "Version: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept": MessageLookupByLibrary.simpleMessage("Accept"),
        "accepted": MessageLookupByLibrary.simpleMessage("Accepted"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "alertAcceptMember": m0,
        "alertDeleteGroup": MessageLookupByLibrary.simpleMessage(
            "1. Deletion is irreversible and immediate.:2. All group members will be removed automatically.:3. All prayers, both corporate and individual, must be deleted to remove the group."),
        "alertFeedbackSent":
            MessageLookupByLibrary.simpleMessage("Feedback has sent"),
        "alertLeaveGroup": MessageLookupByLibrary.simpleMessage(
            "1. You need to be reaccepted to join the group.:2. You need to be repromoted to regain moderator status.:3. None of your prayers will be deleted."),
        "alertPrayWithName": MessageLookupByLibrary.simpleMessage(
            "Do you want to pray using your name? Please be aware that if you do, everyone will be able to see your prayer along with your name."),
        "alertRevokeInvitation": m1,
        "alertYouCannotUndoThisAction":
            MessageLookupByLibrary.simpleMessage("You cannot undo this action"),
        "amen": MessageLookupByLibrary.simpleMessage("Amen"),
        "anonymous": MessageLookupByLibrary.simpleMessage("Anonymous"),
        "anonymously": MessageLookupByLibrary.simpleMessage("Anonymously"),
        "bible": MessageLookupByLibrary.simpleMessage("Bible"),
        "bibleCorporatePrayerScreenVerse": MessageLookupByLibrary.simpleMessage(
            "After they prayed, the place where they were meeting was shaken. And they were all filled with the Holy Spirit and spoke the word of God boldly."),
        "bibleCorporatePrayerScreenVerseBook":
            MessageLookupByLibrary.simpleMessage("- Acts 4:31 (NIV)"),
        "bio": MessageLookupByLibrary.simpleMessage("Bio"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseCorporatePrayer":
            MessageLookupByLibrary.simpleMessage("Choose a Corporate Prayer"),
        "chooseGroup": MessageLookupByLibrary.simpleMessage("Choose a Group"),
        "community": MessageLookupByLibrary.simpleMessage("Community"),
        "corporate": MessageLookupByLibrary.simpleMessage("Corporate"),
        "corporatePrayerPrayed": MessageLookupByLibrary.simpleMessage("Prayed"),
        "corporatePrayerPraying":
            MessageLookupByLibrary.simpleMessage("Praying"),
        "corporatePrayerPreparing":
            MessageLookupByLibrary.simpleMessage("Preparing"),
        "corporatePrayerReminderMesasge": MessageLookupByLibrary.simpleMessage(
            "After the duration of prayers has elapsed, they will be marked as concluded, and reminders will not be sent."),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createGroup": MessageLookupByLibrary.simpleMessage("Create a Group"),
        "dayFri": MessageLookupByLibrary.simpleMessage("Fri"),
        "dayMon": MessageLookupByLibrary.simpleMessage("Mon"),
        "daySat": MessageLookupByLibrary.simpleMessage("Sat"),
        "daySun": MessageLookupByLibrary.simpleMessage("Sun"),
        "dayThu": MessageLookupByLibrary.simpleMessage("Thu"),
        "dayTue": MessageLookupByLibrary.simpleMessage("Tue"),
        "dayWen": MessageLookupByLibrary.simpleMessage("Wed"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Delete an account"),
        "deleteGroup": MessageLookupByLibrary.simpleMessage("Delete a Group"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "descriptionDeleteAccount": MessageLookupByLibrary.simpleMessage(
            "1. Users will be immediately deleted.:2. Users cannot recover once they are deleted.:3. Users must delete all the groups they own.:4. Users must leave all the groups to which they belong.:5. Users must not have any corporate prayers."),
        "descriptionDeleteCorporatePrayer":
            MessageLookupByLibrary.simpleMessage(
                "All prayers in corporate prayers will not be deleted."),
        "descriptionNeedDonation": MessageLookupByLibrary.simpleMessage(
            "Join us in nurturing a community of faith and support. Our app offers a unique space for users to share and uplift through prayers, free from ads and without selling any data. We rely entirely on donations to keep this serene and safe platform running. Every contribution, big or small, makes a meaningful difference. Thank you for supporting this journey of fellowship and prayer."),
        "descriptionYourPrayerHasBeenReceived":
            MessageLookupByLibrary.simpleMessage(
                "Let\'\'s give it a 5-minute grace period to soar high. How about a quick stretch or a moment of quiet reflection? Ready for your next prayer in a jiffy!"),
        "donatePrayer": MessageLookupByLibrary.simpleMessage("Donate Now"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "endedAt": MessageLookupByLibrary.simpleMessage("Ended At"),
        "errorAcceptUser":
            MessageLookupByLibrary.simpleMessage("Failed to accept the user"),
        "errorAccessPhoto": MessageLookupByLibrary.simpleMessage(
            "Prayers does not have an access to your photos."),
        "errorAdminLeaveGroup": MessageLookupByLibrary.simpleMessage(
            "Admin cannot leave the group"),
        "errorCheckingUsernameExists": MessageLookupByLibrary.simpleMessage(
            "Error while checking your username"),
        "errorChooseUserToInvite": MessageLookupByLibrary.simpleMessage(
            "Please choose a user to invite"),
        "errorCorporatePrayerHasSpecialCharacters":
            MessageLookupByLibrary.simpleMessage(
                "Name must not include the \'#\' or the \'@\' symbol"),
        "errorCorporatePrayerMustNotEmpty":
            MessageLookupByLibrary.simpleMessage(
                "Name must include at least one non-whitespace character"),
        "errorCorporatePrayerNeedPrayers": MessageLookupByLibrary.simpleMessage(
            "Please provide a prayer for corporate prayer"),
        "errorCreateGroup":
            MessageLookupByLibrary.simpleMessage("Failed to create a group"),
        "errorDeleteGroup":
            MessageLookupByLibrary.simpleMessage("Unable to delete a group"),
        "errorDeletePray":
            MessageLookupByLibrary.simpleMessage("Failed to delete a pray"),
        "errorDeleteUser": MessageLookupByLibrary.simpleMessage(
            "Please follow all the steps before deleting a user."),
        "errorEditGroup":
            MessageLookupByLibrary.simpleMessage("Failed to edit a group"),
        "errorEmptyPrayer": MessageLookupByLibrary.simpleMessage(
            "Prayer must include at least one non-whitespace character"),
        "errorEnterName":
            MessageLookupByLibrary.simpleMessage("Please enter your name"),
        "errorFollowUser":
            MessageLookupByLibrary.simpleMessage("Failed to follow the user"),
        "errorJoinGroup":
            MessageLookupByLibrary.simpleMessage("Failed to join the group"),
        "errorLeaveGroup":
            MessageLookupByLibrary.simpleMessage("Failed to leave the group"),
        "errorLoadImage":
            MessageLookupByLibrary.simpleMessage("Failed to load an image"),
        "errorMustBeModeratorToPost": MessageLookupByLibrary.simpleMessage(
            "Only moderators are allowed to post corporate prayers."),
        "errorNameLessThan30Characters": MessageLookupByLibrary.simpleMessage(
            "Names must be less than 30 characters and do not include hashtag and or the \'@\' symbol."),
        "errorNeedCorporatePrayerDescription":
            MessageLookupByLibrary.simpleMessage(
                "Please provide a description for a corporate prayer"),
        "errorNeedDayReminder":
            MessageLookupByLibrary.simpleMessage("Please select a day to send"),
        "errorNeedGroupBanner":
            MessageLookupByLibrary.simpleMessage("Please upload a banner"),
        "errorNeedGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Please provide a description for the group"),
        "errorNeedMembershipType": MessageLookupByLibrary.simpleMessage(
            "Please choose one of the type"),
        "errorNeedPermissionToPost": MessageLookupByLibrary.simpleMessage(
            "You have to be a member of the group"),
        "errorNeedPermissionToView": m2,
        "errorPostPrayer":
            MessageLookupByLibrary.simpleMessage("Unable to post a prayer"),
        "errorPromoteUser":
            MessageLookupByLibrary.simpleMessage("Failed to promote the user"),
        "errorProvideReminderMessage": MessageLookupByLibrary.simpleMessage(
            "Please provide a message to be sent"),
        "errorRevokeInvite":
            MessageLookupByLibrary.simpleMessage("Failed to revoke the invite"),
        "errorSignIn": MessageLookupByLibrary.simpleMessage(
            "Failed to sign in. Please try again."),
        "errorUnableToUpdate": MessageLookupByLibrary.simpleMessage(
            "Unable to update. Please try again later"),
        "errorUnknown":
            MessageLookupByLibrary.simpleMessage("Unknown error occured"),
        "errorUsernameFormat": MessageLookupByLibrary.simpleMessage(
            "You can only use alphabets, numbers, period, and underscore for the username"),
        "errorUsernameReqruied":
            MessageLookupByLibrary.simpleMessage("Username is required"),
        "errorUsernameTaken": m3,
        "everyday": MessageLookupByLibrary.simpleMessage("Everyday"),
        "follow": MessageLookupByLibrary.simpleMessage("Follow"),
        "followers": MessageLookupByLibrary.simpleMessage("Followers"),
        "following": MessageLookupByLibrary.simpleMessage("Following"),
        "followings": MessageLookupByLibrary.simpleMessage("Followings"),
        "group": MessageLookupByLibrary.simpleMessage("Group"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Group Description"),
        "groupEstablishedAt": m4,
        "groupName": MessageLookupByLibrary.simpleMessage("Group Name"),
        "groups": MessageLookupByLibrary.simpleMessage("Groups"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "introductionTitle": MessageLookupByLibrary.simpleMessage(
            "United in Prayer \nStronger Together \nCollective Faith"),
        "invitation": MessageLookupByLibrary.simpleMessage("Invitation"),
        "invite": MessageLookupByLibrary.simpleMessage("Invite"),
        "invited": MessageLookupByLibrary.simpleMessage("Invited"),
        "invites": MessageLookupByLibrary.simpleMessage("Invites"),
        "join": MessageLookupByLibrary.simpleMessage("Join"),
        "joined": MessageLookupByLibrary.simpleMessage("Joined"),
        "leaveGroup": MessageLookupByLibrary.simpleMessage("Leave group"),
        "members": MessageLookupByLibrary.simpleMessage("Members"),
        "membersCount": m5,
        "membershipType":
            MessageLookupByLibrary.simpleMessage("Membership Type"),
        "membershipTypeOpenDescription": MessageLookupByLibrary.simpleMessage(
            "Anyone can freely view, join, and/or be invited to the group."),
        "membershipTypePrivateDescription": MessageLookupByLibrary.simpleMessage(
            "Similar to restricted, but it is hidden from searches and exclusively for those who are invited"),
        "membershipTypeRestrictedDescription": MessageLookupByLibrary.simpleMessage(
            "People must ask or be invited to join the group; prayers are not visible to non-members"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderator"),
        "moderators": MessageLookupByLibrary.simpleMessage("Moderators"),
        "moderatorsPrivileges": MessageLookupByLibrary.simpleMessage(
            "1. Moderators have the ability to invite others or accept join requests.:2. Moderators can post corporate prayers.:3. Moderators can set notifications for prayer times."),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "open": MessageLookupByLibrary.simpleMessage("Open"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Pick Image"),
        "pickImageFromGallery":
            MessageLookupByLibrary.simpleMessage("Pick image from gallery"),
        "placeholderPrayer":
            MessageLookupByLibrary.simpleMessage("Our father in heaven"),
        "placeholderReminder":
            MessageLookupByLibrary.simpleMessage("Let us pray..."),
        "placeholderSearch": MessageLookupByLibrary.simpleMessage("Search..."),
        "pray": MessageLookupByLibrary.simpleMessage("Pray"),
        "prayAnonymoous":
            MessageLookupByLibrary.simpleMessage("Pray as Anonymous"),
        "prayWithName": MessageLookupByLibrary.simpleMessage("Pray with name?"),
        "prayWithWordFormBible":
            MessageLookupByLibrary.simpleMessage("- James 5:16 (NIV)"),
        "prayWithWordFormBibleVerse": MessageLookupByLibrary.simpleMessage(
            "Therefore confess your sins to each other and pray for each other so that you may be healed. The prayer of a righteous person is powerful and effective."),
        "prayWithWords":
            MessageLookupByLibrary.simpleMessage("Pray with Words"),
        "prayer": MessageLookupByLibrary.simpleMessage("Prayer"),
        "prayers": MessageLookupByLibrary.simpleMessage("Prayers"),
        "prays": MessageLookupByLibrary.simpleMessage("Prays"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "private": MessageLookupByLibrary.simpleMessage("Private"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "promote": MessageLookupByLibrary.simpleMessage("Promote"),
        "ratePrayer": MessageLookupByLibrary.simpleMessage("Rate Prayer"),
        "readmore": MessageLookupByLibrary.simpleMessage("Read More"),
        "reminder": MessageLookupByLibrary.simpleMessage("Reminder"),
        "removeCurrentPhoto":
            MessageLookupByLibrary.simpleMessage("Remove current photo"),
        "requested": MessageLookupByLibrary.simpleMessage("Requested"),
        "requests": MessageLookupByLibrary.simpleMessage("Requests"),
        "resetToDefault":
            MessageLookupByLibrary.simpleMessage("Reset to default"),
        "restricted": MessageLookupByLibrary.simpleMessage("Restricted"),
        "revoke": MessageLookupByLibrary.simpleMessage("Revoke"),
        "revoked": MessageLookupByLibrary.simpleMessage("Revoked"),
        "sendFeedback": MessageLookupByLibrary.simpleMessage("Send Feedback"),
        "sendInvitation":
            MessageLookupByLibrary.simpleMessage("Send Invitation"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "shareAppMessage": m6,
        "sharePrayer": MessageLookupByLibrary.simpleMessage("Share Prayer"),
        "signInWithApple":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("Continue with Google"),
        "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "signUpScreenBibleVerse": MessageLookupByLibrary.simpleMessage(
            "Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus."),
        "signUpScreenBibleVerseBook": MessageLookupByLibrary.simpleMessage(
            "1 Thessalonians 5:16-18 (NIV)"),
        "someoneHasPrayed": m7,
        "startedAt": MessageLookupByLibrary.simpleMessage("Started At"),
        "termsOfUse": MessageLookupByLibrary.simpleMessage("Terms of Use"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "titleAnonymously": MessageLookupByLibrary.simpleMessage(
            "Share your prayer without revealing your identity, keeping your name private."),
        "titleConfirmDeleteCorporatePrayer":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete a corporate prayer?"),
        "titleDeleteAccount": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete an account?"),
        "titleDeleteCorporatePrayer":
            MessageLookupByLibrary.simpleMessage("Delete Corporate Prayer"),
        "titleGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Tell us a detail about your Group, such as its purpose or mission."),
        "titleGroupType": m8,
        "titleHowToShareYourPrayer":
            MessageLookupByLibrary.simpleMessage("How to Share Your Prayer?"),
        "titleInvitePeople": m9,
        "titleInvitePeopleDescription": MessageLookupByLibrary.simpleMessage(
            "Users will receive a notification and can join without approval. Admin or other moderators can revoke your invites"),
        "titleMemberCanPostOnly": MessageLookupByLibrary.simpleMessage(
            "2. Only group members can post the prayer and participate in prayer activities"),
        "titleMembershipType": MessageLookupByLibrary.simpleMessage(
            "Tell us who can join this group. You cannot change this later."),
        "titleMembershipTypeOpen": MessageLookupByLibrary.simpleMessage(
            "1. All prayers in the group are public, visible to everyone, and joining is unrestricted."),
        "titleMembershipTypePrivate": MessageLookupByLibrary.simpleMessage(
            "1. Group is unlisted in searches and its prayers are inaccessible to non-members."),
        "titleMembershipTypeRestricted": MessageLookupByLibrary.simpleMessage(
            "1. Joining the group requires approval, and only members can view prayers."),
        "titlePrayerPostAnonymously":
            MessageLookupByLibrary.simpleMessage("Post Anonymously"),
        "titlePrayerPostPublicly":
            MessageLookupByLibrary.simpleMessage("Post Publicly"),
        "titlePromoteUser": m10,
        "titleReminderNotifyOn": m11,
        "titleTimezoneWillBeUsed": MessageLookupByLibrary.simpleMessage(
            "Your timezone will be used to notify other members"),
        "titleWithName": MessageLookupByLibrary.simpleMessage(
            "Your name will appear alongside your post."),
        "titleYourPrayerHasBeenReceived": MessageLookupByLibrary.simpleMessage(
            "Your prayer has been received"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "users": MessageLookupByLibrary.simpleMessage("Users"),
        "versionText": m12,
        "weekdays": MessageLookupByLibrary.simpleMessage("Weekdays"),
        "weekend": MessageLookupByLibrary.simpleMessage("Weekend"),
        "withName": MessageLookupByLibrary.simpleMessage("With Name")
      };
}
