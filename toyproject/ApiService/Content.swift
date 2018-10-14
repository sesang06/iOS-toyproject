import UIKit
import Photos

enum PostContentType {
    case asset
    case image
}
class PostContent : NSObject {
    var asset : PHAsset?
    var selectedNumber : Int?
    var image : UIImage?
    let type : PostContentType
    init(type : PostContentType) {
        self.type = type
    }
}
class GameContent : NSObject {
    var createdTime : Date?
    var title : String?
    var thumbnailImageName : String?
    var content : String?
}
class BookContent : NSObject {
    var createdTime : Date?
    var title : String?
    var thumbnailImageName : String?
    var content : String?
    var price : Int? //가격
    var index : String? //목차
    var author : String? //저자
    var grade : Float? //평점
    var publisher : String? //출판사
    var thumbnailImageUrl : String?
    
    convenience init(createdTime : Date, title : String, content : String, price : Int, thumbnailImageUrl : String){
       self.init()
        self.createdTime = createdTime
        self.title = title
        self.content = content
        self.price = price
        self.thumbnailImageUrl = thumbnailImageUrl
    }
    
}
class MovieContent : NSObject {
    var thumbnailImageNames : [String]? //섬네일을 가져가기 위한 이미지뷰 (멀티)
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
    var profileImageName : String? //섬네일을 가져온다
}
class PhotoContent : NSObject {
    var thumbnailImageName : String? //섬네일을 가져가기 위한 이미지뷰
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
    var imageHeight : CGFloat? //이미지 하이트
    var imageWidth : CGFloat?
}

/*
 비디오
 */
class VideoContent : NSObject {
    var thumbnailImageName : String? //섬네일을 가져가기 위한 이미지뷰
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
    var imageHeight : CGFloat? //이미지 하이트
    var imageWidth : CGFloat?
    var username : String?
    var thumbnailImageUrl : String? //이미지뷰
}

class ProfileContent : NSObject {
    var nickname : String? //닉네임
    var profile : String? //소개
    var avatarImageName : String? //아바타 네임
    var backImageName : String?
    
}
