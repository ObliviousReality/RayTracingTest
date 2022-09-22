class Ray{

    PVector pos = new PVector();
    PVector dir = new PVector();

    Ray(int x, int y, float angle) {
        pos.x = x;
        pos.y = y;
        dir = PVector.fromAngle(angle);
    }

    void draw() {

        stroke(255,0,0);
        push();
        translate(pos.x, pos.y);
        line(0,0,dir.x * 10, dir.y * 10);
        pop();
    }
}
