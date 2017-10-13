/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Main interface for Force-Directed Node-Link Visualization
/*----------------------------------------------------------------*/
import java.util.*;
HashMap<Integer, Node> nodes = new HashMap<Integer, Node>();
List<Slider> All_Sl = new ArrayList<Slider>();
List<Float> sscale = new ArrayList<Float>();
List<Float> scale_increment = new ArrayList<Float>();

void setup(){
    String[] data = loadStrings("./data2.csv");
    initialize_sscale();
    parseNodes(data);
    parseEdges(data);
    control_bar();
    cal_coloumbs(nodes);
    cal_hookes(nodes);
    maintain_init_l(nodes);
    updateNodes(nodes);
    
    size(600,600);

}
void draw() {
  background(#ffffff);
  
  text("Total Energy: " + calcEnergy(nodes), 40, 40);
  println("total energy: " + calcEnergy(nodes));
  
  if(calcEnergy(nodes) >= nodes.size() / 10 || mousePressed){
    cal_coloumbs(nodes);
    cal_hookes(nodes);
    maintain_init_l(nodes);
    updateNodes(nodes);

  }
  drawEdges(nodes);
  drawNodes(nodes); 
  draw_control_bar();

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
      new_node.c_radius = new_node.mass * sscale.get(0);
      w_range = ((width - new_node.c_radius) - new_node.c_radius);
      new_node.position[0] = (float)(Math.random() * w_range) + new_node.c_radius;
      h_range = ((height - new_node.c_radius) - new_node.c_radius);
      new_node.position[1] = (float)(Math.random() * h_range) + new_node.c_radius;
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
  float c_w = r_w - 10;
  float t_size = 10;
  float sh_size = 15;
  
  //set slider objects

  Slider node_sl = new Slider(0,"Node Size", width - (r_w), height - (r_h + 15), r_w - 10,r_h / 5); 
  node_sl.setLabelinfo(width - (r_w + 77), height - (r_h + 5) , t_size);
  node_sl.setSlHand(color(255, 0, 0), width - (r_w / 2 + 5) -  sh_size/2 , height - (r_h + 15) , sh_size , r_h / 5);
  All_Sl.add(node_sl);
 
  
  Slider col_sl = new Slider(1,"Coulumb Force", width - (r_w), height - (r_h) , c_w , r_h / 5); 
  col_sl.setLabelinfo(width - (r_w + 77), height - (r_h) + t_size, t_size);
  col_sl.setSlHand(color(0, 255, 0), width - (r_w / 2 + 5) -  sh_size/2 , height - (r_h) , sh_size , r_h / 5);
  All_Sl.add(col_sl);

  Slider h_sl = new Slider(2,"Hookes Force", width - (r_w), height - (r_h - 15) , c_w , r_h / 5);
  h_sl.setLabelinfo(width - (r_w + 77), height - r_h + (t_size*2) + 5, t_size);
  h_sl.setSlHand(color(255, 255, 0),width - (r_w / 2 + 5) -  sh_size/2, height - (r_h - 15) , sh_size , r_h / 5);
  All_Sl.add(h_sl);
  
  Slider m_sl = new Slider(2,"Edge Force", width - (r_w), height - (r_h - 30) , c_w , r_h / 5);
  m_sl.setLabelinfo(width - (r_w + 77), height - (r_h) + (t_size * 3) + 10, t_size);
  m_sl.setSlHand(color(10, 150, 255), width - (r_w / 2 + 5) -  sh_size/2, height - (r_h - 30) , sh_size , r_h / 5);
  All_Sl.add(m_sl);
}

void draw_control_bar(){
  float r_h = 50;
  float r_w = 100;
  float r_radii = 7;
  fill(#ffffff);
  rect(width - (r_w + 80), height - (r_h + 20) , r_w + 75, r_h + 15, r_radii);
  
  for(int i = 0; i < All_Sl.size(); i++){
    All_Sl.get(i).mouseOver = false;
    All_Sl.get(i).drawSlider();
    
    All_Sl.get(i).drawSliderHand();
  }  
}

void initialize_sscale(){
    //0 is node size
    sscale.add(5.0);
    scale_increment.add(-.5); 
    
    //k2 for coulums force
    sscale.add(150.0);
    scale_increment.add(10.0);
    
    //k1 for hookes force
    sscale.add(20.0);
    scale_increment.add(10.0);
    
    //maintain edge distance force
    sscale.add(0.35);
    scale_increment.add(-.01);
}