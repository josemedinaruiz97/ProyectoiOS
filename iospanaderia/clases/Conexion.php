<?php 
class Conexion {
    private $url;
    private $usuario;
    private $pass;
    private $database;
    private $dbc;
    function __construct ($link='LOCALHOST',$user='root',$contraseña='',$data='bakeryproyecto') {
        $this->url=$link;
        $this->usuario=$user;
        $this->pass=$contraseña;
        $this->database=$data;
    }
    function conexion(){
        $this->dbc = mysqli_connect($this->url, $this->usuario, $this->pass, $this->database) or die('No se ha podido establecer la conexion');
    }
    function comprobarUsuario($user,$pass){
        $sentencia="select * from member where login='$user' and password='$pass'";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        if (mysqli_num_rows($resultSet) == 1){
            return true;
        }
        return false;
    }
    function cerrarConexion(){
        mysqli_close($this->dbc);
    }
    function devolverProductos(){
        $array=array();
        $sentencia="select * from product";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        while ($row=mysqli_fetch_array($resultSet)){
            array_push($array,array("id"=>$row['id'],"idfamily"=>$row['idfamily'],"product"=>$row['product'],"price"=>$row['price'],"description"=>$row['description']));
        }
        return $array;
    }
    function devolverCategorias(){
        $array=array();
        $sentencia="select * from family";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        while ($row=mysqli_fetch_array($resultSet)){
            array_push($array,array("id"=>$row['id'],"family"=>$row['family']));
        }
        return $array;
    }
     function devolverTickets(){
        $array=array();
        $sentencia="select * from ticket";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        if(mysqli_num_rows($resultSet)!=0){
            while ($row=mysqli_fetch_array($resultSet)){
                array_push($array,array("id"=>$row['id'],"date"=>$row['date'],"idmember"=>$row['idmember']));
            }
        }
        return $array;
    }
    function devolverTicketsDetail(){
        $array=array();
        $sentencia="select * from ticketdetail";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        if(mysqli_num_rows($resultSet)!=0){
            while ($row=mysqli_fetch_array($resultSet)){
                array_push($array,array("id"=>$row['id'],"idticket"=>$row['idticket'],"idproduct"=>$row['idproduct'],"quantity"=>$row['quantity'],"price"=>$row['price']));
            }
        }
        return $array;
    }
    function subirTicket($usuario,$cuerpo){
        $sentencia="select * from member where login='$usuario'";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        $row=mysqli_fetch_array($resultSet);
        $id=$row['id'];
        $fecha=strftime( "%Y-%m-%d %H:%M:%S", time() );
        $sentencia="insert into ticket (date,idmember) values('$fecha',$id)";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        $sentencia="select id from ticket where date='$fecha'";
        $resultSet = mysqli_query($this->dbc, $sentencia);
        $row=mysqli_fetch_array($resultSet);
        $id=$row['id'];
        foreach($cuerpo as $objeto){
            $sentencia="select id from product where product='".$objeto['name']."'";
            $resultSet = mysqli_query($this->dbc, $sentencia);
            $row=mysqli_fetch_array($resultSet);
            $idproduct=$row['id'];
            $quantity=$objeto['amount'];
            $price=$objeto['price'];
            $sentencia="insert into ticketdetail (idticket, idproduct, quantity, price) values($id,$idproduct,$quantity,'$price')";
            $resultSet = mysqli_query($this->dbc, $sentencia);
        }
        
        
    }
    
}