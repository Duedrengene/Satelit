// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi

float angle;

Table table;
float r = 200;

PImage earth;
PShape globe;
JSONObject json;
JSONObject json2;


void setup() {
    json = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/10529/41.702/-76.014/0/2/&&apiKey=UY7JUM-PX4X5D-CXLF35-4KH0");
   // json2 = load
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  
  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  println(json);
}

void draw() {

  JSONArray posi =  json.getJSONArray("positions"); 
 JSONObject position = posi.getJSONObject(0);
 float lat = position.getFloat("satlatitude");
 float lon  = position.getFloat("satlatitude");
 float alt = position.getFloat("sataltitude");
 
 /*
   JSONArray posi =  json.getJSONArray("positions"); 
 JSONObject position = posi.getJSONObject(0);
 float lat = position.getFloat("satlatitude");
 float lon  = position.getFloat("satlatitude");
 float alt = position.getFloat("sataltitude");
 */
 println(position);
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.05;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
  

 //   float lat = row.getFloat("latitude");
 //   float lon = row.getFloat("longitude");
 //   float mag = row.getFloat("mag");

    // original version
    // float theta = radians(lat) + PI/2;

    // fix: no + PI/2 needed, since latitude is between -180 and 180 deg
    float theta = radians(lat);

    float phi = radians(lon) + PI;

    // original version
     //float x = r * sin(theta) * cos(phi);
     //float y = -r * sin(theta) * sin(phi);
     //float z = r * cos(theta);

    // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
    float x = r * cos(theta) * cos(phi);
    float y = -r * sin(theta);
    float z = -r * cos(theta) * sin(phi);

    PVector pos = new PVector(x, y, z);

    float h = pow(10, alt);
    float maxh = pow(10, 7);
    h = map(h, 0, maxh, 10, 100);
    PVector xaxis = new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xaxis, pos);
    PVector raxis = xaxis.cross(pos);



    pushMatrix();
    translate(x, y, z*2);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    fill(255);
    box(5, 5, 5);
    popMatrix();
    
  }
  
