<template>
  <div class="Amap" id="container">
    <div class="button-list" id="radius">
      <dl>
        <dt>
          <button class="list-link" @click="radiusSearch(500)">200m</button>
        </dt>
			<hr>
        <dt>
          <a>500m</a>
        </dt>
			<hr>
        <dt>
          <a>1000m</a>
        </dt>
		</dl>
    </div>
  </div>
</template>

<script>
//import Amap from 'AMap'
export default {
  name: "amap",
  data(){
    return{
      map: null,
      cityLon: 0,
      cityLat: 0
    }
  },
  mounted(){
    let that = this
    console.log('地图加载成功')
    that.map = new AMap.Map('container',{
      resizeEnable: true
    })
    AMap.plugin('AMap.Geolocation', function () {
        var geolocation = new AMap.Geolocation({
            timeout: 10000,          //超过10秒后停止定位，默认：无穷大
            buttonPosition: 'RB',    //定位按钮停靠位置，默认：'LB'，左下角
            zoomToAccuracy:false      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
        });
        that.map.addControl(geolocation);
        geolocation.getCurrentPosition(function(status,result){
          if(status=='complete'){
            that.onComplete(result)
          }else{
            that.onError(result)
          }
        });
  }), e => {
    console.log('地图加载失败',e)
  }
  },
  methods: {
    onComplete(data){
				var x="",y="";
				var Position = data.position;
        var PositionStr = String(Position);
        var j = 0;
				var i = PositionStr.search(",");
        for ( j = 0 ; j < i ; j++) {
          x += PositionStr[j];
        }
        for ( j = i + 1 ; j < PositionStr.length ; j++){
          y += PositionStr[j];
        }
        this.cityLon = Number(x);
        this.cityLat = Number(y);
    },
    onError(data) {
      console.log(data.message);
    },
    radiusSearch(radius){
      let that = this;
      that.map = new AMap.Map('container',{
        resizeEnable: true
      })
      AMap.service(["AMap.PlaceSearch"], function() {
        //构造地点查询类
        var placeSearch = new AMap.PlaceSearch({ 
            type: '餐饮服务', // 兴趣点类别
            pageSize: 10, // 单页显示结果条数
            pageIndex: 1, // 页
            map: that.map, // 展现结果的地图实例
            autoFitView: true // 是否自动调整地图视野使绘制的 Marker点都处于视口的可见范围
        });
        
        var cpoint = [that.cityLon,that.cityLat]; //中心点坐标
        placeSearch.searchNearBy('', cpoint, radius, function(status, result) {

        });
      });
    },

  }
};
</script>
<style>
.Amap {
  height: 500px;
  z-index: 1;
}
.button-list {
  position: fixed;
  background-color: white;
  max-height: 90%;
  overflow-y: auto;
  top: 500px;
  left: 10px;
  width: 120px;
  border-bottom: solid 1px silver;
  text-align: center;
  border-radius: 15px;
  z-index: 9999;
}
.lise-button {
  border: none;
}
</style>
