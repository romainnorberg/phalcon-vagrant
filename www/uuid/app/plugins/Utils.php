<?php

use \Phalcon\Mvc\User\Plugin;

class Utils extends Plugin
{
  public function uuid()
  {
    $result = $this->db->query("SELECT uuid()");
    $arr = $result->fetch();
    return str_replace('-', '', $arr[0]);
  }
}
