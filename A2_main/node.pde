public class Node{
    public float mass;
    public float id;
    public ArrayList<Integer> c_nodes = new ArrayList<Integer>();
    public ArrayList<Integer> springs = new ArrayList<Integer>();
    public float c_diameter = mass * 10;
    
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
       ellipse(position[0], position[1], c_diameter,c_diameter); 
    }
    
    public float get_x(){
       return position[0]; 
    }
    
    public float get_y(){
       return position[1]; 
    }
     
    public void drawEdge(int id, HashMap<Integer, Node> nodes){
      Node connect_to = nodes.get(id);
      line(position[0], position[1], connect_to.get_x(),connect_to.get_y());
    }
    
    public void show_data(){
        String data = "Id:" + id + System.lineSeparator() + "Mass: " + mass;
        textSize(10);
        textAlign(CENTER);
        fill(0);
        text(data, position[0], position[1] - c_diameter*.10);

    }
    //all mouse related functions
    public boolean mouseOver(){
      float disX = position[0] - mouseX;
      float disY = position[1] - mouseY;
      if(sqrt(sq(disX) + sq(disY)) < c_diameter/2 ) {
        return true;
      }
      return false; 
    }   
}