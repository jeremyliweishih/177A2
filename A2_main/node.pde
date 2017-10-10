/*----------------------------------------------------------------
  Node class header
      where a node has a circle representation with mass and id
      values for identification and relationship with other nodes
      stored in maps and lists.
/*----------------------------------------------------------------*/

public class Node{
    public float mass;
    public float id;
    public ArrayList<Integer> c_nodes = new ArrayList<Integer>();
    public ArrayList<Integer> springs = new ArrayList<Integer>();
    public float c_diameter = mass * 10;
    //stores node and all coulumb forces from other nodes
    public HashMap<Integer, Float> coulumb_forces = 
                                       new HashMap<Integer, Float>();
    
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
    
   //finds distance between node and its neighbor
    public float distance_from(Node to)
    {
        float len = 0;
        double ne_xpos = (double)to.position[0]; //other node
        double ne_ypos = (double)to.position[1];
        double n_xpos = (double)position[0];
        double n_ypos = (double)position[1];
        
        len = (float)Math.sqrt((Math.pow(ne_xpos - n_xpos,2) + 
              Math.pow(ne_ypos - n_ypos,2)));
        return len;
    }
    
    //adds spring force to corresponding ids in coulumb_forces
    public void add_sprforce(HashMap<Integer, Node> nodes){
      float adj_id = 0; 
      float prev_force = 0;  
      for( int i = 0; i < c_nodes.size(); i++){
          Node adj_node = nodes.get(c_nodes.get(i));
          adj_id = adj_node.getId();
          prev_force = coulumb_forces.get((int)adj_id);
          coulumb_forces.put((int)adj_id, prev_force + springs.get(i));
      }
    }
}