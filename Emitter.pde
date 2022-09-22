class Emitter{

    PVector pos = new PVector();
    Ray[] rays = new Ray[360];

    Emitter(int x, int y) {
        pos.x = x;
        pos.y = y;
        createRays();
    }

    void createRays() {
        for (int i = 0; i < rays.length; i++) {
            rays[i] = new Ray((int)pos.x,(int)pos.y, radians(i));
        }
    }

    void draw()
    {
        for (int i = 0; i < rays.length; i++) {
            rays[i].draw();
        }
    }
}
