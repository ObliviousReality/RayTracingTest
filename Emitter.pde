class Emitter{

    int MAXDEPTH = 3;

    PVector pos = new PVector();
    Ray[][] rays;
    int density;

    boolean drawLines = false;
    Emitter(int x, int y, int density) {
        this.density = density;
        rays = new Ray[360 * density][MAXDEPTH];
        // rays = new Ray[1][MAXDEPTH];
        // rays = new Ray[8][MAXDEPTH];
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
            for (int depth = 0; depth < MAXDEPTH; depth++) {
                if (rays[i][depth] != null) {
                    rays[i][depth].draw();
                }
            }
        }
    }

    void test(Wall[] walls)
    {

        for (int i = 0; i < rays.length; i++) {
            for (int depth = 0; depth < MAXDEPTH; depth++) {
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
                        // intensity = 255;
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
                        stroke(intensity);
                        // println(closestDist);
                        if (drawLines) {
                            line(rays[i][depth].pos.x, rays[i][depth].pos.y, closestHit.x, closestHit.y);
                        }
                        strokeWeight(map(closestDist, 0, width * 2, 5, 0));
                        point(closestHit.x, closestHit.y);
                        // drawGradient(new PVector(pos.x,pos.y), new PVector(closestHit.x,closestHit.y), color(255, 0,0), color(intensity, 0,0));
                        Wall w = walls[wallIndex];
                        float lineAngle = atan2(w.b.y - w.a.y, w.b.x - w.a.x);
                        while(lineAngle < 0)
                        {
                            lineAngle += TWO_PI;
                        }
                        if (depth < MAXDEPTH - 1) {
                            float newAngle = 2 * lineAngle - rays[i][depth].angle;
                            while(newAngle < 0) {
                                newAngle += TWO_PI;
                            }
                            // if(cos(newAngle) < 0){
                            //     newAngle = newAngle + PI;
                        // }
                            // if (i ==  5) {
                            //     print(i);
                            //     print("/");
                            //     print(depth);
                            //     print(" : ");
                            //     print(degrees(rays[i][depth].angle));
                            //     print(" => ");
                            //     print(degrees(newAngle));
                            //     print(" Wall Angle: ");
                            //     print(degrees(lineAngle));
                            //     print(" Dist: ");
                            //     print(closestDist);
                            //     print(" Wall: ");
                            //     println(wallIndex);
                            //     println(sin(newAngle));
                            //     println(sin(rays[i][depth].angle));
                            //     // println(round(sin(newAngle) * 1000.0) / 1000.0);
                            //     // println(round(sin(rays[i][depth].angle) * 1000.0) / 1000.0);
                            //     print("Normal: ");
                            //     println(round(sin(lineAngle + HALF_PI) * 1000.0) / 1000.0);
                            //     print("Ray Angle: ");
                            //     println(round(sin(newAngle) * 1000.0) / 1000.0);
                            // }
                            //round(sin(newAngle) * 1000.0) / 1000.0 != -round(sin(rays[i][depth].angle) * 1000.0) / 1000.0
                            //ROUND DOESN't WORK!
                            if (round(sin(lineAngle + HALF_PI) * 1000.0) / 1000.0 != round(sin(newAngle) * 1000.0) / 1000.0) {
                                // println("Not reversed");
                                rays[i][depth + 1] = new Ray(closestHit.x - rays[i][depth].dir.x,closestHit.y - rays[i][depth].dir.y, newAngle, 255, depth + 1);
                            }
                            else{
                                // println("Working");
                                for (int t = depth + 1; t < MAXDEPTH; t++) {
                                    rays[i][t] = null;
                                }
                            }
                        }
                        else{
                            // if (i ==  5) {
                            //     print(i);
                            //     print("/");
                            //     print(depth);
                            //     print(" : ");
                            //     print(degrees(rays[i][depth].angle));
                            //     print(" Wall Angle: ");
                            //     print(degrees(lineAngle));
                            //     print(" Dist: ");
                            //     print(closestDist);
                            //     print(" Wall: ");
                            //     println(wallIndex);
                            // }
                        }

                    }
                    else{
                        for (int t = depth + 1; t < MAXDEPTH; t++) {
                            rays[i][t] = null;
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
