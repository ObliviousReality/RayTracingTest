Wall w;
Ray r;
Emitter e;

void setup() {
    size(800,800);
    w = new Wall(100,100, 700, 700);
    // r = new Ray(200,200, radians(90));
    e = new Emitter(400,400);
}

void draw()
{
    background(0);
    w.draw();
    e.draw();
}
