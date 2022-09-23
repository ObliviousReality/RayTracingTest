class Emitter{

    int MAXDEPTH = 3;

    PVector pos = new PVector();
    Ray[][] rays;
    int density;

    boolean drawLines = true;
    Emitter(int x, int y, int density) {
        this.density = density;
        // rays = new Ray[360 * density][MAXDEPTH];
        // rays = new Ray[1][MAXDEPTH];
        rays = new Ray[8][MAXDEPTH];
        pos.x = x;
        pos.y = y;
        createRays();
    }

    void createRays() {
        for (int i = 0; i < rays.length; i++) {
            rays[i][0] = new Ray((int)pos.x,(int)pos.y, radians(map(i,0,rays.length,0,360)),255,0);
        }
    }

    void move(int x, int y)
    {
        pos.x = x;
        pos.y = y;
        for (int i = 0; i < rays.length; i++) {
            rays[i][0].move(x, y);
        }
    }

    void draw()
    {
        for (int i = 0; i < rays.length; i++) {
            for (int depth = 0; depth < 3; depth++) {
                if (rays[i][depth] != null) {
                    rays[i][depth].draw();
                }
            }
        }
    }

    void test(Wall[] walls)
    {

        for (int i = 0; i < rays.length; i++) {
            for (int depth = 0; depth < 3; depth++) {
                if (rays[i][depth] != null) {
                    // println(depth);
                    float closestDist = 20000000;
                    PVector closestHit = null;
                    int wallIndex = -1;
                    for (int j = 0; j < walls.length; j++) {
                        PVector hit = rays[i][depth].test(walls[j]);
                        if (hit!= null) {
                            float dist = pos.dist(hit);
                            if (dist < closestDist)
                            {
                                closestHit = hit;
                                closestDist = dist;
                                wallIndex = j;
                            }

                        }
                    }

                    if (closestHit != null)
                    {
                        // stroke(0,0,255);
                        float intensity = map(closestDist, 0, 1000, 255, 0);
                        if (depth == 0) {
                            stroke(intensity,0,0);
                            strokeWeight(1);
                        } else if (depth == 1) {
                            stroke(0,intensity,0);
                            strokeWeight(1);
                        } else if (depth == 2) {
                            stroke(0,0,intensity);
                            strokeWeight(1);
                        }
                        // println(closestDist);
                        // strokeWeight(map(closestDist, 0, 1000, 5, 0));
                        point(closestHit.x, closestHit.y);
                        // drawGradient(new PVector(pos.x,pos.y), new PVector(closestHit.x,closestHit.y), color(255, 0,0), color(intensity, 0,0));
                        if (drawLines) {
                            line(rays[i][depth].pos.x, rays[i][depth].pos.y, closestHit.x, closestHit.y);
                        }
                        if (depth!= 2) {
                            Wall w = walls[wallIndex];
                            float lineAngle = atan2(w.b.y - w.a.y, w.b.x - w.a.x);
                            float newAngle = 2 * lineAngle - rays[i][depth].angle;
                            // println(degrees(newAngle));
                            rays[i][depth + 1] = new Ray((int)closestHit.x,(int)closestHit.y, newAngle, 255, depth + 1);
                        }

                    }
                }
            }
        }

    }

    void drawGradient(PVector start, PVector end, color a, color b) {
        for (int i = 0; i < 100; i++) {
            stroke(lerpColor(a, b, i / 100.0));
            line(
               ((100 - i) * start.x + i * end.x) / 100,
               ((100 - i) * start.y + i * end.y) / 100,
               ((100 - i - 1) * start.x + (i + 1) * end.x) / 100,
               ((100 - i - 1) * start.y + (i + 1) * end.y) / 100
               );
        }
    }

    void drawLines() {
        this.drawLines = !this.drawLines;
    }
}
