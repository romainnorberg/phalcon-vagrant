<?php

use Phalcon\Mvc\Model,
    Phalcon\Events\Manager as EventsManager;

class TodoItems extends Model
{
  public $title;

  public function getSource(){
    return 'todo_items';
  }

  public function initialize(){

    $eventsManager = new EventsManager();

    // Attach an anonymous function as a listener for "model" events
    $eventsManager->attach('model', function ($event, $robot) {
      if ($event->getType() == 'beforeCreate') {
        $uuid = $this->getDI()->getUtils()->uuid();
        $this->uuid = hex2bin($uuid);
      }

      return true;
    });

    // Attach the events manager to the event
    $this->setEventsManager($eventsManager);
  }

  function getId(){
    return bin2hex($this->uuid);
  }

  function setTodoId($id){
    return $this->todo_uuid = hex2bin($id);
  }
}
