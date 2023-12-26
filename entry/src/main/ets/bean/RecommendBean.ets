export class RecommendBean {
  productid: string
  productname: string // 青心乌龙-企业会员SVIP2等级-12盒正大青心乌龙茶",
  shopid: string
  shopname: string //"官方自营店",
  searchImgUrl: string
  salePrice?: SalePrice
  saleCountDesc: string //销量
  selectSkuDTO: selectSkuDTO
  //添加数量
  quantity: number = 1
}

export interface SalePrice {
  typeName: string
  price: number
  priceDesc: string
}

export interface selectSkuDTO {
  skuId: string
  imgUrl: string
  skuStatusDesc: string
}