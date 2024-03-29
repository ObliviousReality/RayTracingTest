int NumWalls = 20;

Wall[] walls = new Wall[NumWalls + 4];
Ray r;
Emitter e;

boolean drawWalls = false;
int delay = 0;

void setup() {
    size(1200,1200);
    for (int i = 0; i < walls.length; i++) {
        walls[i] = new Wall((int)random(0, width),(int)random(0, height),(int)random(0, width),(int)random(0, width));
    }
    // walls[0] = new Wall(100,100, 400,400);
    // walls[1] = new Wall(100,400, 400,700);
    // walls[2] = new Wall(400,700, 700,400);
    walls[NumWalls] = new Wall(0, 0, width-1, 0);
    walls[NumWalls + 1] = new Wall(0,0, 0, height-1);
    walls[NumWalls + 2] = new Wall(0, height-1, width-1, height-1);
    walls[NumWalls + 3] = new Wall(width-1, 0, width-1, height-1);
    e = new Emitter(100,700, 2);
}

void draw()
{
    background(0);
    if (keyPressed) {
        if (key == 'b' && delay == 0) {
            drawWalls = !drawWalls;
            delay = 30;
        }
        if (key == 'p') {
            exit();
        }
        if (key == 'v' && delay == 0) {
            e.drawLines();
            delay = 30;
        }
        if (key == 'c' && delay == 0){
            e.colour();
            delay = 30;
        }
    }
    if (drawWalls) {
        for (int i = 0; i < walls.length; i++) {
            walls[i].draw();
        }
    }

    e.move(mouseX, mouseY);
    stroke(255);
    strokeWeight(5);
    point(mouseX, mouseY);
    e.test(walls);
    e.draw();
    if (delay > 0) {
        delay--;
    }
}
