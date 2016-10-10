float rotation   = 0; // This is just to keep track of the current rotation

int noOfLines    = 52;  // Change me! The total number of lines drawn
                        // I'd suggest sticking to multiples of 4.
float squareSize = 750; // Change me! The size of the square
float circleSize = 400; // Change me! The size of the circle

// These variables are just for readability later on
float halfSquare = squareSize / 2;
float circleRadius = circleSize / 2;

// This array will hold the points that comprise the square shape
ArrayList<PVector> pointsAlongSquare = new ArrayList<PVector>();

// These variables will help us draw the square out point-by-point
float squareX;
float squareY;

// Find the number of points per side
float pointsPerSide = noOfLines / 4;

void setup() {
  size(1000,1000);
  pixelDensity(displayDensity());

  // Initialize the points that will make up the square
  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < pointsPerSide; j++) {
      if(i == 0) {
        squareX = map(j, 0, pointsPerSide, -halfSquare, halfSquare);
        squareY = -halfSquare;
      } else if(i == 1) {
        squareY = map(j, 0, pointsPerSide, -halfSquare, halfSquare);
        squareX = halfSquare;
      } else if(i == 2) {
        squareX = map(j, 0, pointsPerSide, halfSquare, -halfSquare);
        squareY = halfSquare;
      } else if(i == 3) {
        squareY = map(j, 0, pointsPerSide, halfSquare, -halfSquare);
        squareX = -halfSquare;
      }

      pointsAlongSquare.add(new PVector(squareX, squareY));
    }
  }
}

void draw() {
  background(#000204);
  stroke(#F59B3C);
  strokeWeight(3);

  // Translate to the center of the canvas to make math easier
  translate(width/2, height/2);

  // Draw a series of points along the circle and then draw a line to each
  // point on the square
  for(float i = 0; i < noOfLines; i++) {
    float angle = radians((i / noOfLines) * 360);
    PVector point = new PVector(sin(angle) * (width/2), cos(angle) * (height/2));

    PVector origin = pointsAlongSquare.get(round(i)).copy();
    origin.mult(-1);
    point.limit(circleRadius);
    point.rotate(rotation);
    line(origin.x, origin.y, point.x, point.y);
  }

  rotation += 0.01;

  // Uncomment these lines to export a full loop (skipping every 2nd frame)
  // WARNING: this will export up to 3GB of images!

  //if(rotation < PI*2) {
  //  if(frameCount % 2 == 0) saveFrame("frame-####.tif");
  //} else {
  //  noLoop();
  //}
}

// For fun, save the frame out each time the mouse is pressed.
void mousePressed() {
  saveFrame();
}
