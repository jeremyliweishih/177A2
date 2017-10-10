/*----------------------------------------------------------------
  Functions related to drawing
/*----------------------------------------------------------------*/
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