//
//  DGTXImageViewPresetImages.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 01.07.2021.
//

import Foundation
import UIKit

enum DGTXImageViewPresetImages {
    case none
    case appTitle
    case bigLogo
    case defaultAvatar
    case likeFill
    case dropDown
    case bxrToken
    case recentSearch
    case followUser
    case defaultCover
    case bucket
    case addAvatar
    case takePhotoCircle
    case plus
    case pencil
    case defaultGroupAvatar
    case emptyAvatar
    case phone
    case mail
    case webpage
    case location
    case reply
    case replyOpen
    case mainHud
    case defaultArcticleCover
    case bell
    case earlyAccessLogo
    
    case newPost
    case search
    case like
    case liked
    case comment
    case share
    case more
    case info
    case takePhoto
    case mediaContent
    case newGroup
    case edit
    case addUser
    case members
    case files
    case sendMessage
    case attachment
    case message
    case compas
    
    case select(DGTXImageViewSelectPresetImages)
    case actionSheetButtons(DGTXImageViewActionSheetButtonsPresetImages)
    case privacy(DGTXImageViewPrivacyPresetImages)
    case menu(DGTXImageViewMenuItemPresetImages)
    case contextMenu(DGTXImageViewContextMenuItemPresetImages)
    case decorations(DGTXDecorationPresetImages)
    case arrows(DGTXImageArrowsPresetImages)
    case lines(DGTXImageLinesPresetImages)
    case notifications(DGTXImageNotificationsPresetImages)
    case social(DGTXSocialPresetImages)
    case errors(DGTXImageErrorsPresetImages)
    case notificationOptions(DGTXNotificationsOptionPresetImages)
    case polls(DGTXImageViewPollPresetImages)
    
    case close(DGTXButtonClosePresetImages)
    case checkBox(DGTXButtonCheckBoxPressetImage)
    case eye(DGTXButtonEyePresetImages)
    case radioButton(DGTXRadioButtonPressetImage)
    case settings(DGTXSettingsButtonPressetImage)
    case group(DGTXGroupButtonPresetImage)
    case favorite(DGTXFavoriteButtonPresetImage)
    case welcomeSlider(DGTXWelcomeSliderPresetImage)
    case blockdeskBanner(DGTXBlockdeskBannerPresetImage)
}


enum DGTXImageViewPollPresetImages: String {
    case pollUnchecked = "poll_circle"
    case pollChenkmark = "poll_checkmark"
}

enum DGTXImageViewSelectPresetImages: String {
    case grey = "selectGrey"
    case green = "selectGreen"
    case main = "rightArrow"
    case date = "dateSelect"
    case copy = "copy"
}

enum DGTXImageViewActionSheetButtonsPresetImages: String {
    case takePhoto = "takePhotoIcon"
    case photoFromLibrary = "libraryPhotoIcon"
    case editPhoto = "editPhotoIcon"
    case deletePhoto = "deletePhotoIcon"
    case video = "video"
    case gif = "gif"
    case block = "blockActionIcon"
    case follow = "followActionIcon"
    case makeAdmin = "makeAdminActionIcon"
    case removeAdmin = "removeAdminActionIcon"
    case message = "messageActionIcon"
    case privileges = "privilegesActionIcon"
    case profile = "profileActionIcon"
    case remove = "removeActionIcon"
    case report = "reportActionIcon"
    case search = "searchActionIcon"
    case copyLink = "copyLinkActionIcon"
    case activities = "activitiesActionIcon"
    case logout = "logoutActionIcon"
    case darkMode = "darkModeActionIcon"
    case editPost = "editPostActionIcon"
    case disableComments = "disableCommentsActionIcon"
    case hide = "hideActionIcon"
    case shareInTimeline = "shareInTimeline"
    case shareLink = "shareLink"
    case login = "loginActionIcon"
}

enum DGTXImageViewPrivacyPresetImages: String {
    case onlyMe = "private"
    case everyone = "global"
    case following = "userSmallIcon"
    case followed = "usersSmallIcon"
}

enum DGTXImageViewMenuItemPresetImages: String {
    case network = "menuNetwork"
    case pages = "menuPages"
    case referal = "menuReferal"
    case groups = "menuGroups"
    case blockwatch = "menuBlockwatch"
    case saved = "menuSaved"
    case blockademy = "menuBlockademy"
    case discover = "menuDiscover"
    case support = "menuSupport"
    case darkMode = "menuDarkMode"
    case logout = "menuLogout"
}

enum DGTXImageViewContextMenuItemPresetImages: String {
    case messageForward = "messageForward"
    case messageReply = "messageReply"
    case messageDelete = "messageDelete"
    case commentReport = "commentReport"
    case commentEdit = "commentEdit"
}

enum DGTXDecorationPresetImages: String {
    case square = "decoration1"
    case roll = "decoration2"
    case spiral = "decoration3"
    case message = "decoration4"
}

enum DGTXImageArrowsPresetImages: String {
    case right = "rightArrow"
    case bottom = "bottomArrow"
}

enum DGTXImageLinesPresetImages: String {
    case vertical = "verticalLine"
}

enum DGTXImageNotificationsPresetImages: String {
    case success = "notificationSuccessIcon"
    case warning = "notificationWarningIcon"
}

enum DGTXSocialPresetImages: String {
    case fb = "fb_small"
    case insta = "insta_small"
    case vk = "vk_small"
    case linkedin = "linkedin_small"
    case twitter = "twitter_small"
    case youtube = "youtube_small"
    case appleLogo = "apple_logo"
    case googleLogo = "google_logo"
    case facebookLogo = "fb_logo"
}

enum DGTXNotificationsOptionPresetImages: String {
    case all = "notificationsAllOption"
    case sounds = "notificationsSoundsOption"
    case likes = "notificationsLikesOption"
    case share = "notificationsShareOption"
    case comments = "notificationsCommentsOption"
    case followings = "notificationsFollowingsOption"
    case invites = "notificationsInvitesOption"
    case mentions = "notificationsMentionsOption"
    case messages = "notificationsMessagesOption"
    case posts = "notificationsPostsOption"
    case replies = "notificationsRepliesOption"
    case requests = "notificationsRequestsOption"
    case joins = "notificationsJoinsOption"
}

enum DGTXImageErrorsPresetImages: String {
    case lostConnection = "lostInternetConnectionError"
}

enum DGTXButtonCheckBoxPressetImage: String {
    case selected = "checkbox_selected"
    case deselected = "checkbox_deselected"
}

enum DGTXButtonClosePresetImages: String {
    case main = "closeMain"
    case back = "backArrow"
    case circle = "circleClose"
}

enum DGTXButtonEyePresetImages: String {
    case show = "eye_open"
    case hide = "eye_hide"
}

enum DGTXRadioButtonPressetImage: String {
    case selected = "radioButtonSelected"
    case deselected = "radioButtonUnselect"
}

enum DGTXSettingsButtonPressetImage: String {
    case main = "settings"
    case menu = "menuSettings"
    case feedTags = "tagsSettings"
}

enum DGTXGroupButtonPresetImage: String {
    case joined = "groupJoined"
    case requested = "groupRequested"
    case notConsist = "groupNotConsist"
}

enum DGTXFavoriteButtonPresetImage: String {
    case selected = "favoriteSelect"
    case deselected = "favorite"
}

enum DGTXWelcomeSliderPresetImage: String {
    case background = "welcomeSliderBg"
    case slide1 = "welcomeSlider1"
    case slide2 = "welcomeSlider2"
    case slide3 = "welcomeSlider3"
    case slide4 = "welcomeSlider4"
    case slide5 = "welcomeSlider5"
}

enum DGTXBlockdeskBannerPresetImage: String {
    case enableNotifications    = "bannerEnableNotifications"
    case joinBlockster          = "bannerJoinBlockster"
    case close                  = "bannerCloseButton"
}

extension DGTXImageViewPresetImages {
    var image: UIImage? {
        switch self {
        case .none:
            return nil
        case .appTitle:
            return UIImage(named: "app_name_title")
        case .bigLogo:
            return UIImage(named: "big_logo")
        case .defaultAvatar:
            return UIImage(named: "default_avatar")
        case .likeFill:
            return UIImage(named: "likeFill")
        case .dropDown:
            return UIImage(named: "dropdown")
        case .bxrToken:
            return UIImage(named: "bxr_token")
        case .recentSearch:
            return UIImage(named: "recentSearch")
        case .followUser:
            return UIImage(named: "follow_user_icon")
        case .defaultCover:
            return UIImage(named: "defaultUserCover")
        case .bucket:
            return UIImage(named: "bucket")
        case .addAvatar:
            return UIImage(named: "addPhotoBigIcon")
        case .takePhotoCircle:
            return UIImage(named: "takePhotoCircleIcon")
        case .plus:
            return UIImage(named: "plusIcon")
        case .pencil:
            return UIImage(named: "pencil")
        case .defaultGroupAvatar:
            return UIImage(named: "emptyGroup")
        case .emptyAvatar:
            return UIImage(named: "emptyAvatar")
        case .phone:
            return UIImage(named: "phoneIcon")
        case .mail:
            return UIImage(named: "mailIcon")
        case .webpage:
            return UIImage(named: "global")
        case .location:
            return UIImage(named: "location")
        case .reply:
            return UIImage(named: "reply")
        case .replyOpen:
            return UIImage(named: "replyOpen")
        case .mainHud:
            return UIImage(named: "hudIcon")
        case .defaultArcticleCover:
            return UIImage(named: "articleDefaultCover")
        case .bell:
            return UIImage(named: "bell")
        case .select(let value):
            return UIImage(named: value.rawValue)
        case .actionSheetButtons(let value):
            return UIImage(named: value.rawValue)
        case .privacy(let value):
            return UIImage(named: value.rawValue)
        case .menu(let value):
            return UIImage(named: value.rawValue)
        case .contextMenu(let value):
            switch value {
            case .messageDelete:
                return UIImage(named: value.rawValue)?.withRenderingMode(.alwaysTemplate)
            default:
                return UIImage(named: value.rawValue)
            }
        case .decorations(let value):
            return UIImage(named: value.rawValue)
        case .arrows(let value):
            return UIImage(named: value.rawValue)
        case .lines(let value):
            return UIImage(named: value.rawValue)
        case .notifications(let value):
            return UIImage(named: value.rawValue)
        case .social(let value):
            return UIImage(named: value.rawValue)
        case .errors(let value):
            return UIImage(named: value.rawValue)
        case .notificationOptions(let value):
			return UIImage(named: value.rawValue)
        case .polls(let value):
            return UIImage(named: value.rawValue)
        case .close(let key):
            return UIImage(named: key.rawValue)
        case .checkBox(let key):
            return UIImage(named: key.rawValue)
        case .eye(let key):
            return UIImage(named: key.rawValue)
        case .radioButton(let key):
            return UIImage(named: key.rawValue)
        case .settings(let key):
            return UIImage(named: key.rawValue)
        case .group(let key):
            return UIImage(named: key.rawValue)
        case .favorite(let key):
            return UIImage(named: key.rawValue)
        case .newPost:
            return UIImage(named: "addCircle")
        case .search:
            return UIImage(named: "search")
        case .like:
            return UIImage(named: "like")
        case .liked:
            return UIImage(named: "liked")
        case .comment:
            return UIImage(named: "comment")
        case .share:
            return UIImage(named: "share")
        case .more:
            return UIImage(named: "moreActions")
        case .info:
            return UIImage(named: "infoCircle")
        case .takePhoto:
            return UIImage(named: "takePhotoButton")
        case .mediaContent:
            return UIImage(named: "imageIcon")
        case .newGroup:
            return UIImage(named: "pencilCreate")
        case .edit:
            return UIImage(named: "pencil")
        case .addUser:
            return UIImage(named: "addUser")
        case .members:
            return UIImage(named: "usersSmallIcon")
        case .files:
            return UIImage(named: "fileIcon")
        case .sendMessage:
            return UIImage(named: "sendMessage")
        case .attachment:
            return UIImage(named: "attachment")
        case .message:
            return UIImage(named: "messageIcon")
        case .compas:
            return UIImage(named: "compas")
        case .welcomeSlider(let key):
            return UIImage(named: key.rawValue)
        case .blockdeskBanner(let key):
            return UIImage(named: key.rawValue)
        case .earlyAccessLogo:
            return UIImage(named: "earlyAccessLogo")
        }
    }
}
