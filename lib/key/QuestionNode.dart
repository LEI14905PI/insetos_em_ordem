import 'dart:core';
import 'package:insetos_em_ordem/key/KeyOption.dart';

/// Node representing an intermediate step in an identification, identified by a node id,

/// contains the question relevant to the step, and both options for the answers.

class QuestionNode {
    /// Creates a question node with the question and both options.

    /// @param id identification of the node

    /// @param question the question of this step

    /// @param optionA the option A of this step

    /// @param optionB the option B of this step

  final String id;
  final String question;
  final KeyOption optionA;
  final KeyOption optionB;

  QuestionNode(this.id,this.question,this.optionA,this.optionB);

 
     /// Get the id of the node
     
     /// @return the id of the node
     
  String getId() {
    return id;
  }

    
     /// Get the question of the step
     
     /// @return the question of the step
     
  String getQuestion() {
    return question;
  }

    
     /// Get the A option of the step
     
     /// @return the A option of the step
     
  KeyOption getOptionA() {
    return optionA;
  }

    
     /// Get the B option of the step
     
     /// @return the B option of the step
     
  KeyOption getOptionB() {
    return optionB;
  }

    
     /// The string representation of the node
     
     /// @return the string representation of the node
     
    
  String toString() {
    return "QuestionNode{" +
              "id='" + id + '\'' +
              ", question='" + question + '\'' +
              ", optionA=" + optionA.toString() +
              ", optionB=" + optionB.toString() +
              '}';
  }

}