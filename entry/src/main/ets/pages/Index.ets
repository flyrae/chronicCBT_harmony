import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  toLogIn(){
    router.pushUrl({
      url: 'pages/Login',

    })
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button('跳转s上').onClick(()=>{
          this.toLogIn()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}