import UIKit
import Alamofire
import SwiftyJSON

/**
 인터넷 익스플로링
 
 **/
enum Method : String {
    case recentPhotos = "photos"
    case recentVideo = "video"
}
enum ContentResult<T> {
    case success(T)
    case failure(Error)
}

class ApiService : NSObject {
    
    static let shared = ApiService()
    let baseUrl = "http://naver.com" //base URL
    func baseFetch(method :  Method,  completion : @escaping (Result<Any>)->() ){
        Alamofire.request("\(baseUrl)/\(method.rawValue)").responseJSON { (responseData) in
            completion(responseData.result)
        }
    }
    
    func fetchPhotoContents( completion : @escaping (ContentResult<[PhotoContent]>)-> ()) {
        self.baseFetch(method: Method.recentPhotos) { (result) in
            switch (result){
            case let .failure(error):
                completion(ContentResult<[PhotoContent]>.failure(error))
                break
            case let .success(value):
                
                break
            }
        }
    }
    
    func fetchVideoContents(completion : @escaping (ContentResult<[VideoContent]>)-> ()) {
        var videoContent = [VideoContent]()
        let v = VideoContent()
        v.titleText = "Apple - WWDC 2017 Keynote"
        v.thumbnailImageName = "dora"
        v.username = "Apple"
        
        v.thumbnailImageUrl = "https://i.ytimg.com/vi/oaqHdULqet0/hqdefault.jpg"
        videoContent.append(v)
        let vd = VideoContent()
        vd.titleText = "Apple - WWDC 2018 Keynote"
        vd.thumbnailImageName = "dora"
        vd.username = "Apple"
        vd.thumbnailImageUrl = "https://i.ytimg.com/vi/UThGcWBIMpU/hqdefault.jpg"
        videoContent.append(vd)
        let va = VideoContent()
        va.titleText = "A few new thing made by google"
        va.thumbnailImageName = "dora"
        va.username = "Google"
        va.thumbnailImageUrl = "https://i.ytimg.com/vi/bkRhoGPo2is/hqdefault.jpg"
        videoContent.append(va)
        completion(ContentResult<[VideoContent]>.success(videoContent))
    }
    func fetchBookContents(completion : @escaping (ContentResult<[BookContent]>)-> ()) {
        var bookContent = [BookContent]()
        var v = BookContent(createdTime: Date(), title: "나미야 잡화점의 기적", content: "따뜻한 고민 상담실 ‘나미야 잡화점’으로 오세요!\n일본을 대표하는 소설가 히가시노 게이고의 신작 『나미야 잡화점의 기적』. 2012년 일본 중앙공론문예상 수상작으로, 작가가 그동안 추구해온 인간 내면에 잠재한 선의에 대한 믿음이 작품 전반에 녹아 있다. 오래된 잡화점을 배경으로, 기묘한 편지를 주고받는다는 설정을 통해 따뜻한 이야기를 들려준다.\n30여 년간 비어 있던 오래된 가게인 나미야 잡화점. 어느 날 그곳에 경찰의 눈을 피해 달아나던 삼인조 도둑이 숨어든다. 난데없이 ‘나미야 잡화점 주인’ 앞으로 의문의 편지 한 통이 도착하고, 세 사람은 얼떨결에 편지를 열어본다. 처음에는 장난이라고 생각하던 세 사람은 어느새 편지 내용에 이끌려 답장을 해주기 시작하는데….", price: 13220, thumbnailImageUrl: "http://image.kyobobook.co.kr/images/book/large/194/l9788972756194.jpg")
        bookContent.append(v)
        
         v = BookContent(createdTime: Date(), title: "유성의 인연", content: "가족이라는 인연의 끈으로 묶인 세 남매! \n일본 미스터리계의 거장 히가시노 게이고의 장편소설『유성의 인연』제1권. 2008년 일본 드라마 시청율 1위에 오른 <유성의 인연>의 원작소설이다. 끔찍한 강도 살인사건으로 부모님을 잃은 세 남매가 별똥별 아래 맹세한 인연의 끈으로 세상을 헤쳐나가면서, 부모님을 죽인 범인을 밝히기 위해 고군분투하는 모습을 그리고 있다. ", price: 13220, thumbnailImageUrl: "http://image.kyobobook.co.kr/images/book/large/282/l9788972754282.jpg")
        bookContent.append(v)
        v = BookContent(createdTime: Date(), title: "매스커레이드 나이트", content: "새해 카운트다운이 끝나기 전까지 반드시 체포해야 한다!\n시리즈를 좀처럼 내지 않는 히가시노 게이고. 그런 그가 작가 생활 25주년을 기념한 작품 《매스커레이드 호텔》을 펴내며 ‘유가와 교수’ ‘가가 형사’를 잇는 새로운 캐릭터 ‘닛타 고스케 형사’를 등장시킨 세 번째 시리즈의 시작을 알렸다. 이번 소설 『매스커레이드 나이트』는 인터넷 익명 신고 다이얼로 들어온 의문의 제보로 네리마 원룸 604호실에서 28세 여성의 변사체가 발견되고, 연이어 경시청에 네리마 원룸의 살인범이 호텔 코르테시아도쿄 새해 카운트다운 파티장에 나타나다는 밀고장이 도착하며 벌어지는 이야기를 담았다.\n400명이 넘는 참가자 전원이 가면과 코스튬 차림으로 한 해의 마지막 밤을 즐기는 통칭 '매스커레이드 나이트'. 예고된 날짜까지 남은 시간은 단 사흘! 수년 만에 호텔 유니폼을 입고 직원으로 위장한 엘리트 형사 닛타 고스케와 호텔리어 야마기시 나오미는 다시 한번 고객이라는 가면 아래 숨겨진 맨얼굴을 파헤쳐야 한다. 호텔리어 나오미는 그사이 뛰어난 업무 능력을 인정받아 프런트 직에서 컨시어지로 승격했다. 컨시어지란 고객들의 다양한 희망 사항을 들어주는 자리로, 전편보다 더욱 까다로워진 고객들의 요구에도 기발한 해결책을 내놓는 모습이 소설의 재미를 한층 더한다.", price: 13220, thumbnailImageUrl: "http://image.kyobobook.co.kr/images/book/xlarge/990/x9788972758990.jpg")
        bookContent.append(v)
        completion(ContentResult<[BookContent]>.success(bookContent))
    }
    func fetchGameContents(completion : @escaping (ContentResult<GameContent>)-> ()){
        
    }
    
}
