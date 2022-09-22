int NumWalls = 10;

Wall[] walls = new Wall[NumWalls];
Ray r;
Emitter e;

boolean drawWalls = false;
int delay;

void setup() {
    size(800,800);
    for (int i = 0; i < NumWalls; i++) {
        walls[i] = new Wall((int)random(0, width),(int)random(0, height),(int)random(0, width),(int)random(0, width));
    }

    // r = new Ray(200,200, radians(90));
    e = new Emitter(100,700);
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
    }
    if (drawWalls) {
        for (int i = 0; i < NumWalls; i++) {
            walls[i].draw();
        }
    }
    e.move(mouseX, mouseY);
    e.draw();
    e.test(walls);
    if(delay > 0){
        delay--;
    }
}
