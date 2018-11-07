<?php

/* This file was autogenerated by spec/parser.php - Do not modify */

namespace PhpAmqpLib\Wire;

class Constants080
{
    /**
     * @var string
     */
    public static $AMQP_PROTOCOL_HEADER = "AMQP\x01\x01\x08\x00";

    /**
     * @var array
     */
    public static $FRAME_TYPES = array(
        1 => 'FRAME-METHOD',
        2 => 'FRAME-HEADER',
        3 => 'FRAME-BODY',
        4 => 'FRAME-OOB-METHOD',
        5 => 'FRAME-OOB-HEADER',
        6 => 'FRAME-OOB-BODY',
        7 => 'FRAME-TRACE',
        8 => 'FRAME-HEARTBEAT',
        4096 => 'FRAME-MIN-SIZE',
        206 => 'FRAME-END',
        501 => 'FRAME-ERROR',
    );

    /**
     * @var array
     */
    public static $CONTENT_METHODS = array(
        0 => '60,40',
        1 => '60,50',
        2 => '60,60',
        3 => '60,71',
        4 => '70,50',
        5 => '70,70',
        6 => '80,40',
        7 => '80,50',
        8 => '80,60',
        9 => '110,10',
        10 => '120,40',
        11 => '120,41',
    );

    /**
     * @var array
     */
    public static $CLOSE_METHODS = array(
        0 => '10,60',
        1 => '20,40',
    );

    /**
     * @var array
     */
    public static $GLOBAL_METHOD_NAMES = array(
        '10,10' => 'Connection.start',
        '10,11' => 'Connection.start_ok',
        '10,20' => 'Connection.secure',
        '10,21' => 'Connection.secure_ok',
        '10,30' => 'Connection.tune',
        '10,31' => 'Connection.tune_ok',
        '10,40' => 'Connection.open',
        '10,41' => 'Connection.open_ok',
        '10,50' => 'Connection.redirect',
        '10,60' => 'Connection.close',
        '10,61' => 'Connection.close_ok',
        '20,10' => 'Channel.open',
        '20,11' => 'Channel.open_ok',
        '20,20' => 'Channel.flow',
        '20,21' => 'Channel.flow_ok',
        '20,30' => 'Channel.alert',
        '20,40' => 'Channel.close',
        '20,41' => 'Channel.close_ok',
        '30,10' => 'Access.request',
        '30,11' => 'Access.request_ok',
        '40,10' => 'Exchange.declare',
        '40,11' => 'Exchange.declare_ok',
        '40,20' => 'Exchange.delete',
        '40,21' => 'Exchange.delete_ok',
        '50,10' => 'Queue.declare',
        '50,11' => 'Queue.declare_ok',
        '50,20' => 'Queue.bind',
        '50,21' => 'Queue.bind_ok',
        '50,30' => 'Queue.purge',
        '50,31' => 'Queue.purge_ok',
        '50,40' => 'Queue.delete',
        '50,41' => 'Queue.delete_ok',
        '50,50' => 'Queue.unbind',
        '50,51' => 'Queue.unbind_ok',
        '60,10' => 'Basic.qos',
        '60,11' => 'Basic.qos_ok',
        '60,20' => 'Basic.consume',
        '60,21' => 'Basic.consume_ok',
        '60,30' => 'Basic.cancel',
        '60,31' => 'Basic.cancel_ok',
        '60,40' => 'Basic.publish',
        '60,50' => 'Basic.return',
        '60,60' => 'Basic.deliver',
        '60,70' => 'Basic.get',
        '60,71' => 'Basic.get_ok',
        '60,72' => 'Basic.get_empty',
        '60,80' => 'Basic.ack',
        '60,90' => 'Basic.reject',
        '60,100' => 'Basic.recover_async',
        '60,110' => 'Basic.recover',
        '60,111' => 'Basic.recover_ok',
        '70,10' => 'File.qos',
        '70,11' => 'File.qos_ok',
        '70,20' => 'File.consume',
        '70,21' => 'File.consume_ok',
        '70,30' => 'File.cancel',
        '70,31' => 'File.cancel_ok',
        '70,40' => 'File.open',
        '70,41' => 'File.open_ok',
        '70,50' => 'File.stage',
        '70,60' => 'File.publish',
        '70,70' => 'File.return',
        '70,80' => 'File.deliver',
        '70,90' => 'File.ack',
        '70,100' => 'File.reject',
        '80,10' => 'Stream.qos',
        '80,11' => 'Stream.qos_ok',
        '80,20' => 'Stream.consume',
        '80,21' => 'Stream.consume_ok',
        '80,30' => 'Stream.cancel',
        '80,31' => 'Stream.cancel_ok',
        '80,40' => 'Stream.publish',
        '80,50' => 'Stream.return',
        '80,60' => 'Stream.deliver',
        '90,10' => 'Tx.select',
        '90,11' => 'Tx.select_ok',
        '90,20' => 'Tx.commit',
        '90,21' => 'Tx.commit_ok',
        '90,30' => 'Tx.rollback',
        '90,31' => 'Tx.rollback_ok',
        '100,10' => 'Dtx.select',
        '100,11' => 'Dtx.select_ok',
        '100,20' => 'Dtx.start',
        '100,21' => 'Dtx.start_ok',
        '110,10' => 'Tunnel.request',
        '120,10' => 'Test.integer',
        '120,11' => 'Test.integer_ok',
        '120,20' => 'Test.string',
        '120,21' => 'Test.string_ok',
        '120,30' => 'Test.table',
        '120,31' => 'Test.table_ok',
        '120,40' => 'Test.content',
        '120,41' => 'Test.content_ok',
    );
}
