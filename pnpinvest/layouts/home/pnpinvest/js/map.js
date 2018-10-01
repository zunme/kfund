// JavaScript Document

 function initialize() {
  var myLatlng = new google.maps.LatLng(37.469436, 126.884314);
  var myOptions = {
   zoom: 15,
   center: myLatlng

  }
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
 
  var marker = new google.maps.Marker({
   position: myLatlng, 
   map: map, 
   title:"(주)인투윈 소프트"
  });   
  
 
  var infowindow = new google.maps.InfoWindow({
   content: "(주)인투윈 소프트 서울 금천구 가산동 327-32번지 대륭테크노타운 12차 703호"
  });
 
  infowindow.open(map,marker);
 }
 
 
 window.onload=function(){
  initialize();
 }

