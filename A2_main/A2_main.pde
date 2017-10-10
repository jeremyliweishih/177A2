import java.util.*;
HashMap<Integer, Node> nodes = new HashMap<Integer, Node>();
int resize_scale = 10;

void setup(){
    surface.setResizable(true);
    String[] data = loadStrings("./data1.csv");
    parseNodes(data);
    parseEdges(data);
    size(600,600);

}
void draw() {
  background(#ffffff);
  drawEdges(nodes); 
  drawNodes(nodes);
  cal_coloumbs(nodes);
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

void drawNodes(HashMap<Integer, Node> nodes){
  
  for (Node n : nodes.values()) {
    if(n.mouseOver()){
        fill(153);
         n.drawNode();
         n.show_data();
     } else {
       fill(#ffffff);
       n.drawNode();   
     }
  }
}


float dist_between_n(Node n, int neighbor_id){
  float root_len = 0;
  Node ne_node = nodes.get(neighbor_id);
  double ne_xpos = (double)ne_node.position[0]; 
  double ne_ypos = (double)ne_node.position[1];
  double n_xpos = (double)n.position[0];
  double n_ypos = (double)n.position[1];
  
  root_len = (float)Math.sqrt((Math.pow(ne_xpos - n_xpos,2) + 
              Math.pow(ne_ypos - n_ypos,2)));
  println ("r :" + root_len);
  return root_len;
}


void drawEdges(HashMap<Integer, Node> nodes){ 
  for (Node n : nodes.values()){
    for(int i = 0; i < n.c_nodes.size(); i++)
    {
      
      n.drawEdge(n.c_nodes.get(i), nodes);
    }
 }
}

void mouseDragged(){
 for (Node n : nodes.values()) {
     if(n.mouseOver()){
       n.position[0] = mouseX;
       n.position[1] = mouseY;
     }
 } 
}
void cal_coloumbs(HashMap<Integer, Node> nodes){
  float distance = 0;
  //float acc = 0;
  float col_force = 0;
  //float d_l = 0;
  //float k = 1;
  float k2 = 1;
 
  for(Node n : nodes.values()){
  // compute coulumb force contribution 
      for( Node other_node : nodes.values()){
        if (other_node.getId() != n.getId())
        {
          distance = n.distance_from(other_node); 
          col_force = k2/distance; // Coulombs Law f = k2/dist where k2 is defined
          //store all coulumb forces
          n.coulumb_forces.put((int)other_node.getId(), col_force);
        }
      }
      n.add_sprforce(nodes);
  }
}

// PRINT TEST FOR COULUMB FORCES
//void testc( Node n)
//{
//  for(int id : n.coulumb_forces.keySet()){
//     println("id: " + id + "sum: " + n.coulumb_forces.get(id));
//  }
//}
//void test(Node n)
//{
//  println("SPRINGS: ");
//   for ( int i = 0; i < n.springs.size(); i++)
//   {
//     println("id: " + n.c_nodes.get(i) + " " + n.springs.get(i)); 
//   }
//   println("C_FORCES: ");
//   for(int id : n.coulumb_forces.keySet()){
//     println("id: " + id + "v: " + n.coulumb_forces.get(id));
//   }
//}
      //}
      //for( int i = 0 ; i < n.springs.size(); i++) {
      //  distance = n.distance_from(n.c_nodes.get(i), nodes); 
      //  d_l = Math.abs(n.springs.get(i) - distance); //spring val - length
      //  col_force = k * d_l;     // F = k * D_L, where k is defined
      //  //compute acceleration
      //  acc = col_force/n.mass;  // f = m * a, where we know f & m
      //  print(acc);
        //computer velocity