/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Functions for all force related calculations
/*----------------------------------------------------------------*/
void cal_coloumbs(HashMap<Integer, Node> nodes){
  //float d_l = 0;
  //float k = 1;
  float k2 = 100;
 
  for(Node n : nodes.values()){
  // compute coulumb force contribution 
      for( Node other_node : nodes.values()){
        if (other_node.getId() != n.getId())
        {
        float distance = n.distance_from(other_node);
        float col_force = k2 / (distance * distance); // Coulombs Law f = k2/dist where k2 is defin);
        float[] direction = new float[2];
          //x
        direction[0] = -(other_node.position[0]- n.position[0]);
        direction[1] = -(other_node.position[1]- n.position[1]);
        direction = normalize(direction);
        float[] force = new float[2];
        force[0] = direction[0] * col_force;
        force[1] = direction[1] * col_force;
          //f = m * a
        float[] accel = new float[2];
          accel[0] = force[0] / n.mass;
          accel[1] = force[1] / n.mass;
   
          //add force to node acceleration
          n.accel[0] += accel[0];
          n.accel[1] += accel[1];
          //store all coulumb forces
          //n.coulumb_forces.put((int)other_node.getId(), col_force);
        }
      }
  }
}


float[] normalize(float[] direction){

  float l = (float)(Math.sqrt(direction[0] * direction[0] + direction[1] * direction[1]));
  direction[0] = direction[0] / l;
  direction[1] = direction[1] / l;
  return direction;
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