<?php

use Phalcon\Mvc\Model\Resultset\Complex;

class IndexController extends ControllerBase
{
  public function indexAction(){

   $todos = Todos::find();
   $this->view->todos = $todos;
  }

  public function testAction(){

    $todo_list = new Todos();
    $todo_list->title = "Work hard!";

    /*
    if ($todo_list->save() == false) {
      echo "Umh, We can't store todos right now: \n";
      foreach ($todo_list->getMessages() as $message) {
          echo $message, "\n";
      }
    } else {
      echo "Great, a new todo was saved successfully!";
    }
    */

  }
}
