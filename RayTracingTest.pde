int NumWalls = 0;

Wall[] walls = new Wall[NumWalls + 4];
Ray r;
Emitter e;

boolean drawWalls = false;
int delay = 0;

void setup() {
    size(800,800);
    for (int i = 0; i < NumWalls; i++) {
        walls[i] = new Wall((int)random(0, width),(int)random(0, height),(int)random(0, width),(int)random(0, width));
    }
    walls[NumWalls] = new Wall(0, 0, width, 0);
    walls[NumWalls + 1] = new Wall(0,0, 0, height);
    walls[NumWalls + 2] = new Wall(0, height, width, height);
    walls[NumWalls + 3] = new Wall(width, 0, width, height);
    // r = new Ray(200,200, radians(90));
    e = new Emitter(100,700, 1);
}

void draw()
{
    background(0);
    if (keyPressed) {
        if (key == 'b' && delay == 0) {
            drawWalls = !drawWalls;
            delay = 60;
        }
        if (key == 'p') {
            exit();
        }
        if (key == 'v' && delay == 0) {
            e.drawLines();
            delay = 60;
        }
    }
    if (drawWalls) {
        for (int i = 0; i < NumWalls + 4; i++) {
            walls[i].draw();
        }
    }
    e.move(mouseX, mouseY);
    circle(mouseX, mouseY, 5);
    e.draw();
    e.test(walls);
    if (delay > 0) {
        delay--;
    }
}
