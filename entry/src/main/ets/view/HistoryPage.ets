import wordModel from '../model/HistoryModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryViewModel } from './HistoryViewModel'
import {getItem}  from '../common/history_com'
//生成每一条历史记录的卡片
@Builder function HistoryCard(item:HistoryViewModel){
  Row({space:10}){
    Column(){
      Row(){
        Text(item.title)
          .fontSize(20)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }.margin(5)
      Row(){
        Image(item.img_url)
          .width(100)
        Column(){
          Text(item.news_brief.substring(0,60))
            .fontSize(10)
            .fontColor('#888')
            .decoration({type:TextDecorationType.LineThrough})
            .textAlign(TextAlign.Start)
          Text(item.history_time)
            .fontSize(10)
            .fontColor('#888')
        }.justifyContent(FlexAlign.Start)
        .width('70%')
        .height("100%")
      }.height('45%')

    }
    .alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .height('20%')
  .padding({left:14,right:14})
  .backgroundColor('#fff')
  .borderRadius(8)
}
@Component
export struct History {
  //初始化items
@State items:HistoryViewModel[] = []
  //使用异步方法获取items
  async aboutToAppear(){
    this.items = await getItem()
    console.log('成功触发')
  }

  build() {
      Column() {
        //使用List展示卡片
        List({space:10}){
            ForEach(this.items,(item:HistoryViewModel)=>{
              ListItem(){
                  HistoryCard(item)
              }
            })
        }
        .padding({left:10,right:10})
        .layoutWeight(1)
      }
      .width('100%')
    .height('100%')
    .backgroundColor('#eee')
  }
}