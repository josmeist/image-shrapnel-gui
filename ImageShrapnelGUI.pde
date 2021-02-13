boolean browseButton = false;
boolean updateButton = false;
boolean transparencyToggle = false;
boolean randomizeButton = false;
boolean sizeSlider = false;
boolean densitySlider = false;
boolean opacitySlider = false;
boolean exportPNGButton = false;
boolean exportTIFButton = false;
boolean exportJPGButton = false;
boolean exportPDFButton = false;
int sizeSliderBoxX = 100;
int densitySliderBoxX = 100;
int opacitySliderBoxX = 100;
String imagePath = "";
PImage image;
PShape transparencyShape;
boolean transparency = true;
boolean imageLoaded = false;
boolean landscape = true;
PGraphics canvas;
boolean imageDrawn = false;
float ratio;
String ext = "";
String outputPath = "";
boolean randomize = false;

void setup() {
  size(1280, 720);
  //surface.setResizable(true);
  background(0);
  transparencyShape = loadShape("checkerboard.svg");
}

void draw() {
  background(0);
  fill(0, 0);
  //draw browse button
  if (mouseX > 12 && mouseX < 92 && mouseY > 12 && mouseY < 37) {
    fill(255, 50);
    browseButton = true;
  } else {
    browseButton = false;
  }
  stroke(200);
  strokeWeight(2);
  rect(12, 12, 80, 25);
  fill(200);
  textSize(14);
  text("Browse...", 22, 30);

  //draw size slider
  fill(200);
  textSize(12);
  text("Size:", 18, 60);
  strokeWeight(3);
  stroke(160);
  line(18, 80, 180, 80);
  noStroke();
  fill(180);
  if (mouseX > 25 && mouseX < 173 && mouseY > 70 && mouseY < 90) {
    fill(200);
    sizeSlider = true;
  } else {
    sizeSlider = false;
  }
  rect(sizeSliderBoxX, 70, 10, 20);

  //draw density slider
  fill(200);
  textSize(12);
  text("Density:", 18, 110);
  strokeWeight(3);
  stroke(160);
  line(18, 130, 180, 130);
  noStroke();
  fill(180);
  if (mouseX > 25 && mouseX < 173 && mouseY > 120 && mouseY < 140) {
    fill(200);
    densitySlider = true;
  } else {
    densitySlider = false;
  }
  rect(densitySliderBoxX, 120, 10, 20);

  //draw opacity slider
  fill(200);
  textSize(12);
  text("Opacity:", 18, 160);
  strokeWeight(3);
  stroke(160);
  line(18, 180, 180, 180);
  noStroke();
  fill(180);
  if (mouseX > 25 && mouseX < 173 && mouseY > 170 && mouseY < 210) {
    fill(200);
    opacitySlider = true;
  } else {
    opacitySlider = false;
  }
  rect(opacitySliderBoxX, 170, 10, 20);

  if (imageLoaded) {
    //draw update button
    fill(0);
    if (mouseX > 102 && mouseX < 172 && mouseY > 12 && mouseY < 37) {
      fill(100);
      updateButton = true;
    } else {
      updateButton = false;
    }
    stroke(200);
    strokeWeight(2);
    rect(102, 12, 70, 25);
    fill(200);
    textSize(14);
    text("Update", 112, 30);

    //draw transparency toggle
    if (transparency) {
      noFill();
    } else {
      fill(0);
    }
    if (mouseX > 182 && mouseX < 207 && mouseY > 12 && mouseY < 37) {
      if (transparency) {
        fill(255, 100);
      } else {
        fill(100);
      }
      transparencyToggle = true;
    } else {
      transparencyToggle = false;
    }
    stroke(200);
    strokeWeight(2);
    shape(transparencyShape, 182, 12, 25, 25);
    rect(182, 12, 25, 25);

    //draw randomize button
    if (mouseX > 217 && mouseX < 267 && mouseY > 12 && mouseY < 37) {
      fill(255, 50);
      randomizeButton = true;
    } else {
      randomizeButton = false;
    }
    stroke(200);
    strokeWeight(2);
    rect(217, 12, 50, 25);
    fill(200);
    textSize(14);
    text("Rand", 225, 30);

    //draw export png button
    fill(0);
    if (mouseX > 12 && mouseX < 108 && mouseY > 210 && mouseY < 235) {
      fill(100);
      exportPNGButton = true;
    } else {
      exportPNGButton = false;
    }
    stroke(200);
    strokeWeight(2);
    rect(12, 210, 96, 25);
    fill(200);
    textSize(14);
    text("Export PNG", 22, 228);

    //draw export tif button
    fill(0);
    if (mouseX > 12 && mouseX < 108 && mouseY > 250 && mouseY < 275) {
      fill(100);
      exportTIFButton = true;
    } else {
      exportTIFButton = false;
    }
    stroke(200);
    strokeWeight(2);
    rect(12, 250, 96, 25);
    fill(200);
    textSize(14);
    text("Export  TIF", 22, 268);

    //draw export jpg button
    fill(0);
    if (mouseX > 12 && mouseX < 108 && mouseY > 290 && mouseY < 315) {
      fill(100);
      exportJPGButton = true;
    } else {
      exportJPGButton = false;
    }
    stroke(200);
    strokeWeight(2);
    rect(12, 290, 96, 25);
    fill(200);
    textSize(14);
    text("Export  JPG", 22, 308);

    //draw export pdf button
    /*fill(0);
     if (mouseX > 12 && mouseX < 108 && mouseY > 330 && mouseY < 355) {
     fill(100);
     exportPDFButton = true;
     } else {
     exportPDFButton = false;
     }
     stroke(200);
     strokeWeight(2);
     rect(12, 330, 96, 25);
     fill(200);
     textSize(14);
     text("Export  PDF", 22, 348);*/

    //draw image and border
    strokeWeight(2);
    stroke(127);
    noFill();
    if (landscape) {
      rect(299, -1, 982, 982*ratio);
      image(canvas, 300, 0, 980, 980*ratio);
    } else {
      rect(width - (720*ratio) - 1, -1, 722*ratio, 722);
      image(canvas, width - (720*ratio), 0, 720*ratio, 720);
    }
  }
}

void imageSelected(File selection) {
  if (selection != null) {
    imagePath = selection.getAbsolutePath();
    //println(imagePath);
    if (imagePath.toLowerCase().endsWith(".png") || imagePath.toLowerCase().endsWith(".tif") || imagePath.toLowerCase().endsWith(".jpg") || imagePath.toLowerCase().endsWith(".jpeg")) {
      image = loadImage(imagePath);
      if (image.width >= image.height) {
        ratio = float(image.height) / float(image.width);
        landscape = true;
      } else {
        ratio = float(image.width) / float(image.height);
        landscape = false;
      }
      imageShrapnel((sizeSliderBoxX - 20) * 1.72, (densitySliderBoxX - 20) * 1.72, (opacitySliderBoxX - 20) * 1.72);
      imageLoaded = true;
    } else {
      println("Incompatible file.");
      imageLoaded = false;
    }
  }
}

void outputSelected(File selection) {
  if (selection != null) {
    outputPath = selection.getAbsolutePath();
    //println(imagePath);
    if (outputPath.endsWith(ext.toLowerCase())) {
    } else {
      outputPath += ext;
    }
    canvas.save(outputPath);
  } else {
    println("Error.");
  }
}

void mouseClicked() {
  if (browseButton) {
    selectInput("Select an image:", "imageSelected");
    randomize = false;
  }
  if (exportPNGButton) {
    ext = ".png";
    selectOutput("Export the image as PNG:", "outputSelected");
  }
  if (exportTIFButton) {
    ext = ".tif";
    selectOutput("Export the image as TIF:", "outputSelected");
  }
  if (exportJPGButton) {
    ext = ".jpg";
    selectOutput("Export the image as JPG:", "outputSelected");
  }
  if (exportPDFButton) {
    ext = ".pdf";
    selectOutput("Export the image as PDF:", "outputSelected");
  }
  if (updateButton) {
    randomize = false;
    imageShrapnel((sizeSliderBoxX - 20) * 1.72, (densitySliderBoxX - 20) * 1.72, (opacitySliderBoxX - 20) * 1.72);
  }
  if (transparencyToggle) {
    transparency = !transparency;
  }
  if (randomizeButton) {
    randomize = true;
    imageShrapnel((sizeSliderBoxX - 20) * 1.72, (densitySliderBoxX - 20) * 1.72, (opacitySliderBoxX - 20) * 1.72);
  }
}

void imageShrapnel(float size, float density, float opacity) {
  int x1, x2, x3, y1, y2, y3;
  canvas = createGraphics(image.width, image.height);
  canvas.beginDraw();
  canvas.noStroke();
  canvas.smooth();
  if (!transparency) {
    canvas.background(0);
  }
  size += 3;
  size *= (float(image.width)/2000);
  int step = int((26 - density/10) * (float(image.width)/2000));
  for (int x = 0; x < image.width; x+=step) {//(26 - int(density/10))) {
    x1 = int(random(-size/2, size) + x);
    y1 = int(random(-size/2, size));
    x2 = int(random(-size, size*2) + x);
    y2 = int(random(-size, size));
    for (int y = 0; y < image.height; y+=step) {//(26 - int(density/10))) {
      //fill(int(random(255)),int(random(255)),int(random(255)));
      x3 = int(random(-size/2, size*2) + x);//*4);
      y3 = int(random(-size/2, size*1.5) + y);//*4);
      x1 = constrain(x1, 0, image.width-1);
      x2 = constrain(x2, 0, image.width-1);
      x3 = constrain(x3, 0, image.width-1);
      y1 = constrain(y1, 0, image.height-1);
      y2 = constrain(y2, 0, image.height-1);
      y3 = constrain(y3, 0, image.height-1);
      color c = image.get((x1+x2+x3)/3, (y1+y2+y3)/3);
      if (randomize) {
        c = image.get(int(random(0, image.width)), int(random(0, image.height)));
      }
      if (alpha(c) != 0) {
        canvas.fill(c, opacity);
        canvas.triangle(x1, y1, x2, y2, x3, y3);
      }
      x1 = x2;
      y1 = y2;
      x2 = x3;
      y2 = y3;
    }
  }
  canvas.endDraw();
  imageDrawn = true;
}

void mouseDragged() {
  if (sizeSlider) {
    sizeSliderBoxX = constrain(mouseX - 5, 20, 168);
  }
  if (densitySlider) {
    densitySliderBoxX = constrain(mouseX - 5, 20, 168);
  }
  if (opacitySlider) {
    opacitySliderBoxX = constrain(mouseX - 5, 20, 168);
  }
}

void mousePressed() {
  if (sizeSlider) {
    sizeSliderBoxX = constrain(mouseX - 5, 20, 168);
  }
  if (densitySlider) {
    densitySliderBoxX = constrain(mouseX - 5, 20, 168);
  }
  if (opacitySlider) {
    opacitySliderBoxX = constrain(mouseX - 5, 20, 168);
  }
}