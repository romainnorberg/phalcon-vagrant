<?php

use Phalcon\Db\Column,
    Phalcon\Db\Index,
    Phalcon\Db\Reference,
    Phalcon\Mvc\Model\Migration;

class TodoItemsMigration_100 extends Migration
{
  public function up()
  {
    $this->morphTable(
      'todo_items',
      array(
      'columns' => array(
          new Column(
              'uuid',
              array(
                  'type' => 'BINARY(16)',
                  'unsigned' => true,
                  'autoIncrement' => false,
                  'first' => true
              )
          ),
          new Column(
              'todo_uuid',
              array(
                  'type' => 'VARBINARY(16)',
                  'after' => 'uuid'
              )
          ),
          new Column(
              'title',
              array(
                  'type' => Column::TYPE_VARCHAR,
                  'notNull' => true,
                  'size' => 60,
                  'after' => 'todo_uuid'
              )
          )
      ),
      'indexes' => array(
          new Index('PRIMARY', array('uuid')),
          new Index('fk_todo1_idx', array('todo_uuid')),
      ),
      'references' => array(
          new Reference(
              'fk_todo1',
              array(
                  'referencedSchema' => 'uuid-app',
                  'referencedTable' => 'todos',
                  'columns' => array('todo_uuid'),
                  'referencedColumns' => array('uuid')
              )
          )
      ),
      'options' => array(
          'TABLE_TYPE' => 'BASE TABLE',
          'ENGINE' => 'InnoDB',
          'TABLE_COLLATION' => 'utf8_general_ci'
      )
    )
    );
  }
}
