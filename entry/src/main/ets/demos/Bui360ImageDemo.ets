
import Bui360Image from '../view/Bui360Image';
@Component
export default struct Bui360ImageDemo {

  images:string[]=[] ;

  aboutToAppear(){
    let imgArr:string[] = [];
    for(let i=1;i<=36;i++){
      let num = i<10?"0"+i:i;
      imgArr.push("https://static.buick.com.cn/assets/D6kMJ73g2EXhbkpAW9-Ql/envisionsgs/360/lightblue/"+ num +".png")
    }
    this.images = imgArr
  }


  build(){
    Column(){
      if(this.images.length>0) {
        Bui360Image({
          images: this.images
        }).borderWidth(1).borderColor("#ccc");
      }

      Text(`
         Bui360Image({
          images: this.images
        }).borderWidth(1).borderColor("#ccc");
      `)

    }
  }



 }