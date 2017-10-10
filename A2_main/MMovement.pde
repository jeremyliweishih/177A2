/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Functions related to all client interactions
/*----------------------------------------------------------------*/
void mouseDragged(){
 for (Node n : nodes.values()) {
     if(n.mouseOver()){
       n.position[0] = mouseX;
       n.position[1] = mouseY;
     }
 } 
}