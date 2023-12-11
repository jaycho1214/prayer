// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(username) => "@${username}을 승인하시겠습니까?";

  static String m1(username) => "@${username}의 초대를 취소하시겠습니까?";

  static String m2(membershipType) =>
      "이 그룹은 ${membershipType} 입니다.\n멤버만 볼 수 있습니다.";

  static String m3(username) => "${username}이 이미 사용중 입니다";

  static String m4(establishedAt) => "3. 이 그룹은 ${establishedAt}애 창설되었습니다";

  static String m5(membersCount) => "${membersCount} 멤버들";

  static String m6(url) =>
      "지금 \'Prayer\' 앱에서 서로의 기도를 나누고, 기도 요청을 올리고 다른 사람들을 위해 기도해주세요.\n\n ${url}";

  static String m7(username) => "${username}이 기도했습니다";

  static String m8(membershipType) => "이 그룹은 ${membershipType}입니다";

  static String m9(membersCount) => "${membersCount}명의 사람을 초대하시겠습니까?";

  static String m10(name) => "${name}을 임명하시겠습니까?";

  static String m11(fromDays, toDays) =>
      "이 알림은 ${fromDays}부터 ${toDays}까지 전송됩니다";

  static String m12(version) => "버전: ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept": MessageLookupByLibrary.simpleMessage("승인"),
        "accepted": MessageLookupByLibrary.simpleMessage("승인됨"),
        "account": MessageLookupByLibrary.simpleMessage("계정"),
        "admin": MessageLookupByLibrary.simpleMessage("관리자"),
        "alertAcceptMember": m0,
        "alertDeleteGroup": MessageLookupByLibrary.simpleMessage(
            "1. 삭제는 되돌릴 수 없으며 즉시 이루어집니다.:2. 모든 그룹 구성원은 자동으로 탈퇴됩니다.:3. 그룹을 삭제하기 위해서는 모든 기도 및 중보기도를 삭제해야 합니다."),
        "alertFeedbackSent":
            MessageLookupByLibrary.simpleMessage("피드백이 전송되었습니다"),
        "alertLeaveGroup": MessageLookupByLibrary.simpleMessage(
            "1. 그룹에 가입하기 위해서는 다시 초대받거나 승인되어야 합니다:2. 현재 사역자일 경우 다시 임명 받아야합니다.:3. 그룹에 올린 기도문은 삭제되지 않습니다."),
        "alertPrayWithName": MessageLookupByLibrary.simpleMessage(
            "이 기도문은 모든 사람이 당신의 이름과 함께 볼 수 있습니다."),
        "alertRevokeInvitation": m1,
        "alertYouCannotUndoThisAction":
            MessageLookupByLibrary.simpleMessage("이 작업은 취소할 수 없습니다"),
        "amen": MessageLookupByLibrary.simpleMessage("아멘"),
        "anonymous": MessageLookupByLibrary.simpleMessage("익명"),
        "anonymously": MessageLookupByLibrary.simpleMessage("익명"),
        "bible": MessageLookupByLibrary.simpleMessage("성경"),
        "bibleCorporatePrayerScreenVerse": MessageLookupByLibrary.simpleMessage(
            "빌기를 다하매 모인 곳이 진동하더니 무리가 다 성령이 충만하여 담대히 하나님의 말씀을 전하니라"),
        "bibleCorporatePrayerScreenVerseBook":
            MessageLookupByLibrary.simpleMessage("- 사도행전 4:31 (개역개정)"),
        "bibleVerse": MessageLookupByLibrary.simpleMessage("성경 구절"),
        "bio": MessageLookupByLibrary.simpleMessage("바이오"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "chooseCorporatePrayer":
            MessageLookupByLibrary.simpleMessage("중보기도 선택"),
        "chooseGroup": MessageLookupByLibrary.simpleMessage("그룹 선택"),
        "chooseTranslation": MessageLookupByLibrary.simpleMessage("성경 선택"),
        "community": MessageLookupByLibrary.simpleMessage("커뮤니티"),
        "corporate": MessageLookupByLibrary.simpleMessage("중보기도"),
        "corporatePrayerPrayed": MessageLookupByLibrary.simpleMessage("기도 완료"),
        "corporatePrayerPraying": MessageLookupByLibrary.simpleMessage("기도 중"),
        "corporatePrayerPreparing":
            MessageLookupByLibrary.simpleMessage("기도 준비중"),
        "corporatePrayerReminderMesasge":
            MessageLookupByLibrary.simpleMessage("기도 기간이 끝나면 알림이 전송되지 않습니다"),
        "create": MessageLookupByLibrary.simpleMessage("생성"),
        "createGroup": MessageLookupByLibrary.simpleMessage("그룹 생성"),
        "dayFri": MessageLookupByLibrary.simpleMessage("금\t"),
        "dayMon": MessageLookupByLibrary.simpleMessage("월"),
        "daySat": MessageLookupByLibrary.simpleMessage("토"),
        "daySun": MessageLookupByLibrary.simpleMessage("일"),
        "dayThu": MessageLookupByLibrary.simpleMessage("목"),
        "dayTue": MessageLookupByLibrary.simpleMessage("화"),
        "dayWen": MessageLookupByLibrary.simpleMessage("수"),
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("계정 삭제"),
        "deleteGroup": MessageLookupByLibrary.simpleMessage("그룹 삭제"),
        "description": MessageLookupByLibrary.simpleMessage("설명"),
        "descriptionDeleteAccount": MessageLookupByLibrary.simpleMessage(
            "1. 사용자는 즉시 삭제됩니다.:2. 사용자는 삭제되면 복구할 수 없습니다.:3. 사용자는 자신이 소유한 모든 그룹을 삭제해야 합니다.:4. 사용자는 자신이 속한 모든 그룹을 탈퇴해야 합니다.:5. 사용자는 모든 중보 기도를 삭제해야됩니다."),
        "descriptionDeleteCorporatePrayer":
            MessageLookupByLibrary.simpleMessage("중보기도에 있는 기도문은 삭제되지 않습니다."),
        "descriptionNeedDonation": MessageLookupByLibrary.simpleMessage(
            "크리스쳔 커뮤니티를 지키는데 힘을 실어주세요. 저희 앱은 사용자들이 기도를 통해 서로를 격려하고 위로할 수 있는 공간을 제공하고 평화롭고 안전한 플랫폼을 유지하기 위해 힘쓰고 있습니다. Prayer는 어떠한 광고나 사용자 데이터의 판매없이 전적으로 기부에 의존하고 있습니다. 크든 작든 모든 기부는 커뮤니티를 지켜나가는데 힘이 됩니다. 기도의 여정을 지원해 주셔서 감사합니다."),
        "descriptionYourPrayerHasBeenReceived":
            MessageLookupByLibrary.simpleMessage(
                "다음 기도는 5분 뒤에 할 수 있습니다. 잠시 스트레칭을 하거나 조용히 묵상하는 시간은 어떨까요?"),
        "donatePrayer": MessageLookupByLibrary.simpleMessage("Prayer 후원하기"),
        "done": MessageLookupByLibrary.simpleMessage("완료"),
        "edit": MessageLookupByLibrary.simpleMessage("수정"),
        "emptyGroupDescription": MessageLookupByLibrary.simpleMessage(
            "함께 연결되고 나누어 중보기도의 힘을 경험하세요. 다른 이들과 신앙 안에서 하나가 되어 놀라운 일을 목격하세요."),
        "endedAt": MessageLookupByLibrary.simpleMessage("종료"),
        "errorAcceptUser":
            MessageLookupByLibrary.simpleMessage("유저 승인에 실패했습니다"),
        "errorAccessPhoto":
            MessageLookupByLibrary.simpleMessage("사진 접근 권한을 허용해주세요."),
        "errorAdminLeaveGroup":
            MessageLookupByLibrary.simpleMessage("관리자는 그룹을 떠날 수 없습니다"),
        "errorCheckingUsernameExists":
            MessageLookupByLibrary.simpleMessage("오류가 발생했습니다"),
        "errorChooseUserToInvite":
            MessageLookupByLibrary.simpleMessage("초대할 사용자를 선택해 주세요"),
        "errorCorporatePrayerHasSpecialCharacters":
            MessageLookupByLibrary.simpleMessage(
                "이름에는 \'#\' 또는 \'@\' 기호를 포함할 수 없습니다"),
        "errorCorporatePrayerMustNotEmpty":
            MessageLookupByLibrary.simpleMessage(
                "이름은 최소한 하나의 공백이 아닌 문자를 포함해야 합니다"),
        "errorCorporatePrayerNeedPrayers":
            MessageLookupByLibrary.simpleMessage("중보기도를 위한 기도문을 적어주세요"),
        "errorCreateGroup":
            MessageLookupByLibrary.simpleMessage("그룹 생성에 실패했습니다"),
        "errorDeleteGroup":
            MessageLookupByLibrary.simpleMessage("그룹 삭제에 실패했습니다"),
        "errorDeletePray": MessageLookupByLibrary.simpleMessage("삭제에 실패하였습니다"),
        "errorDeleteUser":
            MessageLookupByLibrary.simpleMessage("탈퇴하기 전에 모든 단계를 따라 주세요."),
        "errorEditGroup": MessageLookupByLibrary.simpleMessage("그룹 수정에 실패했습니다"),
        "errorEmptyPrayer": MessageLookupByLibrary.simpleMessage(
            "기도문은 최소한 하나의 공백이 아닌 문자를 포함해야 합니다"),
        "errorEnterName": MessageLookupByLibrary.simpleMessage("이름을 입력해주세요"),
        "errorFollowUser": MessageLookupByLibrary.simpleMessage("팔로잉에 실패하였습니다"),
        "errorJoinGroup": MessageLookupByLibrary.simpleMessage("그룹 참가에 실패했습니다"),
        "errorLeaveGroup":
            MessageLookupByLibrary.simpleMessage("그룹 탈퇴에 실패했습니다"),
        "errorLoadImage":
            MessageLookupByLibrary.simpleMessage("이미지 로딩에 실패하였습니다"),
        "errorMustBeModeratorToPost":
            MessageLookupByLibrary.simpleMessage("사역자들만 중보 기도문을 게시할 수 있습니다."),
        "errorNameLessThan30Characters": MessageLookupByLibrary.simpleMessage(
            "이름은 30자 미만이어야 하며 해시태그 및 \'@\' 기호를 포함하지 않아야 합니다."),
        "errorNeedCorporatePrayerDescription":
            MessageLookupByLibrary.simpleMessage("중보기도 설명을 적어주세요"),
        "errorNeedDayReminder":
            MessageLookupByLibrary.simpleMessage("보내질 날을 선택해주세요"),
        "errorNeedGroupBanner":
            MessageLookupByLibrary.simpleMessage("배너 이미지를 업로드해주세요"),
        "errorNeedGroupDescription":
            MessageLookupByLibrary.simpleMessage("그룹 설명을 적어주세요"),
        "errorNeedMembershipType":
            MessageLookupByLibrary.simpleMessage("유형 중 하나를 선택해 주세요"),
        "errorNeedPermissionToPost":
            MessageLookupByLibrary.simpleMessage("그룹 멤버만 작성할 수 있습니다"),
        "errorNeedPermissionToView": m2,
        "errorPostPrayer":
            MessageLookupByLibrary.simpleMessage("기도문 게시에 실패하였습니다"),
        "errorPromoteUser":
            MessageLookupByLibrary.simpleMessage("유저를 임명하는데에 실패하였습니다"),
        "errorProvideReminderMessage":
            MessageLookupByLibrary.simpleMessage("멤버들에게 전해질 메시지를 적어주세요"),
        "errorRevokeInvite":
            MessageLookupByLibrary.simpleMessage("초대 철회에 실패하였습니다"),
        "errorSignIn":
            MessageLookupByLibrary.simpleMessage("로그인에 실패하였습니다. 다시 시도해주세요."),
        "errorUnableToUpdate":
            MessageLookupByLibrary.simpleMessage("업데이트에 실패하였습니다"),
        "errorUnknown":
            MessageLookupByLibrary.simpleMessage("알 수 없는 오류가 발생했습니다"),
        "errorUsernameFormat": MessageLookupByLibrary.simpleMessage(
            "아이디는 알파벳, 숫자, 마침표, 밑줄만 사용가능합니다"),
        "errorUsernameReqruied":
            MessageLookupByLibrary.simpleMessage("아이디를 입력해주세요"),
        "errorUsernameTaken": m3,
        "everyday": MessageLookupByLibrary.simpleMessage("매일"),
        "follow": MessageLookupByLibrary.simpleMessage("팔로우"),
        "followers": MessageLookupByLibrary.simpleMessage("팔로워"),
        "following": MessageLookupByLibrary.simpleMessage("팔로잉"),
        "followings": MessageLookupByLibrary.simpleMessage("팔로잉"),
        "group": MessageLookupByLibrary.simpleMessage("그룹"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("그룹 설명"),
        "groupEstablishedAt": m4,
        "groupName": MessageLookupByLibrary.simpleMessage("그룹 이름"),
        "groups": MessageLookupByLibrary.simpleMessage("그룹"),
        "home": MessageLookupByLibrary.simpleMessage("홈"),
        "introductionTitle":
            MessageLookupByLibrary.simpleMessage("기도로 연합\n믿음의 동반자\n공동의 믿음"),
        "invitation": MessageLookupByLibrary.simpleMessage("초대"),
        "invite": MessageLookupByLibrary.simpleMessage("초대"),
        "invited": MessageLookupByLibrary.simpleMessage("초대됨"),
        "invites": MessageLookupByLibrary.simpleMessage("초대"),
        "join": MessageLookupByLibrary.simpleMessage("가입"),
        "joined": MessageLookupByLibrary.simpleMessage("가입됨"),
        "leaveGroup": MessageLookupByLibrary.simpleMessage("그룹 탈퇴"),
        "members": MessageLookupByLibrary.simpleMessage("멤버들"),
        "membersCount": m5,
        "membershipType": MessageLookupByLibrary.simpleMessage("가입 조건"),
        "membershipTypeOpenDescription": MessageLookupByLibrary.simpleMessage(
            "누구나 자유롭게 그룹내 기도문을 보고, 가입할 수 있습니다."),
        "membershipTypePrivateDescription":
            MessageLookupByLibrary.simpleMessage(
                "제한됨과 비슷하지만, 그룹이 검색되지 않고 초대를 통해서만 들어올 수 있습니다."),
        "membershipTypeRestrictedDescription":
            MessageLookupByLibrary.simpleMessage(
                "그룹을 가입하기 위해 승인받거나 초대받아야하며, 그룹내 멤버들만 기도문을 볼 수 있습니다."),
        "moderator": MessageLookupByLibrary.simpleMessage("사역자"),
        "moderators": MessageLookupByLibrary.simpleMessage("사역자들"),
        "moderatorsPrivileges": MessageLookupByLibrary.simpleMessage(
            "1. 사역자는 다른 사람을 초대하거나 가입 요청을 수락할 수 있습니다:2. 사역자는 중보 기도문을 게시할 수 있습니다.:3. 사역자는 기도 시간에 대한 알림을 설정할 수 있습니다."),
        "name": MessageLookupByLibrary.simpleMessage("이름"),
        "notifications": MessageLookupByLibrary.simpleMessage("알림"),
        "open": MessageLookupByLibrary.simpleMessage("공개"),
        "pickImage": MessageLookupByLibrary.simpleMessage("이미지 선택"),
        "pickImageFromGallery":
            MessageLookupByLibrary.simpleMessage("갤러리에서 사진 가져오기"),
        "placeholderBibleVerse":
            MessageLookupByLibrary.simpleMessage("성경 구절을 고르세요"),
        "placeholderPrayer":
            MessageLookupByLibrary.simpleMessage("하늘에 계신 우리 아버지"),
        "placeholderReminder":
            MessageLookupByLibrary.simpleMessage("기도 시간 입니다..."),
        "placeholderSearch": MessageLookupByLibrary.simpleMessage("검색"),
        "pray": MessageLookupByLibrary.simpleMessage("기도"),
        "prayAnonymoous": MessageLookupByLibrary.simpleMessage("익명으로 기도"),
        "prayDuration": MessageLookupByLibrary.simpleMessage("기도 기간"),
        "prayWithName": MessageLookupByLibrary.simpleMessage("공개적으로 기도하시겠습니까?"),
        "prayWithOthers": MessageLookupByLibrary.simpleMessage("다른 사람과 기도해보세요"),
        "prayWithWordFormBible":
            MessageLookupByLibrary.simpleMessage("- 마태복음 22:39 (개역개정)"),
        "prayWithWordFormBibleVerse": MessageLookupByLibrary.simpleMessage(
            "둘째도 그와 같으니 네 이웃을 네 자신 같이 사랑하라 하셨으니"),
        "prayWithWords": MessageLookupByLibrary.simpleMessage("목소리로 기도하기"),
        "prayer": MessageLookupByLibrary.simpleMessage("기도문"),
        "prayers": MessageLookupByLibrary.simpleMessage("기도문"),
        "prays": MessageLookupByLibrary.simpleMessage("기도"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("개인정보 처리방침"),
        "private": MessageLookupByLibrary.simpleMessage("비공개"),
        "profile": MessageLookupByLibrary.simpleMessage("프로필"),
        "promote": MessageLookupByLibrary.simpleMessage("임명"),
        "ratePrayer": MessageLookupByLibrary.simpleMessage("Prayer 리뷰 남기기"),
        "readmore": MessageLookupByLibrary.simpleMessage("더보기"),
        "reminder": MessageLookupByLibrary.simpleMessage("알림"),
        "removeCurrentPhoto":
            MessageLookupByLibrary.simpleMessage("현재 사진 제거하기"),
        "requested": MessageLookupByLibrary.simpleMessage("요청됨"),
        "requests": MessageLookupByLibrary.simpleMessage("가입 요청"),
        "resetToDefault": MessageLookupByLibrary.simpleMessage("기본값으로 초기화"),
        "restricted": MessageLookupByLibrary.simpleMessage("제한됨"),
        "revoke": MessageLookupByLibrary.simpleMessage("철회"),
        "revoked": MessageLookupByLibrary.simpleMessage("철회됨"),
        "searchGroup": MessageLookupByLibrary.simpleMessage("그룹 찾기"),
        "sendFeedback": MessageLookupByLibrary.simpleMessage("피드백 보내기"),
        "sendInvitation": MessageLookupByLibrary.simpleMessage("초대하기"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "shareAppMessage": m6,
        "sharePrayer": MessageLookupByLibrary.simpleMessage("Prayer 공유하기"),
        "signInWithApple": MessageLookupByLibrary.simpleMessage("애플로 로그인하기"),
        "signInWithGoogle": MessageLookupByLibrary.simpleMessage("구글로 로그인하기"),
        "signOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "signUpScreenBibleVerse": MessageLookupByLibrary.simpleMessage(
            "항상 기뻐하라, 쉬지 말고 기도하라, 범사에 감사하라 이것이 그리스도 예수 안에서 너희를 향하신 하나님의 뜻이라"),
        "signUpScreenBibleVerseBook":
            MessageLookupByLibrary.simpleMessage("데살로니가전서 5:16-18 (개역개정)"),
        "someoneHasPrayed": m7,
        "startedAt": MessageLookupByLibrary.simpleMessage("시작"),
        "termsOfUse": MessageLookupByLibrary.simpleMessage("이용약관"),
        "title": MessageLookupByLibrary.simpleMessage("제목"),
        "titleAnonymously":
            MessageLookupByLibrary.simpleMessage("익명 기도문은 누가 올렸는지 확인할 수 없습니다"),
        "titleConfirmDeleteCorporatePrayer":
            MessageLookupByLibrary.simpleMessage("정말 중보기도를 삭제하시겠습니까?"),
        "titleDeleteAccount":
            MessageLookupByLibrary.simpleMessage("정말 계정을 삭제하시겠습니까?"),
        "titleDeleteCorporatePrayer":
            MessageLookupByLibrary.simpleMessage("중보기도 삭제"),
        "titleGroupDescription": MessageLookupByLibrary.simpleMessage(
            "이 그룹이 어떤 그룹인지 알려주세요. 예) 목적, 미션, 기도제목"),
        "titleGroupType": m8,
        "titleHowToShareYourPrayer":
            MessageLookupByLibrary.simpleMessage("어떻게 기도문을 공유하시겠습니까?"),
        "titleInvitePeople": m9,
        "titleInvitePeopleDescription": MessageLookupByLibrary.simpleMessage(
            "초대받은 사용자는 알림을 받고 관리자의 승인 없이 그룹에 가입할 수 있습니다. 다른 관리자가 이 초대를 철회할 수 도 있습니다."),
        "titleMemberCanPostOnly": MessageLookupByLibrary.simpleMessage(
            "2. 그룹 멤버들만 기도문을 게시하고 기도 활동에 참여할 수 있습니다"),
        "titleMembershipType": MessageLookupByLibrary.simpleMessage(
            "누가 그룹을 가입할 수 있는지 선택해주세요. 이 선택은 나중에 바꿀 수 없습니다."),
        "titleMembershipTypeOpen": MessageLookupByLibrary.simpleMessage(
            "1. 누구나 그룹내 모든 기도문을 볼 수 있고, 가입을 자유롭게 할 수 있습니다."),
        "titleMembershipTypePrivate": MessageLookupByLibrary.simpleMessage(
            "1. 그룹이 검색되지 않고, 가입하기 위해서는 초대받아야 합니다."),
        "titleMembershipTypeRestricted": MessageLookupByLibrary.simpleMessage(
            "1. 그룹을 가입하기 위해 승인이 필요하고, 멤버들만 그룹 내 기도문을 볼 수 있습니다."),
        "titlePrayerPostAnonymously":
            MessageLookupByLibrary.simpleMessage("익명으로 공유하기"),
        "titlePrayerPostPublicly":
            MessageLookupByLibrary.simpleMessage("공개적으로 공유하기"),
        "titlePromoteUser": m10,
        "titleReminderNotifyOn": m11,
        "titleTimezoneWillBeUsed": MessageLookupByLibrary.simpleMessage(
            "내 시간대를 기준으로 다른 사람에게 알림이 전송됩니다"),
        "titleWithName": MessageLookupByLibrary.simpleMessage(
            "사용자들이 당신의 기도문과 당신의 이름을 볼 수 있습니다"),
        "titleYourPrayerHasBeenReceived":
            MessageLookupByLibrary.simpleMessage("이미 기도하신 제목입니다"),
        "username": MessageLookupByLibrary.simpleMessage("아이디"),
        "users": MessageLookupByLibrary.simpleMessage("유저"),
        "versionText": m12,
        "weekdays": MessageLookupByLibrary.simpleMessage("주중"),
        "weekend": MessageLookupByLibrary.simpleMessage("주말"),
        "withName": MessageLookupByLibrary.simpleMessage("공개")
      };
}
