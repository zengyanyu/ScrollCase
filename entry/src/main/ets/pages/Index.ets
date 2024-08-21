@Entry
@Component
struct Index {
  @State
  list: number[] = Array.from(Array(10), (_: number, index: number) => index + 1)
  scroller: Scroller = new Scroller()
  @State
  currentOpacity: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Scroll(this.scroller) {
        Column() {
          Row() {
            Text("顶部滚动内容")
              .fontSize(20)
              .fontWeight(700)
              .fontColor(Color.White)
          }
          .height(200)
          .width("100%")
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.Green)

          // 循环内容
          List({ space: 20 }) {
            ForEach(this.list, (item: number) => {
              ListItem() {
                Text(`第${item}项`)
                  .fontColor(Color.White)
                  .fontSize(20)
              }
              .height(100)
              .borderRadius(8)
              .backgroundColor(Color.Grey)
              .width("100%")
            })
          }
          .onReachEnd(() => {
          })
          .padding(10)
        }
      }
      .onScrollFrameBegin((offset: number) => {
        const y = this.scroller.currentOffset().yOffset
        if (y > 100) {
          this.currentOpacity = (this.scroller.currentOffset().yOffset / 200)
        } else {
          this.currentOpacity = 0
        }
        return { offsetRemain: offset };
      })
      .onScrollEdge((edge) => {
        if (edge === Edge.Bottom) {
          this.list.push(...Array.from(Array(10), (_: number, index: number) => (this.list.length + index) + 1))
        }
      })

      Row() {
        Text("悬浮内容")
          .fontSize(20)
          .fontWeight(700)
          .fontColor(Color.White)
      }
      .height(100)
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Red)
      .opacity(this.currentOpacity)
    }

  }
}