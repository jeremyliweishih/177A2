/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Functions for all force related calculations
/*----------------------------------------------------------------*/
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
void cal_acc(HashMap<Integer, Node> nodes){
  for(Node n : nodes.values()){
      
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