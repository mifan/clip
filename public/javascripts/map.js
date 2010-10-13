//datas
/*
40.0754320668, 116.3340461254
40.0752842924, 116.3317447900
40.0749394843, 116.3295936584
40.0741267154, 116.3292717933
40.0733016218, 116.3279199600
40.0798364171, 116.3386380672
40.0780303806, 116.3389652967
40.0760642091, 116.3393247127
40.0750215816, 116.3406980037
40.0760026371, 116.3425648212
40.0771560775, 116.3425272703
40.0726858739, 116.3273191452
40.0740364071, 116.3262623548
40.0736669630, 116.3256669044
40.0732277324, 116.3256025314
40.0734822402, 116.3265520334
40.0735068699, 116.3269329071
40.0735068699, 116.3269329071
40.0724395731, 116.3272976875
40.0727761839, 116.3271957635
40.0721809564, 116.3275927305
40.0733303566, 116.3272440433
40.0719674942, 116.3273030519
40.0737531668, 116.3269704580

*/
var pathPoints=new Array(10)
pathPoints[0]=new google.maps.LatLng(40.0754320668, 116.3340461254);
pathPoints[1]=new google.maps.LatLng(40.0752842924, 116.3317447900);
pathPoints[2]=new google.maps.LatLng(40.0749394843, 116.3295936584);
pathPoints[3]=new google.maps.LatLng(40.0741267154, 116.3292717933);
pathPoints[4]=new google.maps.LatLng(40.0798364171, 116.3386380672);
pathPoints[5]=new google.maps.LatLng(40.0780303806, 116.3389652967);
pathPoints[6]=new google.maps.LatLng(40.0760642091, 116.3393247127);
pathPoints[7]=new google.maps.LatLng(40.0750215816, 116.3406980037);
pathPoints[8]=new google.maps.LatLng(40.0760026371, 116.3425648212);
pathPoints[9]=new google.maps.LatLng(40.0771560775, 116.3425272703);



// Load the Visualization API and the columnchart package.
google.load("visualization", "1", {packages: ["columnchart"]});

//defind variables for map
var elevator;
var map;
var chart;
var infowindow = new google.maps.InfoWindow();
var polyline;
var centerPoint;

if(pathPoints.length>0)
{
  var index = parseInt(pathPoints.length/2);
  centerPoint = pathPoints[index];
}
else
{
  centerPoint = new google.maps.LatLng(39.90402,116.38681); 
}

//functions
function drawPath() {
  // Create a new chart in the elevation_chart DIV.
  chart = new google.visualization.ColumnChart(document.getElementById('elevation_chart'));
  //var path = [ whitney, lonepine, owenslake, panamintsprings, beattyjunction, badwater];
  var path = pathPoints;
  // Create a PathElevationRequest object using this array.
  // Ask for 256 samples along that path.
  var pathRequest = {
    'path': path,
    'samples': 256
  }

  // Initiate the path request.
  elevator.getElevationAlongPath(pathRequest, plotElevation);
}//end drawPath()

// Takes an array of ElevationResult objects, draws the path on the map
// and plots the elevation profile on a Visualization API ColumnChart.
function plotElevation(results, status) {

  if (status == google.maps.ElevationStatus.OK) {
    elevations = results;

    // Extract the elevation samples from the returned results
    // and store them in an array of LatLngs.
    var elevationPath = [];
    for (var i = 0; i < results.length; i++) {
      elevationPath.push(elevations[i].location);
    }

    // Display a polyline of the elevation path.
    var pathOptions = {
      path: elevationPath,
      strokeColor: '#0000CC',
      opacity: 0.4,
      map: map
    }
    polyline = new google.maps.Polyline(pathOptions);
/*
    // Extract the data from which to populate the chart.
    // Because the samples are equidistant, the 'Sample'
    // column here does double duty as distance along the
    // X axis.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Sample');
    data.addColumn('number', 'Elevation');
    for (var i = 0; i < results.length; i++) {
      data.addRow(['', elevations[i].elevation]);
    }

    // Draw the chart using the data within its DIV. 
    document.getElementById('elevation_chart').style.display = 'block';
    chart.draw(data, {
      width: 640,
      height: 200,
      legend: 'none',
      titleY: 'Elevation (m)'
    });
*/
  }
}// end plotElevation

function lngToPixel(lng, zoom) {
  return (lng+180.00)*(256<<zoom)/360;
}

function pixelToLng(pixelX,zoom) {
  return pixelX*360.00/(256<<zoom)-180;
}

function latToPixel(lat,zoom) {
  var siny = Math.sin(lat * Math.PI / 180);
  var y = Math.log((1 + siny) / (1 - siny));
  return (128<<zoom)*(1-y/(2*Math.PI));
}

function pixelToLat(pixelY, zoom) {
  var y = 2 * Math.PI * (1 - pixelY / (128 << zoom));
  var z = Math.pow(Math.E, y);
  var siny = (z - 1) / (z + 1);
  return Math.asin(siny)*180/Math.PI;
}


// init origin
function initialize() {
  var myOptions = {
    zoom: 15,
    center: centerPoint,
      mapTypeId:google.maps.MapTypeId.ROADMAP 
  }
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  if(pathPoints.length==0){
      return;
  }

  // Create an ElevationService.
  elevator = new google.maps.ElevationService();

  // Draw the path, using the Visualization API and the Elevation service.
  drawPath();
}

$(function(){
  var myOptions = {
    zoom: 15,
    center: centerPoint,
      mapTypeId:google.maps.MapTypeId.ROADMAP 
  }
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  if(pathPoints.length==0)
      return;
  
  // Create an ElevationService.
  elevator = new google.maps.ElevationService();

  // Draw the path, using the Visualization API and the Elevation service.
  drawPath();
}); //on load event