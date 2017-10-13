/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Main interface for Force-Directed Node-Link Visualization
/*----------------------------------------------------------------*/
import java.util.*;
HashMap<Integer, Node> nodes = new HashMap<Integer, Node>();
int resize_scale = 5;
PGraphics pickbuffer = null;


void setup(){
    String[] data = loadStrings("./data2.csv");
    parseNodes(data);
    parseEdges(data);
    size(600,600);

}
void draw() {
  background(#ffffff);
  cal_coloumbs(nodes);
  cal_hookes(nodes);
  updateNodes(nodes);
  drawEdges(nodes);
  drawNodes(nodes);
  maintain_init_l(nodes);
  control_bar();
  
}

void updateNodes(HashMap<Integer, Node> nodes){
    for(Node n : nodes.values()){
      n.updateNode();
    }
}

void parseNodes(String[] data){
   int n = Integer.parseInt(data[0]);
   float w_range = 0;
   float h_range = 0;
   for(int i = 1; i <= n; i++){
      String[] values = data[i].split(",");
      Node new_node = new Node((float)Integer.parseInt(values[0]), (float)Integer.parseInt(values[1]));    
      new_node.c_diameter = new_node.mass * resize_scale;
      w_range = ((width - new_node.c_diameter) - new_node.c_diameter);
      new_node.position[0] = (float)(Math.random() * w_range) + new_node.c_diameter;
      h_range = ((height - new_node.c_diameter) - new_node.c_diameter);
      new_node.position[1] = (float)(Math.random() * h_range) + new_node.c_diameter;
      nodes.put((int)new_node.id, new_node);
   }
}

void parseEdges(String[] data){
  int n = Integer.parseInt(data[0]) + 2;
  
  for(int i = n; i < data.length; i++){
    String[] values = data[i].split(",");
    int id_1 = Integer.parseInt(values[0]);
    int id_2 = Integer.parseInt(values[1]);
    int l = Integer.parseInt(values[2]);
   
    nodes.get(id_1).addEdge(id_2, l);
    nodes.get(id_2).addEdge(id_1, l);
  }
  
}

void control_bar(){
  float r_h = 50;
  float r_w = 100;
  float r_x = 30;
  float r_y = 20;
  float r_radii = 7;
  float c_w = r_w - 10;
  //control box
  rect(width - (r_w + 80), height - (r_h + 5) , r_w + 75, r_h, r_radii);
  rect(width - (r_w), height - (r_h) , r_w - 10 , r_h / 5);
  rect(width - (r_w), height - (r_h - 15) , c_w , r_h / 5);
  rect(width - (r_w), height - (r_h - 30) , c_w , r_h / 5);
  
  fill(0);
  //sliders
  rect(width - (r_w / 2 + 3) -  c_w/30 , height - (r_h) , c_w/30 , r_h / 5);
  rect(width - (r_w / 2 + 3) -  c_w/30, height - (r_h - 15) , c_w/30 , r_h / 5);
  rect(width - (r_w / 2 + 3) -  c_w/30, height - (r_h - 30) , c_w/30 , r_h / 5);
  
  //control box text
  int t_size = 10;
  textSize(t_size);
  textAlign(LEFT);
  text("Node Size", width - (r_w + 77), height - (r_h) + t_size );
  text("Coulumb Force", width - (r_w + 77), height - r_h + (t_size*2) + 5);
  text("Hookes Force", width - (r_w + 77), height - (r_h) + (t_size * 3) + 10 );
}