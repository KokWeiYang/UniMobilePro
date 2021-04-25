<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/269971/countmee/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/269971/countmee/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/269971/countmee/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp1 = rand(1000,9999);
$otp2 = 0;
$address = "";

$sqlregister = "INSERT INTO tbl_user(sname,email,password,otp1,otp2,address) VALUES('$name','$email','$passha1','$otp1','$otp2','$address')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($name,$email,$otp1);
}else{
    echo "failed";
}

function sendEmail($name,$email,$otp1){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug=0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host='mail.hubbuddies.com';                          //Set the SMTP server to send through
    $mail->SMTPAuth=true;                                           //Enable SMTP authentication
    $mail->Username='countmee@hubbuddies.com';                  //SMTP username
    $mail->Password='mj[X-](HUZO1';                                 //SMTP password
    $mail->SMTPSecure='tls';         
    $mail->Port=587;
    
    $from = "countmee@hubbuddies.com";
    $to = $email;
    $subject = "From CountMee. Please Verify your account";
    $message = "Hi $name, <br><br>
    
	            Welcome to use CountMee!<br><br>
	            
                Click the following link to verify your account<br><br>
                <a href='https://hubbuddies.com/269971/countmee/php/verify_account.php?email=".$email."&key=".$otp1."'>Click Here</a>
                ";
                
    $mail->setFrom($from,"CountMee");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}


?>