<?php
//header('Content-Type: application/json');
date_default_timezone_set('Europe/Madrid');

//durante el desarrollo
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once("./clases/Rest.php");
require_once("./clases/Authorization.php");
require_once("./clases/Conexion.php");
$rest=new Rest();
$conexion=new Conexion();
$conexion->conexion();
$authorization=new Authorization($rest->getHeader("authorization"));
$key = 'dam';
$ok=false;
if($authorization->checkLength()) {
    if($authorization->isBasic()) {
        if($conexion->comprobarUsuario($authorization->getUser(),$authorization->getPassword())){
                $ok = $authorization->newToken();
        }
    }
} else  if ($authorization->isBearer()) {
        if(!$authorization->isExpired()) {
            $ok = $authorization->modifyToken();
        }
}
if($ok) {
    $respuesta = array('ok' => 1, 'token' => $authorization->getToken());
    if($rest->getMethod() === 'GET') {
            if($rest->getRoute() === 'product'){
                $respuesta["peti"] = $rest->getRoute();
               $respuesta["op"] = $conexion->devolverProductos();
            }else if($rest->getRoute() === 'family'){
                $respuesta["peti"] = $rest->getRoute();
                $respuesta["op"] = $conexion->devolverCategorias(); 
            }else if($rest->getRoute() === 'ticket'){
                $respuesta["peti"] = $rest->getRoute();
                $respuesta["op"] = $conexion->devolverTickets();
            }else if($rest->getRoute() === 'ticketdetail'){
                $respuesta["peti"] = $rest->getRoute();
                $respuesta["op"] = $conexion->devolverTicketsDetail();
            }
            
        
    } else if($rest->getMethod() === 'POST') {
        if($rest->getRoute() === 'product'){
                if($authorization->getUser()==""){
                    $conexion->subirTicket($authorization->getUsuario(),$rest->getJson());
                    $respuesta["op"] = $conexion->devolverTickets();
                    $respuesta["op1"] = $conexion->devolverTicketsDetail();
                }else{
                    $conexion->subirTicket($authorization->getUser(),$rest->getJson());
                    $respuesta["op"] = $conexion->devolverTickets();
                    $respuesta["op1"] = $conexion->devolverTicketsDetail();
                }
                //$respuesta["op"]=$rest->getJson();
            }
    }
} else if ($rest->getRoute() === 'producto'|| $rest->getRoute() === 'familia'||$rest->getRoute() === 'tickets') {
    if($rest->getRoute() === 'producto'){
        $respuesta= $conexion->devolverProductos();
    }
    
}else{
    $respuesta = array('ok' => 0);
}
print_r(json_encode($respuesta));
$conexion->cerrarConexion();

function op2() {
    return array("id"=>1,"idfamily"=>1,"product"=>"pan blanco","price"=>0.50,"description"=>"es el mejor pan del mundo");
}