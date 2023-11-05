//
//  ImageLiterals.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

enum ImageLiterals {
    // icon
    static var archiveIcStartFill: UIImage { .load(named: "archive_ic_start_fill") }
    static var archiveIcStart: UIImage { .load(named: "archive_ic_start") }
    static var archiveImgMessage: UIImage { .load(named: "archive_img_message") }
    static var backBtnImage: UIImage { .load(named: "back_btn_image") }
    static var bannerIcCheck: UIImage { .load(named: "banner_ic_check") }
    static var diaryArrowBack: UIImage { .load(named: "diary_arrow_back") }
    static var diaryArrowNextDisabled: UIImage { .load(named: "diary_arrow_next_disabled") }
    static var diaryArrowNextEnabled: UIImage { .load(named: "diary_arrow_next_enabled") }
    static var diaryImgAlbum: UIImage { .load(named: "diary_img_album") }
    static var diaryImgCalender: UIImage { .load(named: "diary_img_calender") }
    static var diaryImgCamera: UIImage { .load(named: "diary_img_camera") }
    static var diaryImgEmoSpeachBubble: UIImage { .load(named: "diary_img_emo_speach_bubble") }
    static var diaryImgGood1: UIImage { .load(named: "diary_img_good1") }
    static var diaryImgGood2: UIImage { .load(named: "diary_img_good2") }
    static var diaryImgMessage: UIImage { .load(named: "diary_img_message") }
    static var diaryImgSpeachBubble: UIImage { .load(named: "diary_img_speach_bubble") }
    static var diaryReduceDefault: UIImage { .load(named: "diary_reduce_default") }
    static var gallaryBtnImageFill: UIImage { .load(named: "gallary_btn_image_fill") }
    static var gallaryBtnImage: UIImage { .load(named: "gallary_btn_image") }
    static var homeBtnBubble: UIImage { .load(named: "home_btn_bubble") }
    static var homeIcArchiveFill: UIImage { .load(named: "home_ic_archive_fill") }
    static var homeIcArchive: UIImage { .load(named: "home_ic_archive") }
    static var homeIcConversationFill: UIImage { .load(named: "home_ic_conversation_fill") }
    static var homeIcConversation: UIImage { .load(named: "home_ic_conversation") }
    static var homeIcDiaryFill: UIImage { .load(named: "home_ic_diary_fill") }
    static var homeIcDiary: UIImage { .load(named: "home_ic_diary") }
    static var homeIcHome: UIImage { .load(named: "home_ic_home") }
    static var homeIcHomeFill: UIImage { .load(named: "home_ic_home_fill") }
    static var homeBtnMissionAlarm: UIImage { .load(named: "home_btn_mission_alarm") }
    static var homeBtnMission: UIImage { .load(named: "home_btn_mission") }
    static var homeBtnMypageAlarm: UIImage { .load(named: "home_btn_mypage_alarm") }
    static var homeBtnMypage: UIImage { .load(named: "home_btn_mypage") }
    static var homeBtnShare: UIImage { .load(named: "home_btn_share") }
    static var homeIcMenuBook: UIImage { .load(named: "home_ic_menu_book") }
    static var homeIcMenuClose: UIImage { .load(named: "home_ic_menu_close") }
    static var homeIcMenuSnack: UIImage { .load(named: "home_ic_menu_snack") }
    static var homeIcMenuStore: UIImage { .load(named: "home_ic_menu_store") }
    static var homeIcMenu: UIImage { .load(named: "home_ic_menu") }
    static var homeIcMissionFill: UIImage { .load(named: "home_ic_mission_fill") }
    static var homeIcMypageFill: UIImage { .load(named: "home_ic_mypage_fill") }
    static var homeIcMypage: UIImage { .load(named: "home_ic_mypage") }
    static var homeIcPopupClose: UIImage { .load(named: "home_ic_popup_close") }
    static var homeIcStatisticsFill: UIImage { .load(named: "home_ic_statistics_fill") }
    static var homeIcStatistics: UIImage { .load(named: "home_ic_statistics") }
    static var homeIcTalking: UIImage { .load(named: "home_ic_talking") }
    static var homeImgSnackscore: UIImage { .load(named: "home_img_snackscore") }
    static var homeImgTo: UIImage { .load(named: "home_img_to") }
    static var homeImgTodaysCompleteFill: UIImage { .load(named: "home_img_todayscomplete_fill") }
    static var homeImgTodaysComplete: UIImage { .load(named: "home_img_todayscomplete") }
    static var introIcCheckFill: UIImage { .load(named: "intro_ic_check_fill") }
    static var introIcCheck: UIImage { .load(named: "intro_ic_check") }
    static var introImgCalender: UIImage { .load(named: "intro_img_calender") }
    static var introImgExplainMission: UIImage { .load(named: "intro_img_explain_mission") }
    static var missionProgressFill: UIImage { .load(named: "mission_progress_fill") }
    static var missionProgress: UIImage { .load(named: "mission_progress") }
    static var mypageIcBack: UIImage { .load(named: "mypage_ic_back") }
    static var mypageIcToggle: UIImage { .load(named: "mypage_ic_toggle") }
    static var questionBtn: UIImage { .load(named: "question_btn") }
    static var talkingBtnQuestion: UIImage { .load(named: "talking_btn_question") }
    static var toBtnImage: UIImage { .load(named: "to_btn_image") }
    static var tomeLogo: UIImage { .load(named: "tome_logo") }
    static var topbar: UIImage { .load(named: "topbar") }
    static var visitiorIcLock: UIImage { .load(named: "visitior_ic_lock") }
    static var warningIc: UIImage { .load(named: "warning_ic") }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
