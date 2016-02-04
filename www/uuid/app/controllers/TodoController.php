<?php

class TodoController extends ControllerBase
{
  public function Add_itemAction(){
    $todo_id = $this->request->getPost('todo_id');
    $todo_title = $this->request->getPost('todo_title');

    $todo = Todos::find('hex(uuid) = "'.$todo_id.'"');

    if($todo){
      $todo_item = new Todoitems();
      $todo_item->setTodoId($todo_id);
      $todo_item->title = $todo_title;
      $todo_item->save();
    }

    return $this->response->redirect("/");
  }
}
