class Emitter{

    PVector pos = new PVector();
    Ray[] rays = new Ray[720];

    Emitter(int x, int y) {
        pos.x = x;
        pos.y = y;
        createRays();
    }

    void createRays() {
        for (int i = 0; i < rays.length; i++) {
            rays[i] = new Ray((int)pos.x,(int)pos.y, radians(map(i,0,720,0,360)));
        }
    }

    void move(int x, int y)
    {
        pos.x = x;
        pos.y = y;
        for (int i = 0; i < rays.length; i++) {
            rays[i].move(x, y);
        }
    }

    void draw()
    {
        for (int i = 0; i < rays.length; i++) {
            rays[i].draw();
        }
    }

    void test(Wall[] walls)
    {

        for (int i = 0; i < rays.length; i++) {
            float closestDist = Integer.MAX_VALUE;
            PVector closestHit = null;
            for (int j = 0; j < walls.length; j++) {
                PVector hit = rays[i].test(walls[j]);
                if (hit!= null) {
                    float dist = pos.dist(hit);
                    if (dist < closestDist)
                    {
                        closestHit = hit;
                        closestDist = dist;
                    }

                }
            }

            if (closestHit != null)
            {
                // stroke(0,0,255);
                stroke(255,0,255);
                strokeWeight(1);
                point(closestHit.x, closestHit.y);
                // line(pos.x, pos.y, closestHit.x, closestHit.y);
            }
        }

    }
}
