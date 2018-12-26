<template>
  <div class="map">
    <div class="Amap" id="container"></div>
    <div class="panel"></div>
    <div class="button-list" id="radius">
      <dl>
        <dt>
          <button class="list-link" @click="radiusSearch(250)">250m</button>
        </dt>
			<hr>
        <dt>
          <button class="list-link" @click="radiusSearch(500)">500m</button>
        </dt>
			<hr>
        <dt>
          <button class="list-link" @click="radiusSearch(1000)">1000m</button>
        </dt>
		</dl>
    </div>
  </div>
</template>

<script>
//import Amap from 'AMap'
import Vue from 'vue/dist/vue.js'
export default {
  name: "amap",
  data(){
    return{
      map: null,
      cityLon: 0,
      cityLat: 0,
    }
  },
  mounted(){
    this.getLocation();
  },
  methods: {
    getLocation(){
      let that = this
      console.log('地图加载成功')
      that.map = new AMap.Map('container',{
        resizeEnable: true
      })
      AMap.plugin('AMap.Geolocation', function () {
          var geolocation = new AMap.Geolocation({
              timeout: 10000,          //超过10秒后停止定位，默认：无穷大
              buttonPosition: 'RB',    //定位按钮停靠位置，默认：'LB'，左下角
              zoomToAccuracy: true      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
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
            pageSize: 20, // 单页显示结果条数
            pageIndex: 1, // 页
            //panel: "panel",
            map: that.map, // 展现结果的地图实例
            autoFitView: true // 是否自动调整地图视野使绘制的 Marker点都处于视口的可见范围
        });
        
        var cpoint = [that.cityLon,that.cityLat]; //中心点坐标
        placeSearch.searchNearBy('', cpoint, radius, function(status, result) {
          if(status === 'complete' && result.info === 'OK'){
            //var mapScreenMarkers = that.map.getAllOverlays('Marker');
            AMap.event.addListener(placeSearch, "markerClick", function(e){
              //that.markeraddress = e.data.address;
              //console.log(e.data.cityname);
              //that.markerlng = e.data.location.lng;
              //that.markerlat = e.data.location.lat;
              //that.markername = e.data.name;
              //that.markertel = e.data.tel;
              var Content = "<div class='info-window'>" + 
              "<label style='color:grey'>商家信息</label>" + 
              "<p >" + e.data.name + "</p>" + 
              "<p >" + e.data.address + "</p>" +
              "<p >" + e.data.tel + "</p>" + 
              "<button @click='getRoute'>test</button>" + 
              "</div>";
              var Mycontent = Vue.extend({
                template: Content,
                methods: {
                  getRoute: function(){
                    that.$router.push({
                      name: 'restaurant',
                      params: {
                        name: e.data.name, 
                        address: e.data.name, 
                        tel: e.data.name, 
                        lng: e.data.location.lng,
                        lat: e.data.location.lat
                      }
                    })
                  }
                }
              });
              var infocontent = new Mycontent().$mount();
              var infoWindow = new AMap.InfoWindow({
                offset: new AMap.Pixel(0,-30),
                content: infocontent.$el,
                position: [that.markerlng, that.markerlat]
              });
              infoWindow.open(that.map);
              
            })
          }else {
            window.alert('There is no restaurant near! So get twice as far');
            that.radiusSearch(radius * 2);
          }
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
.pannel {
  position: fixed;
  background-color: white;
  max-height: 90%;
  overflow-y: auto;
  top: 100px;
  right: 10px;
  width: 280px;
}
</style>
