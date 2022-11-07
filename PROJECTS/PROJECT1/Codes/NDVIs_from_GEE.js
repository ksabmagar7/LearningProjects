// Script for GEE

var L8 = ee.ImageCollection("LANDSAT/LC08/C02/T1_TOA"),
    L9 = ee.ImageCollection("LANDSAT/LC09/C02/T1_TOA"),
    S2 = ee.ImageCollection("COPERNICUS/S2"),
    L7 = ee.ImageCollection("LANDSAT/LE07/C02/T1_TOA"),
    npl = ee.FeatureCollection("projects/ktmagar/assets/district_boundary_npl/district_boundary_npl");
    
var regions = npl
.filter(ee.Filter.inList('DIST_NAME', ['Gorkha', 'Kaski','Lamjung','Tanahu']));
Map.addLayer(regions)

// Landsat
var maskCloud = function(image) {
  var qa = image.select('QA_PIXEL');
  /// Check that the cloud bit is off.
  var mask = qa.bitwiseAnd(1 << 4).eq(0)
              .and(qa.bitwiseAnd(1<<3).eq(0));
  return image.updateMask(mask);
}

// Sentinel 2
// Function to mask clouds using the Sentinel-2 QA band.
function maskS2clouds(image) {
  var qa = image.select('QA60')
// Both flags should be set to zero, indicating clear conditions.
  var mask = qa.bitwiseAnd(1<<10).eq(0).and(
             qa.bitwiseAnd(1<<11).eq(0))

  // Return the masked and scaled data, without the QA bands.
  return image.updateMask(mask).divide(10000)
      .select("B.*")
      .copyProperties(image, ["system:time_start"])
}

//
var L8img = L8
            .filterDate('2016-10-01', '2016-11-30')
            .map(maskCloud)
            .map(function(img){return img.normalizedDifference(['B5', 'B4']).rename('NDVI')
            })
               .median()
                .clip(table);
               
var L7img = L7
            .filterDate('2016-10-01', '2016-11-30')
            .map(maskCloud)
            .map(function(img){return img.normalizedDifference(['B5', 'B4']).rename('NDVI')})
              .median()
               .clip(table);  

var L9img21 = L9
            .filterDate('2021-10-01', '2021-11-30')
            .map(maskCloud)
            .map(function(img){return img.normalizedDifference(['B5', 'B4']).rename('NDVI')})
            .median()
             .clip(table)
            
var L8img21 = L8
            .filterDate('2021-10-01', '2021-11-30')
            .map(maskCloud)
            .map(function(img){return img.normalizedDifference(['B5', 'B4']).rename('NDVI')})
               .median()
                .clip(table);
               
var S2img = ee.ImageCollection('COPERNICUS/S2')
  .filterDate('2016-10-01', '2016-11-30')
    // Pre-filter to get less cloudy granules.
    .map(maskS2clouds)
            .map(function(img){return img.normalizedDifference(['B5', 'B4']).rename('NDVI')})
               .median()
                .clip(table); 

var S2img21 = ee.ImageCollection('COPERNICUS/S2')
  .filterDate('2021-10-01', '2021-11-30')
    .map(maskS2clouds)
            .map(function(img){return img.normalizedDifference(['B5', 'B4']).rename('NDVI')})
               .median()
               .clip(table);
               
var randompoints = ee.FeatureCollection.randomPoints(table, 10000, 1);
var L8img_ = L8img.sampleRegions({collection: randompoints,scale: 100, geometries: false});
var L9img21_ = L9img21.sampleRegions({collection: randompoints,scale: 100, geometries: false});
var L7img_ = L7img.sampleRegions({collection: randompoints,scale: 100, geometries: false});
var S2img_ = S2img.sampleRegions({collection: randompoints,scale: 100, geometries: false});
var L8img21_ = L8img21.sampleRegions({collection: randompoints,scale: 100, geometries: false});
var S2img21_ = S2img21.sampleRegions({collection: randompoints,scale: 100, geometries: false});

Export.table.toDrive({collection: L8img_, description:'L8img_', folder:'ee', fileFormat:'CSV'})
Export.table.toDrive({collection: L7img_, description:'L7img_', folder:'ee', fileFormat:'CSV'})
Export.table.toDrive({collection: S2img_, description:'S2img_', folder:'ee', fileFormat:'CSV'})
Export.table.toDrive({collection: L9img21_, description:'L9img21_', folder:'ee', fileFormat:'CSV'})
Export.table.toDrive({collection: L8img21_, description:'L8img21_', folder:'ee', fileFormat:'CSV'})
Export.table.toDrive({collection: S2img21_, description:'S2img21_', folder:'ee', fileFormat:'CSV'})