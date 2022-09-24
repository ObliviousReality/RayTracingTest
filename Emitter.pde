class Emitter{

    int MAXDEPTH = 3;

    PVector pos = new PVector();
    Ray[][] rays;
    int density;

    PVector[][] lights;

    boolean drawLines = false;
    boolean drawColour = false;
    Emitter(int x, int y, int density) {
        this.density = density;
        rays = new Ray[90 * density][MAXDEPTH];
        lights = new PVector[90 * density][MAXDEPTH];
        // rays = new Ray[1][MAXDEPTH];
        // rays = new Ray[8][MAXDEPTH];
        pos.x = x;
        pos.y = y;
        createRays();
    }

    void createRays() { // map(i,0,rays.length,0,360)
        float angle = -QUARTER_PI;
        for (int i = 0; i < rays.length; i++) {
            rays[i][0] = new Ray(pos.x,pos.y, angle,0);
            angle =  - QUARTER_PI + (HALF_PI * ((float)i / (float)rays.length));
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
        for (int depth = MAXDEPTH - 1; depth >= 0; depth--) {
            for (int i = 0; i < rays.length; i++) {
                // println(i);
                // println(depth);
                if (rays[i][depth] != null) {
                    rays[i][depth].draw();
                    if (lights[i][depth]!= null) {
                        float intensity = map(lights[i][depth].z, 0, 1000, 255, 0);
                        float weight = map(lights[i][depth].z, 0, width * 2, 5, 0);
                        if (drawColour) {
                            if (depth == 0) {
                                stroke(intensity,0,0);
                                strokeWeight(1);
                            } else if (depth == 1) {
                                stroke(0,intensity,0);
                                strokeWeight(2);
                            } else if (depth == 2) {
                                stroke(0,0,intensity);
                                strokeWeight(3);
                            }
                            else if (depth == 3) {
                                stroke(0,intensity,intensity);
                                strokeWeight(4);
                            }
                        } else{
                            stroke(255 / (depth + 1));
                        }
                        strokeWeight(weight);
                        point(lights[i][depth].x, lights[i][depth].y);
                        strokeWeight(1);
                        if (drawLines) {
                            line(rays[i][depth].pos.x, rays[i][depth].pos.y, lights[i][depth].x, lights[i][depth].y);
                        }
                    }
                }
            }
        }
    }

    void test(Wall[] walls)
        {
        for (int depth = 0; depth < MAXDEPTH; depth++) {
            for (int i = 0; i < rays.length; i++) {
                if (rays[i][depth] != null) {
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
                        float intensity = map(closestDist, 0, 1000, 255, 0);

                        stroke(255 / (depth + 1));
                        // stroke(intensity);

                        float weight = map(closestDist, 0, width * 2, 5, 0);
                        // strokeWeight();
                        lights[i][depth] = new PVector(closestHit.x, closestHit.y, closestDist);
                        // point(closestHit.x, closestHit.y);
                        Wall w = walls[wallIndex];
                        float lineAngle = atan2(w.b.y - w.a.y, w.b.x - w.a.x);
                        float rayAngle = rays[i][depth].angle;
                        while(lineAngle < 0)
                            {
                            lineAngle += TWO_PI;
                        }
                        while(rayAngle > TWO_PI) {
                            rayAngle -= TWO_PI;
                        }
                        while(rayAngle < 0) {
                            rayAngle += TWO_PI;
                        }
                        if (depth < MAXDEPTH - 1) {
                            float newAngle = 2 * lineAngle - rays[i][depth].angle;
                            while(newAngle < 0) {
                                newAngle += TWO_PI;
                            }
                            if (round(sin(lineAngle + HALF_PI) * 1000.0) / 1000.0 != round(sin(newAngle) * 1000.0) / 1000.0) {
                                rays[i][depth + 1] = new Ray(closestHit.x - rays[i][depth].dir.x,closestHit.y - rays[i][depth].dir.y, newAngle, depth + 1);
                            }
                            else{
                                for (int t = depth + 1; t < MAXDEPTH; t++) {
                                    rays[i][t] = null;
                                }
                            }
                        }
                    }
                    else{
                        for (int t = depth + 1; t < MAXDEPTH; t++) {
                            rays[i][t] = null;
                            lights[i][t] = null;
                        }
                    }
                }
            }
        }

    }

    void drawLines() {
        this.drawLines = !this.drawLines;
    }

    void colour() {
        drawColour = !drawColour;
    }
}
