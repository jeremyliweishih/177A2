/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
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
    public float c_radius = mass * 10;
    //stores node and all coulumb forces from other nodes
    
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
    
    public void updateNode(){
      this.velocity[0] += this.accel[0];
      this.velocity[1] += this.accel[1];
      this.position[0] += this.velocity[0];
      this.position[1] += this.velocity[1];
      oob();
      
      this.accel[0] = this.accel[0] * 0.85;
      this.accel[1] = this.accel[1] * 0.85;

      this.velocity[0] = this.velocity[0] * 0.85;
      this.velocity[1] = this.velocity[1] * 0.85;
    }
    
    public void oob(){
      float x = this.position[0];
      float y = this.position[1];
      
      if(x - c_radius < 0){
         this.position[0] = 0 + c_radius;
      }
      
      if(x + c_radius > width){
         this.position[0] = width - c_radius;
      }
      
      if(y - c_radius < 0){
         this.position[1] = 0 + c_radius;
      }
      
      if(y + c_radius > height){
         this.position[1] = (height) - c_radius;
      }    
    }
    
    public void drawNode(float scale){   
         //update radius if control slider changes by user
         c_radius = mass * scale;
         ellipse(position[0], position[1], c_radius,c_radius); 
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
        text(data, position[0], position[1] - c_radius*.10);

    }
    //all mouse related functions
    public boolean mouseOver(){
      float disX = position[0] - mouseX;
      float disY = position[1] - mouseY;
      if(sqrt(sq(disX) + sq(disY)) < c_radius/2 ) {
        return true;
      }
      return false; 
    }   
    
    public float getSpring(Node n){
       for(int i = 0; i < c_nodes.size(); i++){
          if(c_nodes.get(i) == n.id){
             return (float)this.springs.get(i); 
          }
       }
       
       return 0;
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
        if( Double.isNaN((double)len)){ //halp
           len = 800;  
        }
        return len;
    }
}