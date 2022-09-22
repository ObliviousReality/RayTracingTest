class Wall{

    PVector a = new PVector();
    PVector b = new PVector();

    Wall(int x1, int y1, int x2, int y2) {
        a.x = x1;
        a.y = y1;
        b.x = x2;
        b.y = y2;
    }

    void draw()
    {
        stroke(255);
        strokeWeight(1);
        line(a.x, a.y,b.x, b.y);
    }
}
