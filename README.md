
# Intro

使用Reddit API & RxSwift打造一個可以搜尋post和下載縮圖的App。

# Installation

打開termanal並移動到專案位置

``` $ cd .../Reddit-RxSwift-Demo-master/Reddit-RxSwiftDemo   ```

執行pod install (因github上傳檔案限制問題，故沒有把pod檔傳上來)

``` $ pod install  ```


安裝pod後，請打開 Reddit-RxSwiftDemo.xcworkspace
然後可以開始build project，


# Function

1.搜尋post

<img src="https://github.com/mvpscottjon/Reddit-RxSwift-Demo/blob/dev/Sources/home.png" width="414" height="665">

2.若貼文有縮圖，可長按圖片或按下載圖示進行背景下載，下載成功後會顯示儲存成功

3.若貼文有link，則顯示link按鈕，點擊用webView開啟


# Memo
1. 開啟app預設先搜尋TAIWAN，因其貼文thumbnail相對較多，而若清空搜尋字串，會回傳空貼文陣列。

2. 貼文者圖片不是每個人都有，若無則以預設灰色代表圖片區塊

3. 背景下載圖片，預設為存到realm local storage，亦可選擇存到userDefauls(function有做，但要從程式修改storageType)

4. 貼文thumbnail若手動儲存後，下次會優先讀取local data(為了展示背景下載的function，不然應該採用alamofire預設的cache或者自動存到realm是較好的方案)

5. 原本參考reddit貼文cell，想拿thumbnail當作貼文圖片來做auto size cell，但縮圖畫質太差，故後來改為reddit上另一種搜尋的cell

reddit 貼文示意
<img src="https://github.com/mvpscottjon/user_code_base_ui/blob/master/source/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202021-10-11%20at%2020.29.54.png" width="414" height="665">
