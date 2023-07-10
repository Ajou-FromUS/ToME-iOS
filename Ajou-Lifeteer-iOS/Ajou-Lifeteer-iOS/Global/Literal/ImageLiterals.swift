//
//  ImageLiterals.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

enum ImageLiterals {
    // icon
    static var icAddPhoto: UIImage { .load(named: "ic_add_photo") }
    static var icAdd: UIImage { .load(named: "ic_add") }
    static var icAlertCircle: UIImage { .load(named: "ic_alert_circle") }
    static var icBack: UIImage { .load(named: "ic_back") }
    static var icBasket: UIImage { .load(named: "ic_basket") }
    static var icBucketListFill: UIImage { .load(named: "ic_bucket_list_fill") }
    static var icBucketList: UIImage { .load(named: "ic_bucket_list") }
    static var icCheck: UIImage { .load(named: "ic_check") }
    static var icDiaryBook: UIImage { .load(named: "ic_diary_book") }
    static var icDiaryFeedFill: UIImage { .load(named: "ic_diary_feed_fill") }
    static var icDiaryFeed: UIImage { .load(named: "ic_diary_feed") }
    static var icDiaryFill: UIImage { .load(named: "ic_diary_fill") }
    static var icDiaryListFill: UIImage { .load(named: "ic_diary_list_fill") }
    static var icDiaryList: UIImage { .load(named: "ic_diary_list") }
    static var icDiary: UIImage { .load(named: "ic_diary") }
    static var icEmotionScroller: UIImage { .load(named: "ic_emotion_scroller") }
    static var icHealthFill: UIImage { .load(named: "ic_health_fill") }
    static var icHealth: UIImage { .load(named: "ic_health") }
    static var icImagePlus: UIImage { .load(named: "ic_image_plus") }
    static var icInfo: UIImage { .load(named: "ic_info") }
    static var icInvisible: UIImage { .load(named: "ic_invisible") }
    static var icKakaoClose: UIImage { .load(named: "ic_kakao_close") }
    static var icLaw: UIImage { .load(named: "ic_law") }
    static var icLetterFill: UIImage { .load(named: "ic_letter_fill") }
    static var icLetter: UIImage { .load(named: "ic_letter") }
    static var icMenu: UIImage { .load(named: "ic_menu") }
    static var icMic: UIImage { .load(named: "ic_mic") }
    static var icMindsetBI: UIImage { .load(named: "ic_mindset_BI") }
    static var icMindsetFill: UIImage { .load(named: "ic_mindset_fill") }
    static var icMindset: UIImage { .load(named: "ic_mindset") }
    static var icMoodBad: UIImage { .load(named: "ic_mood_bad") }
    static var icMoodGood: UIImage { .load(named: "ic_mood_good") }
    static var icMoodSoso: UIImage { .load(named: "ic_mood_soso") }
    static var icMoodTooBad: UIImage { .load(named: "ic_mood_too_bad") }
    static var icMoodVeryGood: UIImage { .load(named: "ic_mood_very_good") }
    static var icMypageFill: UIImage { .load(named: "ic_mypage_fill") }
    static var icMypage: UIImage { .load(named: "ic_mypage") }
    static var icPencil: UIImage { .load(named: "ic_pencil") }
    static var icPeople: UIImage { .load(named: "ic_people") }
    static var icPlus: UIImage { .load(named: "ic_plus") }
    static var icRecordedWillCalendar: UIImage { .load(named: "ic_recorded_will_calendar") }
    static var icRecordedWillCheck: UIImage { .load(named: "ic_recorded_will_check") }
    static var icRecordedWillFill: UIImage { .load(named: "ic_recorded_will_fill") }
    static var icRecordedWillRecordPlay: UIImage { .load(named: "ic_recorded_will_record_play") }
    static var icRecordedWillRecordStop: UIImage { .load(named: "ic_recorded_will_record_stop") }
    static var icRecordedWillRecord: UIImage { .load(named: "ic_recorded_will_record") }
    static var icRecordedWillStopPlay: UIImage { .load(named: "ic_recorded_will_stop_play") }
    static var icRecordedWill: UIImage { .load(named: "ic_recorded_will") }
    static var icTextBubble: UIImage { .load(named: "ic_text_bubble") }
    static var icTrash: UIImage { .load(named: "ic_trash") }
    static var icVisible: UIImage { .load(named: "ic_visible") }
    static var icWeatherCloudy: UIImage { .load(named: "ic_weather_cloudy") }
    static var icWeatherFoggy: UIImage { .load(named: "ic_weather_foggy") }
    static var icWeatherRainbow: UIImage { .load(named: "ic_weather_rainbow") }
    static var icWeatherSnowy: UIImage { .load(named: "ic_weather_snowy") }
    static var icWeatherSomeCloud: UIImage { .load(named: "ic_weather_some_cloud") }
    static var icWeatherSomeRainy: UIImage { .load(named: "ic_weather_some_rainy") }
    static var icWeatherStormy: UIImage { .load(named: "ic_weather_stormy") }
    static var icWeatherSunny: UIImage { .load(named: "ic_weather_Sunny") }
    static var icWeatherSuperRainy: UIImage { .load(named: "ic_weather_super_rainy") }
    static var icX: UIImage { .load(named: "ic_x") }
    static var imgLandingPage1: UIImage { .load(named: "img_LandingPage_1") }
    static var imgLandingPage2: UIImage { .load(named: "img_LandingPage_2") }
    static var imgLandingPage3: UIImage { .load(named: "img_LandingPage_3") }
    static var imgQnA: UIImage { .load(named: "img_QnA") }
    static var imgVisitor: UIImage { .load(named: "img_Visitor") }
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
