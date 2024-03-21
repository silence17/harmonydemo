export interface DemoController{
  update:()=>void
}

@Component
export default struct BuiDemo {
  controller:DemoController|null = null ;
  build() {
    Column() {  }
  }
  nextPage(){}

  aboutToAppear(){
    if(this.controller) {
      this.controller.update = () => {
        this.nextPage();
      }
    }
  }
}