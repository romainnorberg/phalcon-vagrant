<?php

use Phalcon\Mvc\Model,
    Phalcon\Events\Manager as EventsManager;

class Todos extends Model
{
  public $title;

  public function getSource(){
    return 'todos';
  }

  public function initialize(){
    $this->hasMany('uuid', 'TodoItems', 'todo_uuid', [
        'alias' => 'items'
    ]);

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

  /**
   *
   * @param array $parameters
   * @return \Phalcon\Mvc\Model\ResultsetInterface
   */
  public function getItems($parameters = ['order' => 'uuid asc']){
    return $this->getRelated('items', $parameters);
  }
}
