public class Node{
    public float mass;
    public float id;
    public ArrayList<Integer> c_nodes = new ArrayList<Integer>();
    public ArrayList<Integer> springs = new ArrayList<Integer>();
    
    public float[] accel = new float[2];
    public float[] velocity = new float[2];
    public float[] position = new float[2];

    public Node(float i, float m){
       mass = m;
       id = i;
    }
    
    public void addEdge(int i, int l){
        c_nodes.add(i);
        springs.add(l);
    }
    
    public float getId(){
       return id; 
    }
    
    public void drawNode(){
       ellipse(position[0], position[1], mass * 10, mass * 10); 
    }
}