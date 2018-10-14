# iOS-toyProject
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## 소개
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/video0.gif?raw=true" width="187" height="333"/>

- 개발 중 (2018.6.6 ~ ) 프로젝트
- Snapkit으로 스토리보드 없이 ui 디자인하기
- WkWebview 없는 순수 네이티브 앱 디자인하기
- 각종 에러 핸들링에 유용하고 인터페이스화가 잘 된 almofire api service 구축하기

를 목표로 한 개인프로젝트를 만들고 있습니다.
## 구현스펙
- UICollectionView를 사용한 네이티브 레이아웃 구현

## 사용 라이브러리
- SnapKit : 오토레이아웃 프로그래밍
- Alamofire : 웹 통신용
- SDWebImage : 이미지 렌더링용

## 구현목적
- 페이스북, 유투브, 트위터, 인스타그램, 핀터레스트 등 세계적 앱의 트렌디한 ui를 따라 구현해보고자 해요

## 구현내역

### 홈 네비게이션 바
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image0.png?raw=true" width="187" height="333"/>

- 안드로이드 TabLayout 참고 후 연구

### 뉴스 탭
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image1.png?raw=true" width="187" height="333"/>

### 이미지 탭
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image2.png?raw=true" width="187" height="333"/>

- 핀터레스트 타임라인 레이아웃 참고


### 타임라인 탭
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image3.png?raw=true" width="187" height="333"/>

- 트위터 타임라인 레이아웃 참고
- 이미지 섬네일 개수에 따라서 각각 다른 셀 적용 (1개, 2개, 3개, 4개 이상)

### 책 탭
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image4.png?raw=true" width="187" height="333"/>



### 책 탭 (디테일)
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image5.png?raw=true" width="187" height="333"/>

- 트위터 프로필 사진 레이아웃 참고
- 스크롤을 내리면 책 뷰가 네비게이션 바가 되어 올라감


### 글쓰기 탭 - 1
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image6.png?raw=true" width="187" height="333"/>

- 트위터 글쓰기 레이아웃 참고
- 글을 쓰면 하단 사진 콜렉션뷰가 사라짐

### 글쓰기 탭 - 2
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image7.png?raw=true" width="187" height="333"/>

- 트위터 글쓰기 레이아웃 참고
- 선택한 순서에 따라서 1 , 2 , 3... 출력
- 선택할 때 섬내일이 1초간 축소되었다가 되돌아가는 애니메이션


### 글쓰기 탭 - 3
<img src="https://github.com/sesang06/iOS-toyproject/blob/master/ReadMeImages/image8.png?raw=true" width="187" height="333"/>

- 트위터 글쓰기 레이아웃 참고
- 텍스트 뷰 높이에 따라서 자동 높이 조절

