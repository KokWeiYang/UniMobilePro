<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_GET['email'];
    $otp2 = $_GET['key'];
    $pass = $_GET['newpass'];
    $newpass = sha1($pass);
    
    $sql = "SELECT * FROM tbl_user WHERE email = '$email' AND otp2='$otp2'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_user SET otp2 = 0, password = '$newpass'  WHERE email = '$email'";
        if ($conn->query($sqlupdate) === TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }   
    }else{
        echo "failed";
    }
    
    
?>