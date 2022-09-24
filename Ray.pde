class Ray{

    PVector pos = new PVector();
    PVector dir = new PVector();
    float angle;
    int depth;

    Ray(float x, float y, float angle, int depth) {
        this.depth = depth;
        while(angle > TWO_PI) {
            angle -= TWO_PI;
        }
        this.angle = angle;
        pos.x = x;
        pos.y = y;
        dir = PVector.fromAngle(angle);
    }

    void draw() {
        if (depth == 0) {
            stroke(255);
            strokeWeight(1);
            translate(pos.x, pos.y);
            line(0,0,dir.x * 10, dir.y * 10);
            translate( -pos.x, -pos.y);
        }
    }

    void move(int x, int y)
    {
        pos.x = x;
        pos.y = y;
    }

    PVector test(Wall wall) {
        float x3 = pos.x;
        float y3 = pos.y;
        float x4 = pos.x + dir.x;
        float y4 = pos.y + dir.y;
        float x1 = wall.a.x;
        float y1 = wall.a.y;
        float x2 = wall.b.x;
        float y2 = wall.b.y;
        float denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
        if (denominator == 0) {
            return null;
        }
        float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator;
        float u = ((x1 - x3) * (y1 - y2) - (y1 - y3) * (x1 - x2)) / denominator;
        if (t > 0 && t < 1 && u > 0) {
            PVector point = new PVector();
            point.x = x1 + t * (x2 - x1);
            point.y = y1 + t * (y2 - y1);
            return point;
        }
        return null;
    }
}
