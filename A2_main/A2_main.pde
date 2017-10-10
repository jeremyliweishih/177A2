import java.util.*;

HashMap<Integer, Node> nodes = new HashMap<Integer, Node>();

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
 
  
}


void parseNodes(String[] data){
   int n = Integer.parseInt(data[0]);
   for(int i = 1; i <= n; i++){
      String[] values = data[i].split(",");
      Node new_node = new Node((float)Integer.parseInt(values[0]), (float)Integer.parseInt(values[1]));
      new_node.position[0] = (float)Math.random() * 600 + 1;
      new_node.position[1] = (float)Math.random() * 600 + 1;
      new_node.c_diameter = new_node.mass * 20;
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