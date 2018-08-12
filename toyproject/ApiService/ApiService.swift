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
        v.titleText = "젤다의 전설 브레스 오브 더 와일드 [1화] 한글로 즐기는 젤다의 첫 발걸음!"
        v.thumbnailImageName = "dora"
        v.username = "도라"
        
        v.thumbnailImageUrl = "https://i.ytimg.com/vi/wopX0OE6esM/hqdefault.jpg?sqp=-oaymwEXCPYBEIoBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLA2Oj9p4dLqvmHB9ZfOdmQUfarndA"
        videoContent.append(v)
        let vd = VideoContent()
        vd.titleText = "젤다의 전설 브레스 오브 더 와일드 [1화] 한글로 즐기는 젤다의 첫 발걸음!"
        vd.thumbnailImageName = "dora"
        vd.username = "도라"
        vd.thumbnailImageUrl = "https://i.ytimg.com/vi/wopX0OE6esM/hqdefault.jpg?sqp=-oaymwEXCPYBEIoBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLA2Oj9p4dLqvmHB9ZfOdmQUfarndA"
        videoContent.append(vd)
        completion(ContentResult<[VideoContent]>.success(videoContent))
    }
    func fetchBookContents(completion : @escaping (ContentResult<[BookContent]>)-> ()) {
        var bookContent = [BookContent]()
        var v = BookContent(createdTime: Date(), title: "나미야 잡화점의 기적", content: "따뜻한 고민 상담실 ‘나미야 잡화점’으로 오세요!\n일본을 대표하는 소설가 히가시노 게이고의 신작 『나미야 잡화점의 기적』. 2012년 일본 중앙공론문예상 수상작으로, 작가가 그동안 추구해온 인간 내면에 잠재한 선의에 대한 믿음이 작품 전반에 녹아 있다. 오래된 잡화점을 배경으로, 기묘한 편지를 주고받는다는 설정을 통해 따뜻한 이야기를 들려준다.\n30여 년간 비어 있던 오래된 가게인 나미야 잡화점. 어느 날 그곳에 경찰의 눈을 피해 달아나던 삼인조 도둑이 숨어든다. 난데없이 ‘나미야 잡화점 주인’ 앞으로 의문의 편지 한 통이 도착하고, 세 사람은 얼떨결에 편지를 열어본다. 처음에는 장난이라고 생각하던 세 사람은 어느새 편지 내용에 이끌려 답장을 해주기 시작하는데….", price: 13220, thumbnailImageUrl: "http://image.kyobobook.co.kr/images/book/large/194/l9788972756194.jpg")
        bookContent.append(v)
        
         v = BookContent(createdTime: Date(), title: "유성의 인연", content: "가족이라는 인연의 끈으로 묶인 세 남매! \n일본 미스터리계의 거장 히가시노 게이고의 장편소설『유성의 인연』제1권. 2008년 일본 드라마 시청율 1위에 오른 <유성의 인연>의 원작소설이다. 끔찍한 강도 살인사건으로 부모님을 잃은 세 남매가 별똥별 아래 맹세한 인연의 끈으로 세상을 헤쳐나가면서, 부모님을 죽인 범인을 밝히기 위해 고군분투하는 모습을 그리고 있다. ", price: 13220, thumbnailImageUrl: "http://image.kyobobook.co.kr/images/book/large/282/l9788972754282.jpg")
        bookContent.append(v)
        completion(ContentResult<[BookContent]>.success(bookContent))
    }
    
}
