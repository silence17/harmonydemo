import { rankData1, rankData2 } from '@bundle:com.example.rankdemo/entry/ets/model/DataModel';
export class RankViewModel {
    // Load data from the rankData1 of the Mock file.
    loadRankDataSource1() {
        return rankData1;
    }
    // Load data from the rankData2 of the Mock file,but rankData2 is different from rankData1.
    loadRankDataSource2() {
        return rankData2;
    }
    getTest() {
    }
}
//# sourceMappingURL=RankViewModel.js.map