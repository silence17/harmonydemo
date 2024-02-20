import List from '@ohos.util.List'
import { BasicDataSource } from '../util/BasicDataSource'

export class ShopCartList extends BasicDataSource<ShopBean> {
  isSelectAll: boolean
  saleGroups: List<ShopBean>
  invalidGroups: List<ShopBean>
  balanceArea: BalanceAreaBean

  totalCount() {
    return this.saleGroups.length + this.invalidGroups.length
  }

  getData(index: number): ShopBean {
    if (index < this.saleGroups.length) {
      return this.saleGroups[index]
    }
    return this.invalidGroups[index]
  }
}

/**
 * 店铺bean
 */
export interface ShopBean {
  isSelectAll: boolean
  shopId: string
  shopImgUrl: string
  shopName: string
  //true 自营店铺
  isSelf: boolean
  productList: List<ProductBean>
}

/**
 * 商品bean
 */
interface ProductBean {
  isSelect: boolean
  skuId: string
  skuDesc: string
  skuStock: number
  productId: string
  productImgUrl: string
  productName: string
  quantity: number
  skuStatus: number
  skuStatusDesc: string
  addTime: string
}


interface BalanceAreaBean {
  cartSkuCount: number
  selectSkuCount: number
  payAmount: number
  payAmountDesc: number
}
