import java.util.*;

class Node implements Comparable<Node> {
    int x, y;
    int g, h;
    Node parent;

    Node(int x, int y, int g, int h, Node parent) {
        this.x = x;
        this.y = y;
        this.g = g;
        this.h = h;
        this.parent = parent;
    }

    int f() {
        return g + h;
    }

    public int compareTo(Node other) {
        return this.f() - other.f();
    }
}

public class AStarMaze {

    static int ROW = 5;
    static int COL = 5;

    static int[][] maze = {
            {0, 0, 0, 0, 0},
            {1, 1, 0, 1, 0},
            {0, 0, 0, 1, 0},
            {0, 1, 1, 0, 0},
            {0, 0, 0, 0, 0}
    };

    static int[] dx = {-1, 1, 0, 0};
    static int[] dy = {0, 0, -1, 1};

    static int heuristic(int x, int y, int goalX, int goalY) {
        return Math.abs(x - goalX) + Math.abs(y - goalY);
    }

    static boolean isValid(int x, int y) {
        return x >= 0 && y >= 0 && x < ROW && y < COL && maze[x][y] == 0;
    }

    static void printPath(Node node) {
        if (node == null)
            return;

        printPath(node.parent);

        System.out.println("(" + node.x + ", " + node.y + ")");
    }

    public static void aStar(int startX, int startY, int goalX, int goalY) {

        PriorityQueue<Node> open = new PriorityQueue<>();
        boolean[][] visited = new boolean[ROW][COL];

        Node start = new Node(
                startX,
                startY,
                0,
                heuristic(startX, startY, goalX, goalY),
                null
        );

        open.add(start);

        while (!open.isEmpty()) {

            Node current = open.poll();

            if (current.x == goalX && current.y == goalY) {
                System.out.println("Path Found:\n");
                printPath(current);
                return;
            }

            visited[current.x][current.y] = true;

            for (int i = 0; i < 4; i++) {

                int newX = current.x + dx[i];
                int newY = current.y + dy[i];

                if (isValid(newX, newY) && !visited[newX][newY]) {

                    Node neighbor = new Node(
                            newX,
                            newY,
                            current.g + 1,
                            heuristic(newX, newY, goalX, goalY),
                            current
                    );

                    open.add(neighbor);
                }
            }
        }

        System.out.println("No Path Found");
    }

    public static void main(String[] args) {

        int startX = 0;
        int startY = 0;

        int goalX = 4;
        int goalY = 4;

        aStar(startX, startY, goalX, goalY);
    }
}
