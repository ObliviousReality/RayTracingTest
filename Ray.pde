class Ray{

    PVector pos = new PVector();
    PVector dir = new PVector();
    float angle;
    Ray nextBounce;
    int depth;
    int maxBrightness;

    Ray(float x, float y, float angle, int maxBrightness, int depth) {
        this.angle = angle;
        this.depth = depth;
        this.maxBrightness = maxBrightness;
        pos.x = x;
        pos.y = y;
        dir = PVector.fromAngle(angle);
        // println(dir);
    }

    void draw() {

        // stroke(255);
        // // push();
        // strokeWeight(1);
        // translate(pos.x, pos.y);
        // line(0,0,dir.x * 10, dir.y * 10);
        // translate( -pos.x, -pos.y);
        // if(this.nextBounce != null)
        // {
        //     nextBounce.draw();
    // }
        // pop();
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
            // float theta = acos(((x2 - x1) * (x4 - x3) + (y2 - y1) * (y4 - y3)) / (sqrt(pow(x2 - x1,2) + pow(y2 - y1, 2)) * sqrt((pow(x4 - x3,2) + pow(y4 - y3, 2)))));

            // if (this.depth < 3) {
            //     float lineAngle = atan2(y2 - y1, x2 - x1);
            //     float newAngle = 2 * lineAngle - this.angle;
            //     // println(degrees(newAngle));
            //     nextBounce = new Ray((int)point.x,(int)point.y, newAngle, 255, this.depth + 1);
        // }
            // print(depth);
            // print(" : ");
            // println(point);
            return point;
        }
        return null;
    }
}


// println(degrees(theta));
// float newAngle;
// if (theta > HALF_PI) {
//     newAngle = theta - HALF_PI;
// }
// else{
//     newAngle = PI - theta;
// }
// newAngle = this.angle - PI - newAngle;
