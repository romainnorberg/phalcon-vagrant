<?php

use Phalcon\Db\Column,
    Phalcon\Db\Index,
    Phalcon\Mvc\Model\Migration;

class TodosMigration_100 extends Migration
{
  public function up()
  {
    $this->morphTable(
      'todos',
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
              'title',
              array(
                  'type' => Column::TYPE_VARCHAR,
                  'notNull' => true,
                  'size' => 60,
                  'after' => 'uuid'
              )
          )
      ),
      'indexes' => array(
          new Index('PRIMARY', array('uuid'))
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
