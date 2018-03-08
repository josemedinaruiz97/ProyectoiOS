<?php
require 'clases/vendor/autoload.php';
use \Firebase\JWT\JWT;//import de java
class Authorization {
    private $trozos;
    private $tiempoExpiracion;
    private $credenciales;
    private $token;
    private $tiempo;
    private $key="panaderia";
    function __construct ($authorization) {
        $this->trozos=explode(' ', $authorization);
        $this->tiempoExpiracion=600;
        $this->credenciales=($this->isBasic() ? explode(":",base64_decode($this->trozos[1])) : "");
        $this->token=($this->isBearer() ? JWT::decode($this->trozos[1], $this->key, array('HS256')) : "");
        
    }
    function isBasic(){
        if($this->trozos[0]=="Basic"){
            return true;
        }
        return false;
    }
    function isBearer(){
        if($this->trozos[0]=="Bearer"){
            return true;
        }
        return false;
    }
    function checkLength(){
        if(count($this->trozos) === 2 && count($this->credenciales) === 2 ) {
            return true;
        }
        return false;
    }
    
    function getTiempoDeVida(){
        return $this->tiempoExpiracion;
    }
    function getUser(){
        if($this->isBasic()){
            return $this->credenciales[0];
        }
        return "";
    }
    function getUsuario(){
        $tok=JWT::decode($this->token, $this->key, array('HS256'));
        return $tok->usuario;
    }
    function getPassword(){
        return $this->credenciales[1];
    }
    function newToken(){
        $hora = new DateTime();
                $contenidoToken = array(
                    'hora'    => $hora->getTimestamp() + $this->tiempoExpiracion,
                    'usuario' => $this->getUser()
                );
                $this->token= JWT::encode($contenidoToken, $this->key);
                return true;
    }
    function getToken(){
        return $this->token;
    }
    function isExpired(){
        $hora = new DateTime();
            if($hora->getTimestamp() < $this->token->hora) {
                return false;
                
            }
            return true;
    }
    function modifyToken(){
        $hora = new DateTime();
        $contenidoToken = array(
                    'hora'    => $hora->getTimestamp() + $this->tiempoExpiracion,
                    'usuario' => $this->token->usuario
                );
                $this->token = JWT::encode($contenidoToken, $this->key);
                return true;
    }
    
}